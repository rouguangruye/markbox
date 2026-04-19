import 'dart:async';
import 'dart:io';

import 'package:enough_mail/enough_mail.dart';
import 'package:flutter/foundation.dart';

import '../shared/models/email.dart';
import '../shared/models/imap_config.dart';
import '../features/email_parser/models/email_content_type.dart';
import '../features/email_parser/services/mime_parser.dart';

/// 邮件服务错误类型
enum EmailServiceErrorType {
  /// 网络连接错误
  networkError,

  /// IMAP 连接断开
  connectionLost,

  /// 数据解析失败
  parseError,

  /// 认证失败
  authenticationFailed,

  /// 超时错误
  timeoutError,

  /// 未知错误
  unknown,
}

/// 邮件服务异常
class EmailServiceException implements Exception {
  /// 错误消息
  final String message;

  /// 错误类型
  final EmailServiceErrorType errorType;

  /// 原始异常
  final dynamic originalError;

  EmailServiceException(
    this.message, {
    this.errorType = EmailServiceErrorType.unknown,
    this.originalError,
  });

  @override
  String toString() => 'EmailServiceException: $message';
}

/// 邮件获取结果
class FetchEmailsResult {
  /// 邮件列表
  final List<Email> emails;

  /// 是否有更多数据
  final bool hasMore;

  /// 总数量（如果服务器支持）
  final int? totalCount;

  FetchEmailsResult({
    required this.emails,
    required this.hasMore,
    this.totalCount,
  });
}

/// 邮件服务
///
/// 封装 IMAP 邮件获取逻辑，提供分页获取邮件的功能
class EmailService {
  /// IMAP 客户端实例
  ImapClient? _client;

  /// 当前连接的配置
  ImapConfig? _currentConfig;

  /// 连接超时时间（毫秒）
  static const int connectionTimeoutMs = 10000;

  /// 操作超时时间（毫秒）
  static const int operationTimeoutMs = 30000;

  /// 默认每页邮件数量
  static const int defaultPageSize = 50;

  /// 连接到 IMAP 服务器
  ///
  /// [config] IMAP 配置信息
  /// 如果已经连接到相同的配置，则复用现有连接
  Future<void> connect(ImapConfig config) async {
    // 如果已经连接到相同的配置，直接返回
    if (_client != null &&
        _currentConfig != null &&
        _currentConfig!.server == config.server &&
        _currentConfig!.email == config.email) {
      // 检查连接是否仍然有效
      if (_client!.isConnected) {
        return;
      }
    }

    // 断开现有连接
    await disconnect();

    // 创建新的客户端
    _client = ImapClient(isLogEnabled: kDebugMode);

    try {
      debugPrint('开始连接 IMAP 服务器: ${config.server}:${config.port}');

      // 连接到服务器
      await _client!
          .connectToServer(config.server, config.port, isSecure: config.useSSL)
          .timeout(
            const Duration(milliseconds: connectionTimeoutMs),
            onTimeout: () {
              throw TimeoutException('连接超时');
            },
          );

      debugPrint('IMAP 服务器连接成功');

      // 登录认证
      await _client!.login(config.email, config.password);

      debugPrint('IMAP 认证成功');

      // 保存当前配置
      _currentConfig = config;
    } catch (e) {
      // 连接失败，清理资源
      await disconnect();
      rethrow;
    }
  }

  /// 断开 IMAP 连接
  Future<void> disconnect() async {
    if (_client != null) {
      try {
        if (_client!.isConnected) {
          await _client!.logout();
        }
      } catch (e) {
        debugPrint('断开连接时出错: $e');
      } finally {
        _client = null;
        _currentConfig = null;
      }
    }
  }

  /// 检查连接状态
  bool get isConnected => _client?.isConnected ?? false;

