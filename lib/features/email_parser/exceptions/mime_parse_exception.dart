import 'email_parse_exception.dart';

/// MIME 解析异常
///
/// 当解析 MIME 格式邮件内容时发生错误时抛出
/// 包括：MIME 结构解析、Content-Type 解析、Boundary 解析等
class MimeParseException extends EmailParseException {
  /// MIME 类型
  ///
  /// 发生错误的 MIME 类型，例如：multipart/mixed, text/plain 等
  final String? mimeType;

  /// Boundary 字符串
  ///
  /// MIME 分隔符，用于调试
  final String? boundary;

  /// 构造函数
  ///
  /// [message] 错误消息
  /// [mimeType] MIME 类型（可选）
  /// [boundary] Boundary 字符串（可选）
  /// [originalError] 原始异常（可选）
  /// [stackTrace] 堆栈跟踪（可选）
  const MimeParseException({
    required super.message,
    this.mimeType,
    this.boundary,
    super.originalError,
    super.stackTrace,
  }) : super(errorCode: 'EP_MIME_PARSE_ERROR');

  /// 创建 MIME 结构解析异常
  factory MimeParseException.invalidStructure({
    String? mimeType,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return MimeParseException(
      message: 'MIME 结构无效，无法解析邮件内容',
      mimeType: mimeType,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// 创建 Boundary 缺失异常
  factory MimeParseException.missingBoundary({
    String? mimeType,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return MimeParseException(
      message: 'MIME Boundary 缺失，无法分隔多部分内容',
      mimeType: mimeType,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// 创建 Content-Type 解析异常
  factory MimeParseException.invalidContentType({
    String? mimeType,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return MimeParseException(
      message: 'Content-Type 解析失败，格式无效',
      mimeType: mimeType,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// 创建 MIME 版本不兼容异常
  factory MimeParseException.unsupportedVersion({
    String? mimeType,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return MimeParseException(
      message: '不支持的 MIME 版本',
      mimeType: mimeType,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  @override
  String get debugInfo {
    final buffer = StringBuffer();
    buffer.writeln('MimeParseException:');
    buffer.writeln('  错误码: $errorCode');
    buffer.writeln('  错误消息: $message');
    if (mimeType != null) {
      buffer.writeln('  MIME 类型: $mimeType');
    }
    if (boundary != null) {
      buffer.writeln('  Boundary: $boundary');
    }
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
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map['mimeType'] = mimeType;
    map['boundary'] = boundary;
    return map;
  }
}
