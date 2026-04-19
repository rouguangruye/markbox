import '../models/email_provider.dart';

/// 预设邮箱服务商列表
///
/// 包含常用的邮箱服务商配置信息，用于快速配置邮箱账户
class EmailProviders {
  EmailProviders._();

  /// QQ 邮箱配置
  static const EmailProvider qq = EmailProvider(
    name: 'qq',
    displayName: 'QQ邮箱',
    icon: 'assets/icons/email_providers/qq.png',
    imapServer: 'imap.qq.com',
    imapPort: 993,
    useSSL: true,
    domain: 'qq.com',
  );

  /// 163 邮箱配置
  static const EmailProvider netease163 = EmailProvider(
    name: '163',
    displayName: '163邮箱',
    icon: 'assets/icons/email_providers/163.png',
    imapServer: 'imap.163.com',
    imapPort: 993,
    useSSL: true,
    domain: '163.com',
  );

  /// Gmail 邮箱配置
  static const EmailProvider gmail = EmailProvider(
    name: 'gmail',
    displayName: 'Gmail',
    icon: 'assets/icons/email_providers/gmail.png',
    imapServer: 'imap.gmail.com',
    imapPort: 993,
    useSSL: true,
    domain: 'gmail.com',
  );

  /// Outlook 邮箱配置
  static const EmailProvider outlook = EmailProvider(
    name: 'outlook',
    displayName: 'Outlook',
    icon: 'assets/icons/email_providers/outlook.png',
    imapServer: 'outlook.office365.com',
    imapPort: 993,
    useSSL: true,
    domain: 'outlook.com',
  );

  /// 所有预设邮箱服务商列表
  static const List<EmailProvider> all = [qq, netease163, gmail, outlook];

  /// 根据邮箱地址自动识别服务商
  ///
  /// [email] 邮箱地址
  /// 返回匹配的邮箱服务商配置，如果未找到则返回 null
  static EmailProvider? detectProvider(String email) {
    final domain = email.split('@').lastOrNull;
    if (domain == null) return null;

    for (final provider in all) {
      if (provider.domain == domain) {
        return provider;
      }
    }
    return null;
  }

  /// 根据服务商名称获取配置
  ///
  /// [name] 服务商名称
  /// 返回匹配的邮箱服务商配置，如果未找到则返回 null
  static EmailProvider? getByName(String name) {
    for (final provider in all) {
      if (provider.name == name) {
        return provider;
      }
    }
    return null;
  }
}
