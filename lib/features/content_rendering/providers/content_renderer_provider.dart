import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:markbox/features/email_parser/models/email_content_type.dart';

part 'content_renderer_provider.g.dart';

/// 渲染状态枚举
enum RenderStatus {
  /// 初始状态
  initial,

  /// 加载中
  loading,

  /// 渲染成功
  success,

  /// 渲染失败
  error,
}

/// 内容渲染状态
class ContentRendererState {
  /// 当前内容
  final String? content;

  /// 内容类型
  final EmailContentType contentType;

  /// 渲染状态
  final RenderStatus renderStatus;

  /// 错误信息
  final String? errorMessage;

  const ContentRendererState({
    this.content,
    this.contentType = EmailContentType.unknown,
    this.renderStatus = RenderStatus.initial,
    this.errorMessage,
  });

  /// 复制并更新状态
  ContentRendererState copyWith({
    String? content,
    EmailContentType? contentType,
    RenderStatus? renderStatus,
    String? errorMessage,
    bool clearContent = false,
    bool clearError = false,
  }) {
    return ContentRendererState(
      content: clearContent ? null : (content ?? this.content),
      contentType: contentType ?? this.contentType,
      renderStatus: renderStatus ?? this.renderStatus,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  String toString() {
    return 'ContentRendererState(content: ${content?.length ?? 0} chars, '
        'contentType: $contentType, renderStatus: $renderStatus, '
        'errorMessage: $errorMessage)';
  }
}

/// 内容渲染 Provider
///
/// 管理内容渲染的状态，包括内容类型检测和渲染状态
@riverpod
class ContentRenderer extends _$ContentRenderer {
  @override
  ContentRendererState build() {
    return const ContentRendererState();
  }

  /// 设置内容并自动检测类型
  ///
  /// [content] 要渲染的内容
  /// [knownContentType] 已知的内容类型（可选），传入时跳过自动检测
  Future<void> setContent(
    String content, {
    EmailContentType? knownContentType,
  }) async {
    if (content.isEmpty) {
      state = state.copyWith(
        clearContent: true,
        contentType: EmailContentType.unknown,
        renderStatus: RenderStatus.initial,
        clearError: true,
      );
      return;
    }

    // 设置加载状态
    state = state.copyWith(
      content: content,
      renderStatus: RenderStatus.loading,
      clearError: true,
    );

    try {
      // 使用已知类型或自动检测
      final contentType = knownContentType ?? _detectContentType(content);

      // 更新状态为成功
      state = state.copyWith(
        contentType: contentType,
        renderStatus: RenderStatus.success,
      );
    } catch (e) {
      // 更新状态为失败
      state = state.copyWith(
        renderStatus: RenderStatus.error,
        errorMessage: '内容类型检测失败: $e',
      );
    }
  }

  /// 清空内容
  void clearContent() {
    state = const ContentRendererState();
  }

  /// 手动设置内容类型
  ///
  /// [contentType] 指定的内容类型
  void setContentType(EmailContentType contentType) {
    state = state.copyWith(contentType: contentType);
  }

  /// 检测内容类型
  ///
  /// 根据内容特征判断是 Markdown、HTML 还是纯文本
  EmailContentType _detectContentType(String content) {
    // 去除首尾空白
    final trimmedContent = content.trim();

    if (trimmedContent.isEmpty) {
      return EmailContentType.unknown;
    }

    // 1. 检查是否为 HTML（优先级最高）
    if (_isHtml(trimmedContent)) {
      return EmailContentType.html;
    }

    // 2. 检查是否为 Markdown
    if (_isMarkdown(trimmedContent)) {
      return EmailContentType.markdown;
    }

    // 3. 默认为纯文本
    return EmailContentType.plainText;
  }

  /// 判断是否为 HTML 内容
  ///
  /// 检查内容是否包含 HTML 标签
  bool _isHtml(String content) {
    // 转换为小写进行匹配
    final lowerContent = content.toLowerCase();

    // 1. 检查是否包含 DOCTYPE 声明（强特征）
    if (lowerContent.contains('<!doctype html')) {
      return true;
    }

    // 2. 检查是否包含 html 或 body 标签（强特征）
    if (lowerContent.contains('<html') || lowerContent.contains('<body')) {
      return true;
    }

    // 3. 检查是否包含常见的 HTML 结构标签（中等特征）
    final structuralTags = [
      '<div',
      '<span',
      '<p>',
      '<p ',
      '<table',
      '<ul',
      '<ol',
      '<header',
      '<footer',
      '<section',
      '<article',
    ];
    for (final tag in structuralTags) {
      if (lowerContent.contains(tag)) {
        return true;
      }
    }

    // 4. 检查是否包含闭合标签（弱特征，但比较可靠）
    final closeTagPattern = RegExp(r'</[a-zA-Z][a-zA-Z0-9]*>');
    final closeTagMatches = closeTagPattern.allMatches(content);
    // 如果有 2 个或以上的闭合标签，很可能是 HTML
    if (closeTagMatches.length >= 2) {
      return true;
    }

    // 5. 检查是否包含常见的 HTML 属性（弱特征）
    if (lowerContent.contains('class=') || lowerContent.contains('style=')) {
      return true;
    }

    return false;
  }

  /// 判断是否为 Markdown 内容
  ///
  /// 检查内容是否包含 Markdown 特征标记
  bool _isMarkdown(String content) {
    // Markdown 特征标记
    int markdownScore = 0;

    // 1. 检查标题标记 (# ## ### 等)
    final headingPattern = RegExp(r'^#{1,6}\s+.+$', multiLine: true);
    final headingMatches = headingPattern.allMatches(content);
    markdownScore += headingMatches.length * 2;

    // 2. 检查列表标记 (- * + 或 1. 2. 等)
    final unorderedListPattern = RegExp(r'^[\s]*[-*+]\s+.+$', multiLine: true);
    final orderedListPattern = RegExp(r'^[\s]*\d+\.\s+.+$', multiLine: true);
    markdownScore += unorderedListPattern.allMatches(content).length;
    markdownScore += orderedListPattern.allMatches(content).length;

    // 3. 检查代码块 (``` 或 ~~~)
    final codeBlockPattern = RegExp(r'```[\s\S]*?```');
    final codeBlockMatches = codeBlockPattern.allMatches(content);
    markdownScore += codeBlockMatches.length * 3;

    // 4. 检查行内代码 (`code`)
    final inlineCodePattern = RegExp(r'`[^`]+`');
    markdownScore += inlineCodePattern.allMatches(content).length;

    // 5. 检查强调标记 (**bold** *italic* ~~strike~~)
    final boldPattern = RegExp(r'\*\*[^*]+\*\*');
    final italicPattern = RegExp(
      r'(?<!\*)\*(?!\*)([^*]+)(?<!\*)\*(?!\*)',
    ); // 改进：避免匹配 HTML 标签
    final strikePattern = RegExp(r'~~[^~]+~~');
    markdownScore += boldPattern.allMatches(content).length;
    markdownScore += italicPattern.allMatches(content).length;
    markdownScore += strikePattern.allMatches(content).length;

    // 6. 检查链接标记 [text](url)
    final linkPattern = RegExp(r'\[.+?\]\(.+?\)');
    markdownScore += linkPattern.allMatches(content).length * 2;

    // 7. 检查图片标记 ![alt](url)
    final imagePattern = RegExp(r'!\[.+?\]\(.+?\)');
    markdownScore += imagePattern.allMatches(content).length * 2;

    // 8. 检查引用标记 (> text)
    final blockquotePattern = RegExp(r'^>\s+.+$', multiLine: true);
    markdownScore += blockquotePattern.allMatches(content).length;

    // 9. 检查水平分割线 (--- *** ___)
    final hrPattern = RegExp(r'^[-*_]{3,}$', multiLine: true);
    markdownScore += hrPattern.allMatches(content).length * 2;

    // 10. 检查表格标记 (| column |)
    final tablePattern = RegExp(r'\|.+\|');
    markdownScore += tablePattern.allMatches(content).length;

    // 如果 Markdown 特征分数达到阈值，则认为是 Markdown
    // 阈值设为 5，提高准确性，避免误判
    return markdownScore >= 5;
  }
}
