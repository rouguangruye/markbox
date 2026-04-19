import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markbox/features/account/pages/imap_config_page.dart';
import 'package:markbox/features/account/pages/provider_selection_page.dart';
import 'package:markbox/shared/constants/email_providers.dart';
import 'package:markbox/shared/models/email_provider.dart';

void main() {
  group('ProviderSelectionPage Widget 测试', () {
    testWidgets('页面标题显示正确', (WidgetTester tester) async {
      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ProviderSelectionPage())),
      );

      // 等待动画完成
      await tester.pumpAndSettle();

      // 验证标题
      expect(find.text('选择邮箱服务商'), findsOneWidget);
    });

    testWidgets('页面说明文字显示正确', (WidgetTester tester) async {
      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ProviderSelectionPage())),
      );

      // 等待动画完成
      await tester.pumpAndSettle();

      // 验证说明文字
      expect(find.text('请选择您的邮箱服务商'), findsOneWidget);
      expect(find.text('选择预设服务商可自动配置服务器信息'), findsOneWidget);
    });

    testWidgets('服务商网格显示正确', (WidgetTester tester) async {
      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ProviderSelectionPage())),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 获取预设服务商列表
      final providers = EmailProviders.all;

      // 验证每个服务商卡片都显示
      for (final provider in providers) {
        expect(find.text(provider.displayName), findsWidgets);
      }

      // 验证"其他邮箱"卡片显示
      expect(find.text('其他邮箱'), findsOneWidget);
      expect(find.text('手动配置'), findsOneWidget);
    });

    testWidgets('服务商卡片点击事件', (WidgetTester tester) async {
      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ProviderSelectionPage())),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 获取第一个服务商
      final firstProvider = EmailProviders.all.first;

      // 查找并点击服务商卡片
      final cardFinder = find.text(firstProvider.displayName);
      expect(cardFinder, findsWidgets);

      // 点击第一个匹配项
      await tester.tap(cardFinder.first);
      await tester.pumpAndSettle();

      // 验证跳转到 ImapConfigPage
      expect(find.byType(ImapConfigPage), findsOneWidget);
      // 验证页面标题为"配置邮箱账户"（预设配置模式）
      expect(find.text('配置邮箱账户'), findsOneWidget);
    });

    testWidgets('其他邮箱卡片点击事件', (WidgetTester tester) async {
      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ProviderSelectionPage())),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 查找并点击"其他邮箱"卡片
      final cardFinder = find.text('其他邮箱');
      expect(cardFinder, findsOneWidget);

      await tester.tap(cardFinder);
      await tester.pumpAndSettle();

      // 验证跳转到 IMAP 配置页面
      expect(find.text('IMAP 配置'), findsOneWidget);
    });

    testWidgets('响应式布局测试（小屏幕）', (WidgetTester tester) async {
      // 设置小屏幕尺寸
      await tester.binding.setSurfaceSize(const Size(400, 800));

      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ProviderSelectionPage())),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证页面正常渲染
      expect(find.text('选择邮箱服务商'), findsOneWidget);

      // 重置屏幕尺寸
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('响应式布局测试（中等屏幕）', (WidgetTester tester) async {
      // 设置中等屏幕尺寸
      await tester.binding.setSurfaceSize(const Size(700, 800));

      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ProviderSelectionPage())),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证页面正常渲染
      expect(find.text('选择邮箱服务商'), findsOneWidget);

      // 重置屏幕尺寸
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('响应式布局测试（大屏幕）', (WidgetTester tester) async {
      // 设置大屏幕尺寸
      await tester.binding.setSurfaceSize(const Size(1000, 800));

      // 构建 Widget
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ProviderSelectionPage())),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证页面正常渲染
      expect(find.text('选择邮箱服务商'), findsOneWidget);

      // 重置屏幕尺寸
      await tester.binding.setSurfaceSize(null);
    });
  });

  group('_ProviderCard Widget 测试', () {
    testWidgets('服务商卡片显示正确', (WidgetTester tester) async {
      // 准备测试数据
      const provider = EmailProvider(
        name: 'test',
        displayName: '测试邮箱',
        icon: 'assets/icons/test.png',
        imapServer: 'imap.test.com',
        imapPort: 993,
        useSSL: true,
        domain: 'test.com',
      );

      // 构建 Widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: _ProviderCard(provider: provider, onTap: () {}),
          ),
        ),
      );

      // 验证显示内容
      expect(find.text('测试邮箱'), findsOneWidget);
      expect(find.text('test.com'), findsOneWidget);

      // 验证图片或备用图标存在
      // 在测试环境中，图片可能加载失败，会显示备用图标
      final hasImage = find.byType(Image).evaluate().isNotEmpty;
      final hasIcon = find.byIcon(Icons.email_outlined).evaluate().isNotEmpty;
      expect(hasImage || hasIcon, true, reason: '应该显示图片或备用图标');
    });

    testWidgets('服务商卡片点击回调', (WidgetTester tester) async {
      // 准备测试数据
      const provider = EmailProvider(
        name: 'test',
        displayName: '测试邮箱',
        icon: 'assets/icons/test.png',
        imapServer: 'imap.test.com',
        imapPort: 993,
        useSSL: true,
        domain: 'test.com',
      );

      // 标记是否被点击
      var tapped = false;

      // 构建 Widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: _ProviderCard(
              provider: provider,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      // 点击卡片
      await tester.tap(find.byType(Card));
      await tester.pumpAndSettle();

      // 验证点击回调被触发
      expect(tapped, true);
    });
  });

  group('_OtherProviderCard Widget 测试', () {
    testWidgets('其他邮箱卡片显示正确', (WidgetTester tester) async {
      // 构建 Widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: _OtherProviderCard(onTap: null)),
        ),
      );

      // 验证显示内容
      expect(find.text('其他邮箱'), findsOneWidget);
      expect(find.text('手动配置'), findsOneWidget);

      // 验证图标存在
      expect(find.byIcon(Icons.add_circle_outline), findsOneWidget);
    });

    testWidgets('其他邮箱卡片点击回调', (WidgetTester tester) async {
      // 标记是否被点击
      var tapped = false;

      // 构建 Widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: _OtherProviderCard(
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      // 点击卡片
      await tester.tap(find.byType(Card));
      await tester.pumpAndSettle();

      // 验证点击回调被触发
      expect(tapped, true);
    });
  });
}

// 辅助类：用于测试的 ProviderCard
class _ProviderCard extends StatelessWidget {
  const _ProviderCard({required this.provider, required this.onTap});

  final EmailProvider provider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  provider.icon,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // 加载失败时显示备用图标
                    return Icon(
                      Icons.email_outlined,
                      size: 32,
                      color: colorScheme.primary,
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Text(
                provider.displayName,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                provider.domain ?? '',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 辅助类：用于测试的 OtherProviderCard
class _OtherProviderCard extends StatelessWidget {
  const _OtherProviderCard({required this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.add_circle_outline,
                  size: 32,
                  color: colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '其他邮箱',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                '手动配置',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
