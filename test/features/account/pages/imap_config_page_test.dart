import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markbox/features/account/pages/imap_config_page.dart';
import 'package:markbox/shared/models/imap_config.dart';
import 'package:markbox/shared/services/imap_service.dart';
import 'package:mocktail/mocktail.dart';

// Mock 类
class MockImapService extends Mock implements ImapService {}

void main() {
  group('ImapConfigPage Widget 测试', () {
    testWidgets('页面标题显示正确', (WidgetTester tester) async {
      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ImapConfigPage())),
      );

      // 验证标题
      expect(find.text('IMAP 配置'), findsOneWidget);
    });

    testWidgets('配置说明卡片显示正确', (WidgetTester tester) async {
      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ImapConfigPage())),
      );

      // 验证说明文字
      expect(find.text('配置说明'), findsOneWidget);
      expect(find.textContaining('请填写您的邮箱 IMAP 服务器信息'), findsOneWidget);
    });

    testWidgets('表单字段显示正确', (WidgetTester tester) async {
      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ImapConfigPage())),
      );

      // 验证表单字段标签
      expect(find.text('服务器地址'), findsOneWidget);
      expect(find.text('端口号'), findsOneWidget);
      expect(find.text('邮箱账号'), findsOneWidget);
      expect(find.text('授权码'), findsOneWidget);
    });

    testWidgets('SSL 开关显示正确', (WidgetTester tester) async {
      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ImapConfigPage())),
      );

      // 验证 SSL 开关
      expect(find.text('使用 SSL 加密'), findsOneWidget);
      expect(find.text('已启用安全连接'), findsOneWidget);
    });

    testWidgets('按钮显示正确', (WidgetTester tester) async {
      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ImapConfigPage())),
      );

      // 验证按钮
      expect(find.text('测试连接'), findsOneWidget);
      expect(find.text('保存配置'), findsOneWidget);
    });

    testWidgets('端口号默认值', (WidgetTester tester) async {
      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ImapConfigPage())),
      );

      // 查找端口号输入框
      final portField = find.widgetWithText(TextFormField, '端口号');
      expect(portField, findsOneWidget);

      // 获取 TextEditingController
      final textField = tester.widget<TextFormField>(portField);
      expect(textField.controller?.text, '993');
    });

    testWidgets('SSL 开关切换', (WidgetTester tester) async {
      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ImapConfigPage())),
      );

      // 查找 SSL 开关
      final switchFinder = find.widgetWithText(SwitchListTile, '使用 SSL 加密');
      expect(switchFinder, findsOneWidget);

      // 获取当前状态
      final switchWidget = tester.widget<SwitchListTile>(switchFinder);
      expect(switchWidget.value, true);

      // 点击切换
      await tester.tap(switchFinder);
      await tester.pumpAndSettle();

      // 验证状态变化
      final updatedSwitch = tester.widget<SwitchListTile>(switchFinder);
      expect(updatedSwitch.value, false);

      // 验证端口号自动更新
      final portField = find.widgetWithText(TextFormField, '端口号');
      final textField = tester.widget<TextFormField>(portField);
      expect(textField.controller?.text, '143');
    });

    testWidgets('表单验证 - 空服务器地址', (WidgetTester tester) async {
      // 设置更大的屏幕尺寸
      await tester.binding.setSurfaceSize(const Size(800, 1200));

      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ImapConfigPage())),
      );

      // 滚动到按钮位置
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();

      // 点击测试连接按钮（不填写任何信息）
      await tester.tap(find.text('测试连接'));
      await tester.pumpAndSettle();

      // 验证错误提示
      expect(find.text('请输入服务器地址'), findsOneWidget);

      // 重置屏幕尺寸
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('表单验证 - 空邮箱地址', (WidgetTester tester) async {
      // 设置更大的屏幕尺寸
      await tester.binding.setSurfaceSize(const Size(800, 1200));

      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ImapConfigPage())),
      );

      // 填写服务器地址
      await tester.enterText(
        find.widgetWithText(TextFormField, '服务器地址'),
        'imap.qq.com',
      );

      // 滚动到按钮位置
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();

      // 点击测试连接按钮
      await tester.tap(find.text('测试连接'));
      await tester.pumpAndSettle();

      // 验证错误提示
      expect(find.text('请输入邮箱地址'), findsOneWidget);

      // 重置屏幕尺寸
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('表单验证 - 无效邮箱格式', (WidgetTester tester) async {
      // 设置更大的屏幕尺寸
      await tester.binding.setSurfaceSize(const Size(800, 1200));

      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ImapConfigPage())),
      );

      // 填写无效邮箱
      await tester.enterText(
        find.widgetWithText(TextFormField, '服务器地址'),
        'imap.qq.com',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, '邮箱账号'),
        'invalid-email',
      );

      // 滚动到按钮位置
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();

      // 点击测试连接按钮
      await tester.tap(find.text('测试连接'));
      await tester.pumpAndSettle();

      // 验证错误提示
      expect(find.text('请输入有效的邮箱地址'), findsOneWidget);

      // 重置屏幕尺寸
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('表单验证 - 空授权码', (WidgetTester tester) async {
      // 设置更大的屏幕尺寸
      await tester.binding.setSurfaceSize(const Size(800, 1200));

      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ImapConfigPage())),
      );

      // 填写服务器和邮箱
      await tester.enterText(
        find.widgetWithText(TextFormField, '服务器地址'),
        'imap.qq.com',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, '邮箱账号'),
        'test@qq.com',
      );

      // 滚动到按钮位置
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();

      // 点击测试连接按钮
      await tester.tap(find.text('测试连接'));
      await tester.pumpAndSettle();

      // 验证错误提示
      expect(find.text('请输入授权码'), findsOneWidget);

      // 重置屏幕尺寸
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('表单验证 - 无效端口号', (WidgetTester tester) async {
      // 设置更大的屏幕尺寸
      await tester.binding.setSurfaceSize(const Size(800, 1200));

      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ImapConfigPage())),
      );

      // 填写无效端口
      await tester.enterText(
        find.widgetWithText(TextFormField, '服务器地址'),
        'imap.qq.com',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, '端口号'),
        '99999',
      );

      // 滚动到按钮位置
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();

      // 点击测试连接按钮
      await tester.tap(find.text('测试连接'));
      await tester.pumpAndSettle();

      // 验证错误提示
      expect(find.text('端口号必须在 1-65535 之间'), findsOneWidget);

      // 重置屏幕尺寸
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('密码显示/隐藏切换', (WidgetTester tester) async {
      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ImapConfigPage())),
      );

      // 查找密码输入框
      final passwordField = find.widgetWithText(TextFormField, '授权码');
      expect(passwordField, findsOneWidget);

      // 验证初始状态（密码隐藏图标显示）
      expect(find.byIcon(Icons.visibility), findsOneWidget);

      // 点击显示/隐藏按钮
      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pumpAndSettle();

      // 验证密码显示（图标切换）
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);

      // 再次点击
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pumpAndSettle();

      // 验证密码隐藏（图标切换回来）
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('保存按钮初始状态禁用', (WidgetTester tester) async {
      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ImapConfigPage())),
      );

      // 查找保存按钮
      final saveButton = find.widgetWithText(FilledButton, '保存配置');
      expect(saveButton, findsOneWidget);

      // 验证按钮禁用
      final button = tester.widget<FilledButton>(saveButton);
      expect(button.onPressed, isNull);
    });

    testWidgets('输入字段提示文字', (WidgetTester tester) async {
      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ImapConfigPage())),
      );

      // 验证提示文字
      expect(find.text('例如: imap.qq.com'), findsOneWidget);
      expect(find.text('例如: 993'), findsOneWidget);
      expect(find.text('例如: example@qq.com'), findsOneWidget);
      expect(find.text('请输入邮箱授权码'), findsOneWidget);
    });
  });

  group('ImapConfig 模型测试（在页面上下文中）', () {
    testWidgets('创建 ImapConfig 实例', (WidgetTester tester) async {
      // 准备测试数据
      const config = ImapConfig(
        server: 'imap.qq.com',
        port: 993,
        email: 'test@qq.com',
        password: 'password',
        useSSL: true,
      );

      // 验证配置属性
      expect(config.server, 'imap.qq.com');
      expect(config.port, 993);
      expect(config.email, 'test@qq.com');
      expect(config.password, 'password');
      expect(config.useSSL, true);
    });
  });

  group('AccountConfigState 状态测试（在页面上下文中）', () {
    testWidgets('初始状态正确', (WidgetTester tester) async {
      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ImapConfigPage())),
      );

      // 验证页面正常渲染（间接验证 Provider 状态正常）
      expect(find.text('IMAP 配置'), findsOneWidget);
      expect(find.text('测试连接'), findsOneWidget);
      expect(find.text('保存配置'), findsOneWidget);
    });
  });
}
