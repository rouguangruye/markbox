import 'email_parse_exception.dart';

/// 附件处理异常
///
/// 当处理邮件附件时发生错误时抛出
/// 包括：附件下载、保存、读取等错误
class AttachmentException extends EmailParseException {
  /// 附件文件名
  ///
  /// 发生错误的附件文件名
  final String? fileName;

  /// 附件大小（字节）
  ///
  /// 附件的文件大小
  final int? fileSize;

  /// 附件内容类型
  ///
  /// 附件的 MIME 类型
  final String? contentType;

  /// 构造函数
  ///
  /// [message] 错误消息
  /// [fileName] 文件名（可选）
  /// [fileSize] 文件大小（可选）
  /// [contentType] 内容类型（可选）
  /// [originalError] 原始异常（可选）
  /// [stackTrace] 堆栈跟踪（可选）
  const AttachmentException({
    required super.message,
    this.fileName,
    this.fileSize,
    this.contentType,
    super.originalError,
    super.stackTrace,
  }) : super(errorCode: 'EP_ATTACHMENT_ERROR');

  /// 创建附件下载异常
  factory AttachmentException.downloadFailed({
    String? fileName,
    int? fileSize,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return AttachmentException(
      message: '附件下载失败',
      fileName: fileName,
      fileSize: fileSize,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// 创建附件保存异常
  factory AttachmentException.saveFailed({
    String? fileName,
    int? fileSize,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return AttachmentException(
      message: '附件保存失败',
      fileName: fileName,
      fileSize: fileSize,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// 创建附件读取异常
  factory AttachmentException.readFailed({
    String? fileName,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return AttachmentException(
      message: '附件读取失败',
      fileName: fileName,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// 创建附件大小超限异常
  factory AttachmentException.sizeExceeded({
    String? fileName,
    required int fileSize,
    required int maxSize,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return AttachmentException(
      message:
          '附件大小超过限制（${(fileSize / 1024 / 1024).toStringAsFixed(2)} MB > ${(maxSize / 1024 / 1024).toStringAsFixed(2)} MB）',
      fileName: fileName,
      fileSize: fileSize,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// 创建不支持的附件类型异常
  factory AttachmentException.unsupportedType({
    String? fileName,
    String? contentType,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return AttachmentException(
      message: '不支持的附件类型: ${contentType ?? "未知"}',
      fileName: fileName,
      contentType: contentType,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// 创建附件损坏异常
  factory AttachmentException.corrupted({
    String? fileName,
    Object? originalError,
    StackTrace? stackTrace,
  }) {
    return AttachmentException(
      message: '附件数据已损坏',
      fileName: fileName,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  @override
  String get debugInfo {
    final buffer = StringBuffer();
    buffer.writeln('AttachmentException:');
    buffer.writeln('  错误码: $errorCode');
    buffer.writeln('  错误消息: $message');
    if (fileName != null) {
      buffer.writeln('  文件名: $fileName');
    }
    if (fileSize != null) {
      buffer.writeln('  文件大小: $fileSize 字节');
    }
    if (contentType != null) {
      buffer.writeln('  内容类型: $contentType');
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
    map['fileName'] = fileName;
    map['fileSize'] = fileSize;
    map['contentType'] = contentType;
    return map;
  }
}
