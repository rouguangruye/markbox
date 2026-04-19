import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_provider.freezed.dart';
part 'email_provider.g.dart';

/// 邮箱服务商配置模型
///
/// 用于存储邮箱服务商的基本信息和 IMAP 服务器配置
@freezed
class EmailProvider with _$EmailProvider {
  const factory EmailProvider({
    /// 服务商名称（唯一标识）
    required String name,

    /// 显示名称（用于 UI 展示）
    required String displayName,

    /// 图标路径（资源路径或网络 URL）
    required String icon,

    /// IMAP 服务器地址
    required String imapServer,

    /// IMAP 端口号
    required int imapPort,

    /// 是否使用 SSL 加密
    required bool useSSL,

    /// 邮箱域名后缀（可选，用于自动识别邮箱服务商）
    String? domain,
  }) = _EmailProvider;

  factory EmailProvider.fromJson(Map<String, dynamic> json) =>
      _$EmailProviderFromJson(json);
}
