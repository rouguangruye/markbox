import 'email_parse_exception.dart';

/// 解码异常
///
/// 当解码邮件内容时发生错误时抛出
/// 包括：Base64 解码、Quoted-Printable 解码、字符编码转换等
class DecodeException extends EmailParseException {
  /// 编码类型
  ///
  /// 发生错误的编码类型，例如：base64, quoted-printable, utf-8 等
  final String? encodingType;

  /// 原始数据长度
  ///
  /// 待解码数据的长度，用于调试
  final int? dataLength;

  /// 构造函数
  ///
  /// [message] 错误消息
  /// [encodingType] 编码类型（可选）
  /// [dataLength] 原始数据长度（可选）
  /// [originalError] 原始异常（可选）
  /// [stackTrace] 堆栈跟踪（可选）
  const DecodeException({
    required super.message,
    this.encodingType,
    this.dataLength,
    super.originalError,
    super.stackTrace,
  }) : super(errorCode: 'EP_DECODE_ERROR');

  /// 创建 Base64 解码异常
  factory DecodeException.base64({
    int? dataLength,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return DecodeException(
      message: 'Base64 解码失败，数据格式无效',
      encodingType: 'base64',
      dataLength: dataLength,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// 创建 Quoted-Printable 解码异常
  factory DecodeException.quotedPrintable({
    int? dataLength,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return DecodeException(
      message: 'Quoted-Printable 解码失败，数据格式无效',
      encodingType: 'quoted-printable',
      dataLength: dataLength,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// 创建字符编码转换异常
  factory DecodeException.charset({
    String? encodingType,
    int? dataLength,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return DecodeException(
      message: '字符编码转换失败，不支持的编码类型',
      encodingType: encodingType,
      dataLength: dataLength,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// 创建 UUEncode 解码异常
  factory DecodeException.uuencode({
    int? dataLength,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return DecodeException(
      message: 'UUEncode 解码失败，数据格式无效',
      encodingType: 'uuencode',
      dataLength: dataLength,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// 创建未知编码类型异常
  factory DecodeException.unknownEncoding({
    String? encodingType,
    int? dataLength,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return DecodeException(
      message: '未知的编码类型: ${encodingType ?? "未知"}',
      encodingType: encodingType,
      dataLength: dataLength,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  @override
  String get debugInfo {
    final buffer = StringBuffer();
    buffer.writeln('DecodeException:');
    buffer.writeln('  错误码: $errorCode');
    buffer.writeln('  错误消息: $message');
    if (encodingType != null) {
      buffer.writeln('  编码类型: $encodingType');
    }
    if (dataLength != null) {
      buffer.writeln('  数据长度: $dataLength');
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
    map['encodingType'] = encodingType;
    map['dataLength'] = dataLength;
    return map;
  }
}
