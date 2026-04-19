/// 邮件内容类型枚举
///
/// 定义邮件内容的不同格式类型
enum EmailContentType {
  /// Markdown 格式
  markdown,

  /// HTML 格式
  html,

  /// 纯文本格式
  plainText,

  /// 未知格式
  unknown,
}

/// 邮件内容类型扩展方法
extension EmailContentTypeExtension on EmailContentType {
  /// 获取内容类型的显示名称
  String get displayName {
    switch (this) {
      case EmailContentType.markdown:
        return 'Markdown';
      case EmailContentType.html:
        return 'HTML';
      case EmailContentType.plainText:
        return '纯文本';
      case EmailContentType.unknown:
        return '未知';
    }
  }

  /// 获取内容类型的 MIME 类型
  String get mimeType {
    switch (this) {
      case EmailContentType.markdown:
        return 'text/markdown';
      case EmailContentType.html:
        return 'text/html';
      case EmailContentType.plainText:
        return 'text/plain';
      case EmailContentType.unknown:
        return 'application/octet-stream';
    }
  }
}
