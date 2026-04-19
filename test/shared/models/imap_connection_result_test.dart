import 'package:flutter_test/flutter_test.dart';
import 'package:markbox/shared/models/imap_connection_result.dart';

void main() {
  group('ImapConnectionResult 模型测试', () {
    test('创建成功结果', () {
      // 创建成功结果
      final result = ImapConnectionResult.success();

      // 验证属性
      expect(result.success, true);
      expect(result.errorMessage, isNull);
      expect(result.errorType, isNull);
    });

    test('创建失败结果', () {
      // 创建失败结果
      final result = ImapConnectionResult.failure(
        errorMessage: '连接失败',
        errorType: ImapErrorType.networkError,
      );

      // 验证属性
      expect(result.success, false);
      expect(result.errorMessage, '连接失败');
      expect(result.errorType, ImapErrorType.networkError);
    });

    test('创建失败结果（默认错误类型）', () {
      // 创建失败结果（不指定错误类型）
      final result = ImapConnectionResult.failure(errorMessage: '未知错误');

      // 验证属性（默认为 unknown）
      expect(result.success, false);
      expect(result.errorMessage, '未知错误');
      expect(result.errorType, ImapErrorType.unknown);
    });

    test('ImapConnectionResult 构造函数', () {
      // 使用构造函数创建成功结果
      const successResult = ImapConnectionResult(success: true);
      expect(successResult.success, true);
      expect(successResult.errorMessage, isNull);

      // 使用构造函数创建失败结果
      const failureResult = ImapConnectionResult(
        success: false,
        errorMessage: '测试错误',
        errorType: ImapErrorType.authenticationFailed,
      );
      expect(failureResult.success, false);
      expect(failureResult.errorMessage, '测试错误');
      expect(failureResult.errorType, ImapErrorType.authenticationFailed);
    });

    test('toString 方法（成功）', () {
      // 创建成功结果
      final result = ImapConnectionResult.success();

      // 验证 toString 输出
      expect(result.toString(), 'ImapConnectionResult(success: true)');
    });

    test('toString 方法（失败）', () {
      // 创建失败结果
      final result = ImapConnectionResult.failure(
        errorMessage: '连接超时',
        errorType: ImapErrorType.timeoutError,
      );

      // 验证 toString 输出包含错误信息
      final str = result.toString();
      expect(str, contains('success: false'));
      expect(str, contains('timeoutError'));
      expect(str, contains('连接超时'));
    });
  });

  group('ImapErrorType 枚举测试', () {
    test('所有错误类型', () {
      // 验证所有错误类型存在
      expect(ImapErrorType.values.length, 6);
      expect(ImapErrorType.values, contains(ImapErrorType.networkError));
      expect(
        ImapErrorType.values,
        contains(ImapErrorType.authenticationFailed),
      );
      expect(ImapErrorType.values, contains(ImapErrorType.sslError));
      expect(ImapErrorType.values, contains(ImapErrorType.timeoutError));
      expect(ImapErrorType.values, contains(ImapErrorType.serverNotSupported));
      expect(ImapErrorType.values, contains(ImapErrorType.unknown));
    });
  });

  group('ImapErrorTypeExtension 扩展方法测试', () {
    test('networkError 用户友好消息', () {
      const errorType = ImapErrorType.networkError;
      expect(errorType.userFriendlyMessage, '网络连接失败，请检查网络设置和服务器地址');
    });

    test('authenticationFailed 用户友好消息', () {
      const errorType = ImapErrorType.authenticationFailed;
      expect(errorType.userFriendlyMessage, '认证失败，请检查邮箱账号和授权码');
    });

    test('sslError 用户友好消息', () {
      const errorType = ImapErrorType.sslError;
      expect(errorType.userFriendlyMessage, 'SSL 证书验证失败，请检查服务器安全设置');
    });

    test('timeoutError 用户友好消息', () {
      const errorType = ImapErrorType.timeoutError;
      expect(errorType.userFriendlyMessage, '连接超时，请检查网络状况或稍后重试');
    });

    test('serverNotSupported 用户友好消息', () {
      const errorType = ImapErrorType.serverNotSupported;
      expect(errorType.userFriendlyMessage, '服务器不支持 IMAP 协议');
    });

    test('unknown 用户友好消息', () {
      const errorType = ImapErrorType.unknown;
      expect(errorType.userFriendlyMessage, '发生未知错误，请稍后重试');
    });
  });
}
