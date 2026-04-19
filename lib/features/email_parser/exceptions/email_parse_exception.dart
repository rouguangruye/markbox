/// 邮件解析异常基类
///
/// 所有邮件解析相关的异常都应继承此类
/// 提供统一的错误码、错误消息和原始异常信息管理
class EmailParseException implements Exception {
  /// 错误码
  ///
  /// 用于标识具体的错误类型，便于程序化处理
  /// 格式：EP_XXX_XXX（例如：EP_MIME_PARSE_ERROR）
  final String errorCode;

  /// 错误消息
  ///
  /// 用户友好的错误描述信息
  final String message;

  /// 原始异常
  ///
  /// 捕获的底层异常，用于调试和日志记录
  final Object? originalError;

  /// 堆栈跟踪
  ///
  /// 原始异常的堆栈信息
  final StackTrace? stackTrace;

  /// 构造函数
  ///
  /// [errorCode] 错误码
  /// [message] 错误消息
  /// [originalError] 原始异常（可选）
  /// [stackTrace] 堆栈跟踪（可选）
  const EmailParseException({
    required this.errorCode,
    required this.message,
    this.originalError,
    this.stackTrace,
  });

  /// 获取用户友好的错误信息
  ///
  /// 返回适合展示给用户的错误描述
  String get userFriendlyMessage => message;

  /// 获取详细的调试信息
  ///
  /// 包含错误码、错误消息、原始异常和堆栈信息
  /// 用于日志记录和调试
  String get debugInfo {
    final buffer = StringBuffer();
    buffer.writeln('EmailParseException:');
    buffer.writeln('  错误码: $errorCode');
    buffer.writeln('  错误消息: $message');
    if (originalError != null) {
      buffer.writeln('  原始异常: $originalError');
    }
    if (stackTrace != null) {
      buffer.writeln('  堆栈跟踪:');
      buffer.writeln(
        stackTrace.toString().split('\n').map((line) => '    $line').join('\n'),
      );
    }
    return buffer.toString();
  }

  @override
  String toString() {
    return 'EmailParseException($errorCode): $message';
  }

  /// 转换为 Map
  ///
  /// 用于序列化和日志记录
  Map<String, dynamic> toMap() {
    return {
      'errorCode': errorCode,
      'message': message,
      'originalError': originalError?.toString(),
      'stackTrace': stackTrace?.toString(),
    };
  }
}