  /// 获取邮件列表
  ///
  /// [config] IMAP 配置信息
  /// [page] 页码，从 1 开始
  /// [pageSize] 每页数量，默认 50
  /// [mailbox] 邮箱文件夹名称，默认为 INBOX
  /// 返回邮件列表和分页信息
  Future<FetchEmailsResult> fetchEmails({
    required ImapConfig config,
    int page = 1,
    int pageSize = defaultPageSize,
    String mailbox = 'INBOX',
  }) async {
    // 参数验证
    if (page < 1) {
      throw EmailServiceException(
        '页码必须大于等于 1',
        errorType: EmailServiceErrorType.parseError,
      );
    }

    if (pageSize < 1 || pageSize > 1000) {
      throw EmailServiceException(
        '每页数量必须在 1-1000 之间',
        errorType: EmailServiceErrorType.parseError,
      );
    }

    try {
      // 确保已连接
      await connect(config);

      // 选择邮箱文件夹
      final mailboxResult = await _client!
          .selectMailboxByPath(mailbox)
          .timeout(
            const Duration(milliseconds: operationTimeoutMs),
            onTimeout: () {
              throw TimeoutException('选择邮箱超时');
            },
          );

      // 获取邮件总数
      final totalCount = mailboxResult.messagesExists;

      // 计算分页范围
      // IMAP 邮件序号是从 1 开始的，最新的邮件序号最大
      final startIndex = totalCount - (page - 1) * pageSize;
      final endIndex = startIndex - pageSize + 1;

      // 检查是否还有更多数据
      final hasMore = endIndex > 1;

      // 如果起始序号小于等于 0，说明没有数据了
      if (startIndex <= 0) {
        return FetchEmailsResult(
          emails: [],
          hasMore: false,
          totalCount: totalCount,
        );
      }

      // 确保结束序号不小于 1
      final actualEndIndex = endIndex < 1 ? 1 : endIndex;

      debugPrint('获取邮件: 序号 $actualEndIndex 到 $startIndex');

      // 获取邮件列表（按时间倒序）
      // 使用 fetchRecentMessages 获取最近的邮件
      // criteria 包含 ENVELOPE 和 INTERNALDATE 以确保获取邮件日期信息
      final fetchResult = await _client!
          .fetchRecentMessages(
            messageCount: startIndex,
            criteria: '(FLAGS ENVELOPE INTERNALDATE BODY.PEEK[])',
          )
          .timeout(
            const Duration(milliseconds: operationTimeoutMs),
            onTimeout: () {
              throw TimeoutException('获取邮件超时');
            },
          );

      // 转换为 Email 模型列表
      final emails = <Email>[];
      // fetchRecentMessages 返回的邮件是从最新到最旧排序的
      // 我们需要根据分页参数切片
      final messages = fetchResult.messages;

      // 计算切片范围
      // messages[0] 是最新的邮件
      // 我们需要获取从 (page-1)*pageSize 到 page*pageSize 的邮件
      final startOffset = (page - 1) * pageSize;
      final endOffset = startOffset + pageSize;

      for (int i = startOffset; i < endOffset && i < messages.length; i++) {
        try {
          final email = _convertToEmail(messages[i]);
          emails.add(email);
        } catch (e) {
          debugPrint('解析邮件失败: ${messages[i].sequenceId}, 错误: $e');
          // 跳过解析失败的邮件，继续处理下一封
        }
      }

      // 确保邮件按时间倒序排列（最新的在最前面）
      emails.sort((a, b) => b.date.compareTo(a.date));

      debugPrint('成功获取 ${emails.length} 封邮件');

      return FetchEmailsResult(
        emails: emails,
        hasMore: hasMore,
        totalCount: totalCount,
      );
    } on EmailServiceException {
      rethrow;
    } on SocketException catch (e) {
      throw EmailServiceException(
        '网络连接失败: ${e.message}',
        errorType: EmailServiceErrorType.networkError,
        originalError: e,
      );
    } on TimeoutException catch (e) {
      throw EmailServiceException(
        '操作超时: ${e.message}',
        errorType: EmailServiceErrorType.timeoutError,
        originalError: e,
      );
    } on ImapException catch (e) {
      // 检查是否是连接断开
      if (!_client!.isConnected) {
        throw EmailServiceException(
          'IMAP 连接已断开',
          errorType: EmailServiceErrorType.connectionLost,
          originalError: e,
        );
      }

      // 检查是否是认证失败
      final errorMessage = e.message?.toLowerCase() ?? '';
      if (errorMessage.contains('authentication') ||
          errorMessage.contains('login') ||
          errorMessage.contains('credentials')) {
        throw EmailServiceException(
          '认证失败: ${e.message}',
          errorType: EmailServiceErrorType.authenticationFailed,
          originalError: e,
        );
      }

      throw EmailServiceException(
        'IMAP 协议错误: ${e.message}',
        errorType: EmailServiceErrorType.unknown,
        originalError: e,
      );
    } catch (e) {
      throw EmailServiceException(
        '获取邮件失败: $e',
        errorType: EmailServiceErrorType.unknown,
        originalError: e,
      );
    }
  }

