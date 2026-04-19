import 'email_parse_exception.dart';

/// 邮件头解析异常
///
/// 当解析邮件头信息时发生错误时抛出
/// 包括：Subject、From、To、Date 等字段的解析错误
class HeaderParseException extends EmailParseException {
  /// 字段名称
  ///
  /// 发生错误的邮件头字段名称
  final String? fieldName;

  /// 字段值
  ///
  /// 发生错误的字段原始值（可能为空）
  final String? fieldValue;

  /// 构造函数
  ///
  /// [message] 错误消息
  /// [fieldName] 字段名称（可选）
  /// [fieldValue] 字段值（可选）
  /// [originalError] 原始异常（可选）
  /// [stackTrace] 堆栈跟踪（可选）
  const HeaderParseException({
    required super.message,
    this.fieldName,
    this.fieldValue,
    super.originalError,
    super.stackTrace,
  }) : super(errorCode: 'EP_HEADER_PARSE_ERROR');

  /// 创建字段缺失异常
  factory HeaderParseException.missingField({
    required String fieldName,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return HeaderParseException(
      message: '邮件头字段 "$fieldName" 缺失',
      fieldName: fieldName,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// 创建字段格式错误异常
  factory HeaderParseException.invalidFormat({
    required String fieldName,
    String? fieldValue,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return HeaderParseException(
      message: '邮件头字段 "$fieldName" 格式无效',
      fieldName: fieldName,
      fieldValue: fieldValue,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// 创建地址解析异常
  factory HeaderParseException.invalidAddress({
    required String fieldName,
    String? fieldValue,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return HeaderParseException(
      message: '邮件头字段 "$fieldName" 中的邮件地址格式无效',
      fieldName: fieldName,
      fieldValue: fieldValue,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// 创建日期解析异常
  factory HeaderParseException.invalidDate({
    String? fieldValue,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return HeaderParseException(
      message: '邮件日期格式无效，无法解析',
      fieldName: 'Date',
      fieldValue: fieldValue,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  @override
  String get debugInfo {
    final buffer = StringBuffer();
    buffer.writeln('HeaderParseException:');
    buffer.writeln('  错误码: $errorCode');
    buffer.writeln('  错误消息: $message');
    if (fieldName != null) {
      buffer.writeln('  字段名称: $fieldName');
    }
    if (fieldValue != null) {
      buffer.writeln('  字段值: $fieldValue');
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
    map['fieldName'] = fieldName;
    map['fieldValue'] = fieldValue;
    return map;
  }
}
