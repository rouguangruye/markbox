import 'package:flutter_test/flutter_test.dart';
import 'package:markbox/shared/models/email_provider.dart';

void main() {
  group('EmailProvider 模型测试', () {
    test('创建 EmailProvider 实例', () {
      // 准备测试数据
      const provider = EmailProvider(
        name: 'qq',
        displayName: 'QQ邮箱',
        icon: 'assets/icons/qq.png',
        imapServer: 'imap.qq.com',
        imapPort: 993,
        useSSL: true,
        domain: 'qq.com',
      );

      // 验证属性
      expect(provider.name, 'qq');
      expect(provider.displayName, 'QQ邮箱');
      expect(provider.icon, 'assets/icons/qq.png');
      expect(provider.imapServer, 'imap.qq.com');
      expect(provider.imapPort, 993);
      expect(provider.useSSL, true);
      expect(provider.domain, 'qq.com');
    });

    test('创建不带可选参数的 EmailProvider 实例', () {
      // 准备测试数据（不包含 domain）
      const provider = EmailProvider(
        name: 'custom',
        displayName: '自定义邮箱',
        icon: 'assets/icons/custom.png',
        imapServer: 'imap.custom.com',
        imapPort: 993,
        useSSL: true,
      );

      // 验证属性
      expect(provider.name, 'custom');
      expect(provider.displayName, '自定义邮箱');
      expect(provider.domain, isNull);
    });

    test('EmailProvider JSON 序列化', () {
      // 创建实例
      const provider = EmailProvider(
        name: 'gmail',
        displayName: 'Gmail',
        icon: 'assets/icons/gmail.png',
        imapServer: 'imap.gmail.com',
        imapPort: 993,
        useSSL: true,
        domain: 'gmail.com',
      );

      // 序列化为 JSON
      final json = provider.toJson();

      // 验证 JSON 内容
      expect(json['name'], 'gmail');
      expect(json['displayName'], 'Gmail');
      expect(json['icon'], 'assets/icons/gmail.png');
      expect(json['imapServer'], 'imap.gmail.com');
      expect(json['imapPort'], 993);
      expect(json['useSSL'], true);
      expect(json['domain'], 'gmail.com');
    });

    test('EmailProvider JSON 反序列化', () {
      // 准备 JSON 数据
      final json = {
        'name': 'outlook',
        'displayName': 'Outlook',
        'icon': 'assets/icons/outlook.png',
        'imapServer': 'outlook.office365.com',
        'imapPort': 993,
        'useSSL': true,
        'domain': 'outlook.com',
      };

      // 反序列化
      final provider = EmailProvider.fromJson(json);

      // 验证属性
      expect(provider.name, 'outlook');
      expect(provider.displayName, 'Outlook');
      expect(provider.icon, 'assets/icons/outlook.png');
      expect(provider.imapServer, 'outlook.office365.com');
      expect(provider.imapPort, 993);
      expect(provider.useSSL, true);
      expect(provider.domain, 'outlook.com');
    });

    test('EmailProvider 相等性比较', () {
      // 创建两个相同的实例
      const provider1 = EmailProvider(
        name: 'qq',
        displayName: 'QQ邮箱',
        icon: 'assets/icons/qq.png',
        imapServer: 'imap.qq.com',
        imapPort: 993,
        useSSL: true,
        domain: 'qq.com',
      );

      const provider2 = EmailProvider(
        name: 'qq',
        displayName: 'QQ邮箱',
        icon: 'assets/icons/qq.png',
        imapServer: 'imap.qq.com',
        imapPort: 993,
        useSSL: true,
        domain: 'qq.com',
      );

      // 验证相等性
      expect(provider1, equals(provider2));
    });

    test('EmailProvider 不相等性比较', () {
      // 创建两个不同的实例
      const provider1 = EmailProvider(
        name: 'qq',
        displayName: 'QQ邮箱',
        icon: 'assets/icons/qq.png',
        imapServer: 'imap.qq.com',
        imapPort: 993,
        useSSL: true,
        domain: 'qq.com',
      );

      const provider2 = EmailProvider(
        name: 'gmail',
        displayName: 'Gmail',
        icon: 'assets/icons/gmail.png',
        imapServer: 'imap.gmail.com',
        imapPort: 993,
        useSSL: true,
        domain: 'gmail.com',
      );

      // 验证不相等
      expect(provider1, isNot(equals(provider2)));
    });

    test('EmailProvider copyWith 方法', () {
      // 创建原始实例
      const original = EmailProvider(
        name: 'qq',
        displayName: 'QQ邮箱',
        icon: 'assets/icons/qq.png',
        imapServer: 'imap.qq.com',
        imapPort: 993,
        useSSL: true,
        domain: 'qq.com',
      );

      // 使用 copyWith 修改部分属性
      final modified = original.copyWith(
        displayName: '腾讯QQ邮箱',
        imapPort: 143,
        useSSL: false,
      );

      // 验证修改后的属性
      expect(modified.name, 'qq'); // 未修改
      expect(modified.displayName, '腾讯QQ邮箱'); // 已修改
      expect(modified.icon, 'assets/icons/qq.png'); // 未修改
      expect(modified.imapServer, 'imap.qq.com'); // 未修改
      expect(modified.imapPort, 143); // 已修改
      expect(modified.useSSL, false); // 已修改
      expect(modified.domain, 'qq.com'); // 未修改
    });

    test('EmailProvider toString 方法', () {
      // 创建实例
      const provider = EmailProvider(
        name: 'qq',
        displayName: 'QQ邮箱',
        icon: 'assets/icons/qq.png',
        imapServer: 'imap.qq.com',
        imapPort: 993,
        useSSL: true,
        domain: 'qq.com',
      );

      // 验证 toString 输出包含关键信息
      final str = provider.toString();
      expect(str, contains('EmailProvider'));
      expect(str, contains('qq'));
      expect(str, contains('QQ邮箱'));
    });
  });
}