  /// 从邮件内容中提取纯文本预览
  ///
  /// [content] 原始邮件内容（可能是纯文本或 HTML）
  /// 返回清理后的纯文本预览，最多 100 个字符
  String? _extractPreviewText(String? content) {
    if (content == null || content.isEmpty) {
      return null;
    }

    String text = content;

    // 去除 HTML 标签
    text = text.replaceAll(
      RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false),
      '',
    );

    // 去除 DOCTYPE、XML 声明等
    text = text.replaceAll(
      RegExp(r'<!DOCTYPE[^>]*>', caseSensitive: false),
      '',
    );
    text = text.replaceAll(RegExp(r'<\?xml[^>]*\?>', caseSensitive: false), '');

    // 去除 HTML 实体
    text = text.replaceAll('&nbsp;', ' ');
    text = text.replaceAll('&amp;', '&');
    text = text.replaceAll('&lt;', '<');
    text = text.replaceAll('&gt;', '>');
    text = text.replaceAll('&quot;', '"');
    text = text.replaceAll('&#39;', "'");
    text = text.replaceAll(RegExp(r'&#\d+;'), '');

    // 去除多余的空白字符
    text = text.replaceAll(RegExp(r'\s+'), ' ');
    text = text.trim();

    // 截取前 100 个字符
    if (text.length > 100) {
      text = '${text.substring(0, 100)}...';
    }

