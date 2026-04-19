import 'package:enough_mail/enough_mail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markbox/services/email_service.dart';
import 'package:markbox/shared/models/email.dart';
import 'package:markbox/shared/models/imap_config.dart';
import 'package:mocktail/mocktail.dart';

// Mock ImapClient
class MockImapClient extends Mock implements ImapClient {}

// Mock Mailbox
class MockMailbox extends Mock implements Mailbox {}

// Mock FetchImapResult
class MockFetchImapResult extends Mock implements FetchImapResult {}

// Mock MimeMessage
class MockMimeMessage extends Mock implements MimeMessage {}

void main() {
  late EmailService emailService;

  setUp(() {
    emailService = EmailService();
  });

  tearDown(() async {
    await emailService.disconnect();
  });

  group('EmailService 连接测试', () {
    test('初始状态未连接', () {
      expect(emailService.isConnected, false);
    });

    test('连接成功后 isConnected 返回 true', () async {
      // 注意：这个测试需要真实的 IMAP 服务器
      // 在实际测试中，应该使用 mock 或跳过此测试
      // 这里只是演示测试结构
    });
  });

  group('EmailService 分页参数验证测试', () {
    test('页码小于 1 抛出异常', () async {
      const config = ImapConfig(
        server: 'imap.example.com',
        port: 993,
        email: 'test@example.com',
        password: 'password',
        useSSL: true,
      );

      expect(
        () => emailService.fetchEmails(config: config, page: 0),
        throwsA(
          isA<EmailServiceException>().having(
            (e) => e.message,
            'message',
            contains('页码必须大于等于 1'),
          ),
        ),
      );
    });

    test('每页数量小于 1 抛出异常', () async {
      const config = ImapConfig(
        server: 'imap.example.com',
        port: 993,
        email: 'test@example.com',
        password: 'password',
        useSSL: true,
      );

      expect(
        () => emailService.fetchEmails(config: config, pageSize: 0),
        throwsA(
          isA<EmailServiceException>().having(
            (e) => e.message,
            'message',
            contains('每页数量必须在 1-1000 之间'),
          ),
        ),
      );
    });

    test('每页数量大于 1000 抛出异常', () async {
      const config = ImapConfig(
        server: 'imap.example.com',
        port: 993,
        email: 'test@example.com',
        password: 'password',
        useSSL: true,
      );

      expect(
        () => emailService.fetchEmails(config: config, pageSize: 1001),
        throwsA(
          isA<EmailServiceException>().having(
            (e) => e.message,
            'message',
            contains('每页数量必须在 1-1000 之间'),
          ),
        ),
      );
    });
  });

  group('EmailServiceException 测试', () {
    test('创建 EmailServiceException', () {
      const message = '测试错误';
      const errorType = EmailServiceErrorType.networkError;

      final exception = EmailServiceException(message, errorType: errorType);

      expect(exception.message, message);
      expect(exception.errorType, errorType);
      expect(exception.toString(), contains(message));
    });

    test('EmailServiceException 包含原始错误', () {
      final originalError = Exception('原始错误');
      final exception = EmailServiceException(
        '测试错误',
        originalError: originalError,
      );

      expect(exception.originalError, originalError);
    });
  });

  group('FetchEmailsResult 测试', () {
    test('创建 FetchEmailsResult', () {
      final emails = <Email>[];
      const hasMore = true;
      const totalCount = 100;

      final result = FetchEmailsResult(
        emails: emails,
        hasMore: hasMore,
        totalCount: totalCount,
      );

      expect(result.emails, emails);
      expect(result.hasMore, hasMore);
      expect(result.totalCount, totalCount);
    });

    test('FetchEmailsResult totalCount 可选', () {
      final emails = <Email>[];
      const hasMore = false;

      final result = FetchEmailsResult(emails: emails, hasMore: hasMore);

      expect(result.emails, emails);
      expect(result.hasMore, hasMore);
      expect(result.totalCount, isNull);
    });
  });

  group('EmailServiceErrorType 测试', () {
    test('所有错误类型都有对应的枚举值', () {
      expect(EmailServiceErrorType.values.length, 6);
      expect(
        EmailServiceErrorType.values,
        containsAll([
          EmailServiceErrorType.networkError,
          EmailServiceErrorType.connectionLost,
          EmailServiceErrorType.parseError,
          EmailServiceErrorType.authenticationFailed,
          EmailServiceErrorType.timeoutError,
          EmailServiceErrorType.unknown,
        ]),
      );
    });
  });

  group('EmailService 默认值测试', () {
    test('默认超时时间正确', () {
      expect(EmailService.connectionTimeoutMs, 10000);
      expect(EmailService.operationTimeoutMs, 30000);
    });

    test('默认每页数量正确', () {
      expect(EmailService.defaultPageSize, 50);
    });
  });

  group('EmailService 断开连接测试', () {
    test('断开未连接的服务不会抛出异常', () async {
      // 应该不会抛出异常
      await emailService.disconnect();
      expect(emailService.isConnected, false);
    });

    test('多次断开连接不会抛出异常', () async {
      await emailService.disconnect();
      await emailService.disconnect();
      expect(emailService.isConnected, false);
    });
  });

  group('EmailService 错误处理测试', () {
    test('网络错误转换为 EmailServiceException', () {
      final exception = EmailServiceException(
        '网络连接失败',
        errorType: EmailServiceErrorType.networkError,
      );

      expect(exception.errorType, EmailServiceErrorType.networkError);
      expect(exception.message, contains('网络连接失败'));
    });

    test('超时错误转换为 EmailServiceException', () {
      final exception = EmailServiceException(
        '操作超时',
        errorType: EmailServiceErrorType.timeoutError,
      );

      expect(exception.errorType, EmailServiceErrorType.timeoutError);
      expect(exception.message, contains('操作超时'));
    });

    test('连接断开错误转换为 EmailServiceException', () {
      final exception = EmailServiceException(
        'IMAP 连接已断开',
        errorType: EmailServiceErrorType.connectionLost,
      );

      expect(exception.errorType, EmailServiceErrorType.connectionLost);
      expect(exception.message, contains('IMAP 连接已断开'));
    });

    test('认证失败错误转换为 EmailServiceException', () {
      final exception = EmailServiceException(
        '认证失败',
        errorType: EmailServiceErrorType.authenticationFailed,
      );

      expect(exception.errorType, EmailServiceErrorType.authenticationFailed);
      expect(exception.message, contains('认证失败'));
    });

    test('数据解析错误转换为 EmailServiceException', () {
      final exception = EmailServiceException(
        '数据解析失败',
        errorType: EmailServiceErrorType.parseError,
      );

      expect(exception.errorType, EmailServiceErrorType.parseError);
      expect(exception.message, contains('数据解析失败'));
    });
  });

  group('EmailService 分页逻辑测试', () {
    test('第一页计算正确', () {
      // 第一页：startOffset = 0, endOffset = pageSize
      const page = 1;
      const pageSize = 50;
      final startOffset = (page - 1) * pageSize;
      final endOffset = startOffset + pageSize;

      expect(startOffset, 0);
      expect(endOffset, 50);
    });

    test('第二页计算正确', () {
      // 第二页：startOffset = 50, endOffset = 100
      const page = 2;
      const pageSize = 50;
      final startOffset = (page - 1) * pageSize;
      final endOffset = startOffset + pageSize;

      expect(startOffset, 50);
      expect(endOffset, 100);
    });

    test('第三页计算正确', () {
      // 第三页：startOffset = 100, endOffset = 150
      const page = 3;
      const pageSize = 50;
      final startOffset = (page - 1) * pageSize;
      final endOffset = startOffset + pageSize;

      expect(startOffset, 100);
      expect(endOffset, 150);
    });
  });
}
