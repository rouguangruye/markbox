import 'package:freezed_annotation/freezed_annotation.dart';

part 'imap_config.freezed.dart';
part 'imap_config.g.dart';

/// IMAP 配置模型
///
/// 用于存储用户的 IMAP 邮箱连接配置
@freezed
class ImapConfig with _$ImapConfig {
  const factory ImapConfig({
    /// 唯一标识符
    required String id,

    /// IMAP 服务器地址
    required String server,

    /// IMAP 端口号
    required int port,

    /// 邮箱账号
    required String email,

    /// 授权码（非明文密码）
    required String password,

    /// 是否使用 SSL 加密
    required bool useSSL,

    /// 显示名称（可选）
    String? displayName,

    /// 创建时间（毫秒时间戳）
    @Default(0) int createdAt,
  }) = _ImapConfig;

  factory ImapConfig.fromJson(Map<String, dynamic> json) =>
      _$ImapConfigFromJson(json);
}