    return text.isEmpty ? null : text;
  }

  /// 将 MimeMessage 转换为 Email 模型
  Email _convertToEmail(MimeMessage message) {
    // 获取邮件 ID（使用 sequenceId）
    final id =
        message.sequenceId?.toString() ??
        DateTime.now().millisecondsSinceEpoch.toString();

    // 获取发件人信息
    String? senderName;
    String senderEmail;

    final from = message.from;
    if (from != null && from.isNotEmpty) {
      final personalName = from.first.personalName;
      if (personalName != null && personalName.isNotEmpty) {
        senderName = personalName;
      }
      senderEmail = from.first.email;
    } else {
      senderEmail = 'unknown@unknown.com';
    }

    // 获取邮件主题
    final subject = message.decodeSubject() ?? '(无主题)';

    // 获取邮件日期
    DateTime date;
    try {
      date = message.decodeDate() ?? DateTime(1970, 1, 1);
      if (date.year == 1970) {
        debugPrint('警告: 邮件 ${message.sequenceId} 日期解析失败，使用默认日期');
      } else {
        debugPrint('邮件 ${message.sequenceId} 日期: $date');
      }
    } catch (e) {
      debugPrint('解析邮件日期异常: $e');
      date = DateTime(1970, 1, 1);
    }

    // 获取邮件内容
    // 使用 MimeParser 解析邮件内容，支持 Markdown 类型
    String? preview;
    String? body;
    EmailContentType contentType = EmailContentType.unknown;
    try {
      final parser = MimeParser();
      final parseResult = parser.parseMessage(message);

      if (parseResult.success && parseResult.content != null) {
        body = parseResult.content!.content;
        contentType = parseResult.content!.type;
        preview = _extractPreviewText(body);
        debugPrint('MimeParser 解析成功，内容类型: $contentType, 长度: ${body.length}');
      } else {
        debugPrint('MimeParser 解析失败: ${parseResult.errorMessage}');
        // 降级处理：使用 enough_mail 的默认方法
        final htmlPart = message.decodeTextHtmlPart();
        if (htmlPart != null) {
          body = htmlPart;
          preview = _extractPreviewText(htmlPart);
          contentType = EmailContentType.html;
        } else {
          final textPart = message.decodeTextPlainPart();
          if (textPart != null) {
            body = textPart;
            preview = _extractPreviewText(textPart);
            contentType = EmailContentType.plainText;
          }
        }
      }
    } catch (e) {
      debugPrint('解析邮件内容失败: $e');
    }

    // 检查是否已读（有 \Seen 标志表示已读）
    final isRead = message.hasFlag(MessageFlags.seen);

    // 保存原始 MIME 内容（用于 MimeMessageViewer 渲染）
    final mimeMessageRaw = message.renderMessage();

    return Email(
      id: id,
      senderName: senderName,
      senderEmail: senderEmail,
      subject: subject,
      date: date,
      preview: preview,
      body: body,
      contentType: contentType,
      isRead: isRead,
      mimeMessageRaw: mimeMessageRaw,
    );
  }

  /// 获取单封邮件详情
  ///
  /// [config] IMAP 配置信息
  /// [messageId] 邮件 ID
  /// [mailbox] 邮箱文件夹名称，默认为 INBOX
  Future<Email> fetchEmailDetail({
    required ImapConfig config,
    required String messageId,
    String mailbox = 'INBOX',
  }) async {
    try {
      // 确保已连接
      await connect(config);

      // 选择邮箱文件夹
      await _client!.selectMailboxByPath(mailbox);

      // 根据邮件 ID 获取邮件
      final sequenceId = int.tryParse(messageId);
      if (sequenceId == null) {
        throw EmailServiceException(
          '无效的邮件 ID',
          errorType: EmailServiceErrorType.parseError,
        );
      }

      // 获取邮件（使用 BODY[] 而非 BODY.PEEK[]，自动触发 \Seen 标志）
      final fetchResult = await _client!.fetchMessage(
        sequenceId,
        '(FLAGS BODY[])',
      );

      if (fetchResult.messages.isEmpty) {
        throw EmailServiceException(
          '邮件不存在',
          errorType: EmailServiceErrorType.parseError,
        );
      }

      // 转换为 Email 模型
      return _convertToEmail(fetchResult.messages.first);
    } on EmailServiceException {
      rethrow;
    } catch (e) {
      throw EmailServiceException(
        '获取邮件详情失败: $e',
        errorType: EmailServiceErrorType.unknown,
        originalError: e,
      );
    }
  }

  /// 标记邮件为已读
  ///
  /// [config] IMAP 配置信息
  /// [messageId] 邮件 ID
  /// [mailbox] 邮箱文件夹名称，默认为 INBOX
  Future<void> markAsRead({
    required ImapConfig config,
    required String messageId,
    String mailbox = 'INBOX',
  }) async {
    try {
      // 确保已连接
      await connect(config);

      // 选择邮箱文件夹
      await _client!.selectMailboxByPath(mailbox);

      // 根据邮件 ID 标记为已读
      final sequenceId = int.tryParse(messageId);
      if (sequenceId == null) {
        throw EmailServiceException(
          '无效的邮件 ID',
          errorType: EmailServiceErrorType.parseError,
        );
      }

      // 标记为已读
      await _client!.store(MessageSequence.fromId(sequenceId), [
        MessageFlags.seen,
      ], action: StoreAction.add);
    } on EmailServiceException {
      rethrow;
    } catch (e) {
      throw EmailServiceException(
        '标记邮件已读失败: $e',
        errorType: EmailServiceErrorType.unknown,
        originalError: e,
      );
    }
  }

  /// 删除邮件
  ///
  /// [config] IMAP 配置信息
  /// [messageId] 邮件 ID
  /// [mailbox] 邮箱文件夹名称，默认为 INBOX
  /// 删除操作会先标记邮件为 \Deleted，然后执行 expunge 永久删除
  Future<void> deleteEmail({
    required ImapConfig config,
    required String messageId,
    String mailbox = 'INBOX',
  }) async {
    try {
      // 确保已连接
      await connect(config);

      // 选择邮箱文件夹
      await _client!.selectMailboxByPath(mailbox);

      // 解析邮件 ID
      final sequenceId = int.tryParse(messageId);
      if (sequenceId == null) {
        throw EmailServiceException(
          '无效的邮件 ID',
          errorType: EmailServiceErrorType.parseError,
        );
      }

      // 标记邮件为删除
      await _client!.store(MessageSequence.fromId(sequenceId), [
        MessageFlags.deleted,
      ], action: StoreAction.add);

      // 执行 expunge 永久删除
      await _client!.expunge();

      debugPrint('邮件 $messageId 已删除');
    } on EmailServiceException {
      rethrow;
    } on SocketException catch (e) {
      throw EmailServiceException(
        '网络连接失败: ${e.message}',
        errorType: EmailServiceErrorType.networkError,
        originalError: e,
      );
    } on TimeoutException catch (e) {
      throw EmailServiceException(
        '操作超时: ${e.message}',
        errorType: EmailServiceErrorType.timeoutError,
        originalError: e,
      );
    } on ImapException catch (e) {
      // 检查是否是连接断开
      if (_client != null && !_client!.isConnected) {
        throw EmailServiceException(
          'IMAP 连接已断开',
          errorType: EmailServiceErrorType.connectionLost,
          originalError: e,
        );
      }

      throw EmailServiceException(
        '删除邮件失败: ${e.message}',
        errorType: EmailServiceErrorType.unknown,
        originalError: e,
      );
    } catch (e) {
      throw EmailServiceException(
        '删除邮件失败: $e',
        errorType: EmailServiceErrorType.unknown,
        originalError: e,
      );
    }
  }
}
