import 'package:flutter_test/flutter_test.dart';
import 'package:markbox/shared/models/imap_config.dart';

void main() {
  group('ImapConfig 模型测试', () {
    test('创建 ImapConfig 实例', () {
      // 准备测试数据
      const config = ImapConfig(
        server: 'imap.qq.com',
        port: 993,
        email: 'test@qq.com',
        password: 'test_password',
        useSSL: true,
      );

      // 验证属性
      expect(config.server, 'imap.qq.com');
      expect(config.port, 993);
      expect(config.email, 'test@qq.com');
      expect(config.password, 'test_password');
      expect(config.useSSL, true);
    });

    test('ImapConfig JSON 序列化', () {
      // 创建实例
      const config = ImapConfig(
        server: 'imap.gmail.com',
        port: 993,
        email: 'user@gmail.com',
        password: 'app_password',
        useSSL: true,
      );

      // 序列化为 JSON
      final json = config.toJson();

      // 验证 JSON 内容
      expect(json['server'], 'imap.gmail.com');
      expect(json['port'], 993);
      expect(json['email'], 'user@gmail.com');
      expect(json['password'], 'app_password');
      expect(json['useSSL'], true);
    });

    test('ImapConfig JSON 反序列化', () {
      // 准备 JSON 数据
      final json = {
        'server': 'outlook.office365.com',
        'port': 993,
        'email': 'user@outlook.com',
        'password': 'secure_password',
        'useSSL': true,
      };

      // 反序列化
      final config = ImapConfig.fromJson(json);

      // 验证属性
      expect(config.server, 'outlook.office365.com');
      expect(config.port, 993);
      expect(config.email, 'user@outlook.com');
      expect(config.password, 'secure_password');
      expect(config.useSSL, true);
    });

    test('ImapConfig 相等性比较', () {
      // 创建两个相同的实例
      const config1 = ImapConfig(
        server: 'imap.qq.com',
        port: 993,
        email: 'test@qq.com',
        password: 'password',
        useSSL: true,
      );

      const config2 = ImapConfig(
        server: 'imap.qq.com',
        port: 993,
        email: 'test@qq.com',
        password: 'password',
        useSSL: true,
      );

      // 验证相等性
      expect(config1, equals(config2));
    });

    test('ImapConfig 不相等性比较', () {
      // 创建两个不同的实例
      const config1 = ImapConfig(
        server: 'imap.qq.com',
        port: 993,
        email: 'test@qq.com',
        password: 'password',
        useSSL: true,
      );

      const config2 = ImapConfig(
        server: 'imap.gmail.com',
        port: 993,
        email: 'test@gmail.com',
        password: 'password',
        useSSL: true,
      );

      // 验证不相等
      expect(config1, isNot(equals(config2)));
    });

    test('ImapConfig copyWith 方法', () {
      // 创建原始实例
      const original = ImapConfig(
        server: 'imap.qq.com',
        port: 993,
        email: 'test@qq.com',
        password: 'old_password',
        useSSL: true,
      );

      // 使用 copyWith 修改部分属性
      final modified = original.copyWith(
        email: 'new_test@qq.com',
        password: 'new_password',
      );

      // 验证修改后的属性
      expect(modified.server, 'imap.qq.com'); // 未修改
      expect(modified.port, 993); // 未修改
      expect(modified.email, 'new_test@qq.com'); // 已修改
      expect(modified.password, 'new_password'); // 已修改
      expect(modified.useSSL, true); // 未修改
    });

    test('ImapConfig 不同端口配置', () {
      // 测试 SSL 端口
      const sslConfig = ImapConfig(
        server: 'imap.qq.com',
        port: 993,
        email: 'test@qq.com',
        password: 'password',
        useSSL: true,
      );
      expect(sslConfig.port, 993);
      expect(sslConfig.useSSL, true);

      // 测试非 SSL 端口
      const nonSslConfig = ImapConfig(
        server: 'imap.qq.com',
        port: 143,
        email: 'test@qq.com',
        password: 'password',
        useSSL: false,
      );
      expect(nonSslConfig.port, 143);
      expect(nonSslConfig.useSSL, false);
    });

    test('ImapConfig toString 方法', () {
      // 创建实例
      const config = ImapConfig(
        server: 'imap.qq.com',
        port: 993,
        email: 'test@qq.com',
        password: 'password',
        useSSL: true,
      );

      // 验证 toString 输出包含关键信息
      final str = config.toString();
      expect(str, contains('ImapConfig'));
      expect(str, contains('imap.qq.com'));
      expect(str, contains('test@qq.com'));
    });
  });
}
