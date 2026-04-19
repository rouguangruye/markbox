import 'dart:developer' as developer;

import 'email_parse_exception.dart';
import 'mime_parse_exception.dart';
import 'decode_exception.dart';
import 'header_parse_exception.dart';
import 'attachment_exception.dart';

/// 邮件解析异常处理器
///
/// 提供统一的异常捕获、日志记录和错误信息转换功能
class EmailParseExceptionHandler {
  /// 日志标签
  static const String _logTag = 'EmailParser';

  /// 处理异常并返回用户友好的错误信息
  ///
  /// [error] 捕获的异常
  /// [stackTrace] 堆栈跟踪（可选）
  /// [context] 上下文信息（可选）
  ///
  /// 返回用户友好的错误消息
  static String handle(
    Object error, {
    StackTrace? stackTrace,
    String? context,
  }) {
    // 记录日志
    logError(error, stackTrace: stackTrace, context: context);

    // 转换为用户友好的消息
    return toUserFriendlyMessage(error);
  }

  /// 记录错误日志
  ///
  /// [error] 捕获的异常
  /// [stackTrace] 堆栈跟踪（可选）
  /// [context] 上下文信息（可选）
  static void logError(
    Object error, {
    StackTrace? stackTrace,
    String? context,
  }) {
    final buffer = StringBuffer();

    // 添加上下文信息
    if (context != null && context.isNotEmpty) {
      buffer.writeln('[$context]');
    }

    // 根据异常类型记录详细信息
    if (error is EmailParseException) {
      buffer.write(error.debugInfo);
    } else {
      buffer.writeln('未知异常: $error');
      if (stackTrace != null) {
        buffer.writeln('堆栈跟踪:');
        buffer.writeln(stackTrace.toString());
      }
    }

    // 使用 developer.log 记录日志
    developer.log(
      buffer.toString(),
      name: _logTag,
      level: 1000, // ERROR 级别
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// 将异常转换为用户友好的消息
  ///
  /// [error] 捕获的异常
  ///
  /// 返回用户友好的错误消息
  static String toUserFriendlyMessage(Object error) {
    if (error is EmailParseException) {
      return error.userFriendlyMessage;
    }

    // 处理常见的 Dart 异常
    if (error is FormatException) {
      return '数据格式错误，无法解析邮件内容';
    }

    if (error is ArgumentError) {
      return '参数错误，请检查邮件数据';
    }

    if (error is StateError) {
      return '状态错误，请重试';
    }

    if (error is RangeError) {
      return '数据范围错误，邮件内容可能已损坏';
    }

    // 默认错误消息
    return '邮件解析失败，请稍后重试';
  }

  /// 将异常转换为错误码
  ///
  /// [error] 捕获的异常
  ///
  /// 返回错误码
  static String toErrorCode(Object error) {
    if (error is EmailParseException) {
      return error.errorCode;
    }

    // 为常见异常分配错误码
    if (error is FormatException) {
      return 'EP_FORMAT_ERROR';
    }

    if (error is ArgumentError) {
      return 'EP_ARGUMENT_ERROR';
    }

    if (error is StateError) {
      return 'EP_STATE_ERROR';
    }

    if (error is RangeError) {
      return 'EP_RANGE_ERROR';
    }

    return 'EP_UNKNOWN_ERROR';
  }

  /// 包装异常为 EmailParseException
  ///
  /// [error] 原始异常
  /// [stackTrace] 堆栈跟踪（可选）
  /// [context] 上下文信息（可选）
  ///
  /// 返回包装后的 EmailParseException
  static EmailParseException wrapException(
    Object error, {
    StackTrace? stackTrace,
    String? context,
  }) {
    // 如果已经是 EmailParseException，直接返回
    if (error is EmailParseException) {
      return error;
    }

    // 包装为通用的 EmailParseException
    return EmailParseException(
      errorCode: toErrorCode(error),
      message: toUserFriendlyMessage(error),
      originalError: error,
      stackTrace: stackTrace,
    );
  }

  /// 安全执行函数
  ///
  /// [action] 要执行的函数
  /// [onError] 错误处理回调（可选）
  /// [context] 上下文信息（可选）
  ///
  /// 返回执行结果，如果发生异常则返回 null
  static T? safeExecute<T>(
    T Function() action, {
    void Function(Object error, StackTrace? stackTrace)? onError,
    String? context,
  }) {
    try {
      return action();
    } catch (error, stackTrace) {
      // 记录错误
      logError(error, stackTrace: stackTrace, context: context);

      // 调用错误回调
      onError?.call(error, stackTrace);

      return null;
    }
  }

  /// 安全执行异步函数
  ///
  /// [action] 要执行的异步函数
  /// [onError] 错误处理回调（可选）
  /// [context] 上下文信息（可选）
  ///
  /// 返回执行结果，如果发生异常则返回 null
  static Future<T?> safeExecuteAsync<T>(
    Future<T> Function() action, {
    void Function(Object error, StackTrace? stackTrace)? onError,
    String? context,
  }) async {
    try {
      return await action();
    } catch (error, stackTrace) {
      // 记录错误
      logError(error, stackTrace: stackTrace, context: context);

      // 调用错误回调
      onError?.call(error, stackTrace);

      return null;
    }
  }
}

/// 异常类型枚举
///
/// 定义所有可能的异常类型
enum EmailParseExceptionType {
  /// 基础解析异常
  base,

  /// MIME 解析异常
  mime,

  /// 解码异常
  decode,

  /// 邮件头解析异常
  header,

  /// 附件处理异常
  attachment,
}

/// 异常类型判断工具
class EmailParseExceptionTypeHelper {
  /// 判断异常类型
  ///
  /// [error] 异常对象
  ///
  /// 返回异常类型
  static EmailParseExceptionType getType(Object error) {
    if (error is MimeParseException) {
      return EmailParseExceptionType.mime;
    }

    if (error is DecodeException) {
      return EmailParseExceptionType.decode;
    }

    if (error is HeaderParseException) {
      return EmailParseExceptionType.header;
    }

    if (error is AttachmentException) {
      return EmailParseExceptionType.attachment;
    }

    if (error is EmailParseException) {
      return EmailParseExceptionType.base;
    }

    return EmailParseExceptionType.base;
  }

  /// 判断是否为可恢复的异常
  ///
  /// [error] 异常对象
  ///
  /// 返回是否可恢复
  static bool isRecoverable(Object error) {
    // 附件异常通常是可恢复的（可以跳过该附件）
    if (error is AttachmentException) {
      return true;
    }

    // 邮件头解析异常通常是可恢复的（可以使用默认值）
    if (error is HeaderParseException) {
      return true;
    }

    // MIME 解析异常和解码异常通常是不可恢复的
    return false;
  }
}
