import 'package:flutter_test/flutter_test.dart';
import 'package:markbox/shared/models/account_config_state.dart';
import 'package:markbox/shared/models/imap_config.dart';

void main() {
  group('AccountConfigState 模型测试', () {
    test('创建初始状态', () {
      // 创建初始状态
      const state = AccountConfigState();

      // 验证默认值
      expect(state.currentConfig, isNull);
      expect(state.isLoading, false);
      expect(state.isSaving, false);
      expect(state.isInitialized, false);
      expect(state.error, isNull);
    });

    test('创建带配置的状态', () {
      // 准备测试数据
      const config = ImapConfig(
        server: 'imap.qq.com',
        port: 993,
        email: 'test@qq.com',
        password: 'password',
        useSSL: true,
      );

      // 创建带配置的状态
      const state = AccountConfigState(currentConfig: config);

      // 验证属性
      expect(state.currentConfig, equals(config));
      expect(state.isLoading, false);
      expect(state.isSaving, false);
      expect(state.error, isNull);
    });

    test('创建加载中状态', () {
      // 创建加载中状态
      const state = AccountConfigState(isLoading: true);

      // 验证属性
      expect(state.currentConfig, isNull);
      expect(state.isLoading, true);
      expect(state.isSaving, false);
      expect(state.error, isNull);
    });

    test('创建保存中状态', () {
      // 创建保存中状态
      const state = AccountConfigState(isSaving: true);

      // 验证属性
      expect(state.currentConfig, isNull);
      expect(state.isLoading, false);
      expect(state.isSaving, true);
      expect(state.error, isNull);
    });

    test('创建带错误的状态', () {
      // 创建带错误的状态
      const state = AccountConfigState(error: '加载配置失败');

      // 验证属性
      expect(state.currentConfig, isNull);
      expect(state.isLoading, false);
      expect(state.isSaving, false);
      expect(state.error, '加载配置失败');
    });

    test('创建完整状态', () {
      // 准备测试数据
      const config = ImapConfig(
        server: 'imap.gmail.com',
        port: 993,
        email: 'user@gmail.com',
        password: 'password',
        useSSL: true,
      );

      // 创建完整状态
      const state = AccountConfigState(
        currentConfig: config,
        isLoading: false,
        isSaving: false,
        isInitialized: true,
        error: null,
      );

      // 验证属性
      expect(state.currentConfig, equals(config));
      expect(state.isLoading, false);
      expect(state.isSaving, false);
      expect(state.isInitialized, true);
      expect(state.error, isNull);
    });

    test('copyWith 方法（修改配置）', () {
      // 创建原始状态
      const original = AccountConfigState();

      // 准备新配置
      const config = ImapConfig(
        server: 'imap.qq.com',
        port: 993,
        email: 'test@qq.com',
        password: 'password',
        useSSL: true,
      );

      // 使用 copyWith 修改配置
      final modified = original.copyWith(currentConfig: config);

      // 验证修改后的属性
      expect(modified.currentConfig, equals(config));
      expect(modified.isLoading, false);
      expect(modified.isSaving, false);
      expect(modified.error, isNull);
    });

    test('copyWith 方法（修改加载状态）', () {
      // 创建原始状态
      const original = AccountConfigState();

      // 使用 copyWith 修改加载状态
      final modified = original.copyWith(isLoading: true);

      // 验证修改后的属性
      expect(modified.currentConfig, isNull);
      expect(modified.isLoading, true);
      expect(modified.isSaving, false);
      expect(modified.error, isNull);
    });

    test('copyWith 方法（修改保存状态）', () {
      // 创建原始状态
      const original = AccountConfigState();

      // 使用 copyWith 修改保存状态
      final modified = original.copyWith(isSaving: true);

      // 验证修改后的属性
      expect(modified.currentConfig, isNull);
      expect(modified.isLoading, false);
      expect(modified.isSaving, true);
      expect(modified.error, isNull);
    });

    test('copyWith 方法（修改错误）', () {
      // 创建原始状态
      const original = AccountConfigState();

      // 使用 copyWith 设置错误
      final modified = original.copyWith(error: '测试错误');

      // 验证修改后的属性
      expect(modified.currentConfig, isNull);
      expect(modified.isLoading, false);
      expect(modified.isSaving, false);
      expect(modified.error, '测试错误');
    });

    test('copyWith 方法（清除错误）', () {
      // 创建带错误的状态
      const original = AccountConfigState(error: '原有错误');

      // 使用 copyWith 清除错误
      final modified = original.copyWith(error: null);

      // 验证错误已清除
      expect(modified.error, isNull);
    });

    test('copyWith 方法（清除配置）', () {
      // 准备测试数据
      const config = ImapConfig(
        server: 'imap.qq.com',
        port: 993,
        email: 'test@qq.com',
        password: 'password',
        useSSL: true,
      );

      // 创建带配置的状态
      const original = AccountConfigState(currentConfig: config);

      // 使用 copyWith 清除配置
      final modified = original.copyWith(currentConfig: null);

      // 验证配置已清除
      expect(modified.currentConfig, isNull);
    });

    test('相等性比较', () {
      // 准备测试数据
      const config = ImapConfig(
        server: 'imap.qq.com',
        port: 993,
        email: 'test@qq.com',
        password: 'password',
        useSSL: true,
      );

      // 创建两个相同的状态
      const state1 = AccountConfigState(
        currentConfig: config,
        isLoading: false,
        isSaving: false,
        error: null,
      );

      const state2 = AccountConfigState(
        currentConfig: config,
        isLoading: false,
        isSaving: false,
        error: null,
      );

      // 验证相等性
      expect(state1, equals(state2));
    });

    test('不相等性比较', () {
      // 创建两个不同的状态
      const state1 = AccountConfigState(isLoading: true);
      const state2 = AccountConfigState(isLoading: false);

      // 验证不相等
      expect(state1, isNot(equals(state2)));
    });

    test('toString 方法', () {
      // 创建状态
      const state = AccountConfigState(isLoading: true, error: '测试错误');

      // 验证 toString 输出包含关键信息
      final str = state.toString();
      expect(str, contains('AccountConfigState'));
      expect(str, contains('isLoading'));
      expect(str, contains('测试错误'));
    });
  });
}
