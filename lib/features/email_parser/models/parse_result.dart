import 'parsed_content.dart';

/// 解析结果模型
///
/// 用于封装邮件内容解析的结果，支持成功和失败两种状态
class ParseResult {
  /// 是否解析成功
  final bool success;

  /// 解析后的内容（成功时有值）
  final ParsedContent? content;

  /// 错误信息（失败时有值）
  final String? errorMessage;

  /// 错误类型
  final ParseErrorType? errorType;

  const ParseResult({
    required this.success,
    this.content,
    this.errorMessage,
    this.errorType,
  });

  /// 创建成功结果
  factory ParseResult.success(ParsedContent content) {
    return ParseResult(success: true, content: content);
  }

  /// 创建失败结果
  factory ParseResult.failure({
    required String errorMessage,
    ParseErrorType? errorType,
  }) {
    return ParseResult(
      success: false,
      errorMessage: errorMessage,
      errorType: errorType ?? ParseErrorType.unknown,
    );
  }

  @override
  String toString() {
    if (success) {
      return 'ParseResult(success: true, type: ${content?.type})';
    }
    return 'ParseResult(success: false, errorType: $errorType, errorMessage: $errorMessage)';
  }
}

/// 解析错误类型枚举
enum ParseErrorType {
  /// 编码错误（无法解码内容）
  encodingError,

  /// 格式错误（内容格式不正确）
  formatError,

  /// 内容为空
  emptyContent,

  /// 不支持的内容类型
  unsupportedType,

  /// 未知错误
  unknown,
}

/// 解析错误类型扩展方法
extension ParseErrorTypeExtension on ParseErrorType {
  /// 获取用户友好的错误提示
  String get userFriendlyMessage {
    switch (this) {
      case ParseErrorType.encodingError:
        return '内容编码错误，无法正确解码邮件内容';
      case ParseErrorType.formatError:
        return '邮件内容格式不正确，解析失败';
      case ParseErrorType.emptyContent:
        return '邮件内容为空';
      case ParseErrorType.unsupportedType:
        return '不支持的内容类型，无法解析';
      case ParseErrorType.unknown:
        return '解析过程中发生未知错误';
    }
  }
}
