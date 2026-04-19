import 'package:enough_mail/enough_mail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markbox/shared/models/imap_config.dart';
import 'package:markbox/shared/models/imap_connection_result.dart';
import 'package:markbox/shared/services/imap_service.dart';
import 'package:mocktail/mocktail.dart';

// Mock ImapClient
class MockImapClient extends Mock implements ImapClient {}

void main() {
  late ImapService imapService;

  setUp(() {
    imapService = ImapService();
  });

  group('ImapService 配置验证测试', () {
    test('验证有效配置', () {
      // 准备有效配置
      const config = ImapConfig(
        server: 'imap.qq.com',
        port: 993,
        email: 'test@qq.com',
        password: 'password123',
        useSSL: true,
      );

      // 验证配置
      final result = imapService.validateConfig(config);

      // 验证通过返回 null
      expect(result, isNull);
    });

    test('验证空服务器地址', () {
      // 准备无效配置
      const config = ImapConfig(
        server: '',
        port: 993,
        email: 'test@qq.com',
        password: 'password123',
        useSSL: true,
      );

      // 验证配置
      final result = imapService.validateConfig(config);

      // 验证失败
      expect(result, isNotNull);
      expect(result!.success, false);
      expect(result.errorMessage, '服务器地址不能为空');
      expect(result.errorType, ImapErrorType.networkError);
    });

    test('验证无效端口号（小于 1）', () {
      // 准备无效配置
      const config = ImapConfig(
        server: 'imap.qq.com',
        port: 0,
        email: 'test@qq.com',
        password: 'password123',
        useSSL: true,
      );

      // 验证配置
      final result = imapService.validateConfig(config);

      // 验证失败
      expect(result, isNotNull);
      expect(result!.success, false);
      expect(result.errorMessage, '端口号无效，必须在 1-65535 之间');
      expect(result.errorType, ImapErrorType.networkError);
    });

    test('验证无效端口号（大于 65535）', () {
      // 准备无效配置
      const config = ImapConfig(
        server: 'imap.qq.com',
        port: 70000,
        email: 'test@qq.com',
        password: 'password123',
        useSSL: true,
      );

      // 验证配置
      final result = imapService.validateConfig(config);

      // 验证失败
      expect(result, isNotNull);
      expect(result!.success, false);
      expect(result.errorMessage, '端口号无效，必须在 1-65535 之间');
      expect(result.errorType, ImapErrorType.networkError);
    });

    test('验证空邮箱地址', () {
      // 准备无效配置
      const config = ImapConfig(
        server: 'imap.qq.com',
        port: 993,
        email: '',
        password: 'password123',
        useSSL: true,
      );

      // 验证配置
      final result = imapService.validateConfig(config);

      // 验证失败
      expect(result, isNotNull);
      expect(result!.success, false);
      expect(result.errorMessage, '邮箱地址不能为空');
      expect(result.errorType, ImapErrorType.authenticationFailed);
    });

    test('验证无效邮箱格式', () {
      // 准备无效配置
      const config = ImapConfig(
        server: 'imap.qq.com',
        port: 993,
        email: 'invalid-email',
        password: 'password123',
        useSSL: true,
      );

      // 验证配置
      final result = imapService.validateConfig(config);

      // 验证失败
      expect(result, isNotNull);
      expect(result!.success, false);
      expect(result.errorMessage, '邮箱地址格式不正确');
      expect(result.errorType, ImapErrorType.authenticationFailed);
    });

    test('验证空授权码', () {
      // 准备无效配置
      const config = ImapConfig(
        server: 'imap.qq.com',
        port: 993,
        email: 'test@qq.com',
        password: '',
        useSSL: true,
      );

      // 验证配置
      final result = imapService.validateConfig(config);

      // 验证失败
      expect(result, isNotNull);
      expect(result!.success, false);
      expect(result.errorMessage, '授权码不能为空');
      expect(result.errorType, ImapErrorType.authenticationFailed);
    });

    test('验证多种邮箱格式', () {
      // 测试有效的邮箱格式
      final validEmails = [
        'test@qq.com',
        'user.name@gmail.com',
        'user123@outlook.com',
        'test.user@company.co.uk',
      ];

      for (final email in validEmails) {
        final config = ImapConfig(
          server: 'imap.example.com',
          port: 993,
          email: email,
          password: 'password',
          useSSL: true,
        );

        final result = imapService.validateConfig(config);
        expect(result, isNull, reason: '邮箱 $email 应该是有效的');
      }

      // 测试无效的邮箱格式
      final invalidEmails = [
        'invalid',
        'invalid@',
        '@invalid.com',
        'invalid@.com',
        'invalid.com',
      ];

      for (final email in invalidEmails) {
        final config = ImapConfig(
          server: 'imap.example.com',
          port: 993,
          email: email,
          password: 'password',
          useSSL: true,
        );

        final result = imapService.validateConfig(config);
        expect(result, isNotNull, reason: '邮箱 $email 应该是无效的');
        expect(result!.success, false);
        expect(result.errorType, ImapErrorType.authenticationFailed);
      }
    });
  });

  group('ImapService 连接测试（集成测试）', () {
    // 注意：这些测试需要真实的网络连接
    // 在 CI/CD 环境中可能需要跳过或使用 mock

    test('testConnectionWithValidation 先验证配置', () async {
      // 准备无效配置
      const config = ImapConfig(
        server: '',
        port: 993,
        email: 'test@qq.com',
        password: 'password',
        useSSL: true,
      );

      // 测试连接（应该先验证配置）
      final result = await imapService.testConnectionWithValidation(config);

      // 验证结果（配置验证失败）
      expect(result.success, false);
      expect(result.errorMessage, '服务器地址不能为空');
      expect(result.errorType, ImapErrorType.networkError);
    });

    test('单例模式测试', () {
      // 验证单例模式
      final instance1 = ImapService();
      final instance2 = ImapService();

      // 应该是同一个实例
      expect(identical(instance1, instance2), true);
    });

    test('连接超时配置', () {
      // 验证超时配置
      expect(ImapService.connectionTimeoutMs, 10000);
    });
  });

  group('ImapConnectionResult 工厂方法测试', () {
    test('success 工厂方法', () {
      final result = ImapConnectionResult.success();

      expect(result.success, true);
      expect(result.errorMessage, isNull);
      expect(result.errorType, isNull);
    });

    test('failure 工厂方法', () {
      final result = ImapConnectionResult.failure(
        errorMessage: '测试错误',
        errorType: ImapErrorType.networkError,
      );

      expect(result.success, false);
      expect(result.errorMessage, '测试错误');
      expect(result.errorType, ImapErrorType.networkError);
    });

    test('failure 工厂方法（默认错误类型）', () {
      final result = ImapConnectionResult.failure(errorMessage: '未知错误');

      expect(result.success, false);
      expect(result.errorMessage, '未知错误');
      expect(result.errorType, ImapErrorType.unknown);
    });
  });

  group('ImapErrorType 错误类型测试', () {
    test('所有错误类型都有用户友好消息', () {
      for (final errorType in ImapErrorType.values) {
        expect(
          errorType.userFriendlyMessage.isNotEmpty,
          true,
          reason: '${errorType.name} 应该有用户友好消息',
        );
      }
    });

    test('错误类型枚举值', () {
      expect(ImapErrorType.networkError.index, 0);
      expect(ImapErrorType.authenticationFailed.index, 1);
      expect(ImapErrorType.sslError.index, 2);
      expect(ImapErrorType.timeoutError.index, 3);
      expect(ImapErrorType.serverNotSupported.index, 4);
      expect(ImapErrorType.unknown.index, 5);
    });
  });
}
