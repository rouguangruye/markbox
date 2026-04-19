/// IMAP 连接结果模型
///
/// 用于封装 IMAP 连接测试的结果
class ImapConnectionResult {
  /// 是否连接成功
  final bool success;

  /// 错误信息（可选）
  final String? errorMessage;

  /// 错误类型
  final ImapErrorType? errorType;

  const ImapConnectionResult({
    required this.success,
    this.errorMessage,
    this.errorType,
  });

  /// 创建成功结果
  factory ImapConnectionResult.success() {
    return const ImapConnectionResult(success: true);
  }

  /// 创建失败结果
  factory ImapConnectionResult.failure({
    required String errorMessage,
    ImapErrorType? errorType,
  }) {
    return ImapConnectionResult(
      success: false,
      errorMessage: errorMessage,
      errorType: errorType ?? ImapErrorType.unknown,
    );
  }

  @override
  String toString() {
    if (success) {
      return 'ImapConnectionResult(success: true)';
    }
    return 'ImapConnectionResult(success: false, errorType: $errorType, errorMessage: $errorMessage)';
  }
}

/// IMAP 错误类型枚举
enum ImapErrorType {
  /// 网络错误（无法连接到服务器）
  networkError,

  /// 认证失败（用户名或密码错误）
  authenticationFailed,

  /// SSL 证书错误
  sslError,

  /// 连接超时
  timeoutError,

  /// 服务器不支持 IMAP
  serverNotSupported,

  /// 未知错误
  unknown,
}

/// IMAP 错误类型扩展方法
extension ImapErrorTypeExtension on ImapErrorType {
  /// 获取用户友好的错误提示
  String get userFriendlyMessage {
    switch (this) {
      case ImapErrorType.networkError:
        return '网络连接失败，请检查网络设置和服务器地址';
      case ImapErrorType.authenticationFailed:
        return '认证失败，请检查邮箱账号和授权码';
      case ImapErrorType.sslError:
        return 'SSL 证书验证失败，请检查服务器安全设置';
      case ImapErrorType.timeoutError:
        return '连接超时，请检查网络状况或稍后重试';
      case ImapErrorType.serverNotSupported:
        return '服务器不支持 IMAP 协议';
      case ImapErrorType.unknown:
        return '发生未知错误，请稍后重试';
    }
  }
}
