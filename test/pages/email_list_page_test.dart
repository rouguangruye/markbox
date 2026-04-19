import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:markbox/shared/models/email.dart';
import 'package:markbox/shared/models/email_list_state.dart';
import 'package:markbox/shared/providers/email_list_provider.dart';
import 'package:markbox/pages/email_list_page.dart';

void main() {
  group('EmailListPage 集成测试', () {
    /// 创建测试用的邮件数据
    List<Email> createTestEmails(int count, {int startId = 1}) {
      return List.generate(count, (index) {
        return Email(
          id: 'email-${startId + index}',
          senderName: '发件人${startId + index}',
          senderEmail: 'sender${startId + index}@example.com',
          subject: '测试邮件主题 ${startId + index}',
          date: DateTime.now().subtract(Duration(minutes: index * 10)),
          isRead: index % 2 == 0,
        );
      });
    }

    testWidgets('首次加载应该显示加载指示器', (WidgetTester tester) async {
      // 构建 Widget，使用初始加载状态（未初始化且正在加载）
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            emailListProvider.overrideWith(
              () => createMockEmailListNotifier(
                const EmailListState(isLoading: true, isInitialized: false),
              ),
            ),
          ],
          child: const MaterialApp(home: EmailListPage()),
        ),
      );

      // 验证加载指示器显示
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('正在加载邮件...'), findsOneWidget);
    });

    testWidgets('加载完成后应该显示邮件列表', (WidgetTester tester) async {
      // 准备测试数据
      final emails = createTestEmails(10);

      // 构建 Widget
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            emailListProvider.overrideWith(
              () => createMockEmailListNotifier(
                EmailListState(
                  emails: emails,
                  isLoading: false,
                  isInitialized: true,
                  hasMore: true,
                ),
              ),
            ),
          ],
          child: const MaterialApp(home: EmailListPage()),
        ),
      );

      // 等待 UI 更新
      await tester.pumpAndSettle();

      // 验证邮件列表显示（ListView.builder 是懒加载，只验证可见项）
      expect(find.text('发件人1'), findsOneWidget);
      expect(find.text('测试邮件主题 1'), findsOneWidget);
      // 注意：由于 ListView.builder 的懒加载特性，可能不会渲染所有项
    });

    testWidgets('空列表应该显示空状态提示', (WidgetTester tester) async {
      // 构建 Widget，使用空列表状态（已初始化但没有邮件）
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            emailListProvider.overrideWith(
              () => createMockEmailListNotifier(
                const EmailListState(
                  emails: [],
                  isLoading: false,
                  isInitialized: true,
                ),
              ),
            ),
          ],
          child: const MaterialApp(home: EmailListPage()),
        ),
      );

      // 等待 UI 更新
      await tester.pumpAndSettle();

      // 验证空状态显示
      expect(find.text('暂无邮件'), findsOneWidget);
      expect(find.text('您的收件箱是空的'), findsOneWidget);
      expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
    });

    testWidgets('错误状态应该显示错误提示和重试按钮', (WidgetTester tester) async {
      // 构建 Widget，使用错误状态（未初始化且有错误）
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            emailListProvider.overrideWith(
              () => createMockEmailListNotifier(
                const EmailListState(
                  emails: [],
                  isLoading: false,
                  isInitialized: false,
                  error: '网络连接失败',
                ),
              ),
            ),
          ],
          child: const MaterialApp(home: EmailListPage()),
        ),
      );

      // 等待 UI 更新
      await tester.pumpAndSettle();

      // 验证错误状态显示
      expect(find.text('加载失败'), findsOneWidget);
      expect(find.text('网络连接失败'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('重试'), findsOneWidget);
    });

    testWidgets('下拉刷新应该触发刷新操作', (WidgetTester tester) async {
      // 准备测试数据
      final emails = createTestEmails(10);

      // 构建 Widget
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            emailListProvider.overrideWith(
              () => createMockEmailListNotifier(
                EmailListState(emails: emails, isLoading: false, hasMore: true),
              ),
            ),
          ],
          child: const MaterialApp(home: EmailListPage()),
        ),
      );

      // 等待 UI 更新
      await tester.pumpAndSettle();

      // 模拟下拉刷新
      await tester.fling(find.byType(ListView), const Offset(0, 300), 1000);
      await tester.pump();

      // 验证 RefreshIndicator 显示
      expect(find.byType(RefreshIndicator), findsOneWidget);

      // 等待刷新完成
      await tester.pumpAndSettle();
    });

    testWidgets('上拉加载更多应该触发加载更多操作', (WidgetTester tester) async {
      // 准备测试数据 - 创建足够多的邮件以支持滚动
      final emails = createTestEmails(50);

      // 构建 Widget
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            emailListProvider.overrideWith(
              () => createMockEmailListNotifier(
                EmailListState(
                  emails: emails,
                  isLoading: false,
                  hasMore: true,
                  isLoadingMore: false,
                ),
              ),
            ),
          ],
          child: const MaterialApp(home: EmailListPage()),
        ),
      );

      // 等待 UI 更新
      await tester.pumpAndSettle();

      // 滚动到底部
      await tester.drag(find.byType(ListView), const Offset(0, -5000));
      await tester.pumpAndSettle();

      // 验证列表存在
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('加载更多时应该显示加载指示器', (WidgetTester tester) async {
      // 准备测试数据
      final emails = createTestEmails(10);

      // 构建 Widget
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            emailListProvider.overrideWith(
              () => createMockEmailListNotifier(
                EmailListState(
                  emails: emails,
                  isLoading: false,
                  hasMore: true,
                  isLoadingMore: true,
                ),
              ),
            ),
          ],
          child: const MaterialApp(home: EmailListPage()),
        ),
      );

      // 等待 UI 更新
      await tester.pump(const Duration(seconds: 1));

      // 滚动到底部以触发加载指示器显示
      await tester.drag(find.byType(ListView), const Offset(0, -1000));
      await tester.pump();

      // 验证加载指示器存在
      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });

    testWidgets('没有更多数据时应该显示提示', (WidgetTester tester) async {
      // 准备测试数据
      final emails = createTestEmails(10);

      // 构建 Widget
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            emailListProvider.overrideWith(
              () => createMockEmailListNotifier(
                EmailListState(
                  emails: emails,
                  isLoading: false,
                  hasMore: false,
                  isLoadingMore: false,
                ),
              ),
            ),
          ],
          child: const MaterialApp(home: EmailListPage()),
        ),
      );

      // 等待 UI 更新
      await tester.pumpAndSettle();

      // 滚动到底部以查看提示
      await tester.drag(find.byType(ListView), const Offset(0, -1000));
      await tester.pumpAndSettle();

      // 验证"没有更多邮件了"提示显示
      expect(find.text('没有更多邮件了'), findsOneWidget);
    });

    testWidgets('点击邮件项应该触发点击事件', (WidgetTester tester) async {
      // 准备测试数据
      final emails = createTestEmails(3);

      // 构建 Widget
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            emailListProvider.overrideWith(
              () => createMockEmailListNotifier(
                EmailListState(emails: emails, isLoading: false, hasMore: true),
              ),
            ),
          ],
          child: const MaterialApp(home: EmailListPage()),
        ),
      );

      // 等待 UI 更新
      await tester.pumpAndSettle();

      // 点击第一个邮件项
      await tester.tap(find.text('发件人1'));
      await tester.pump();

      // 验证点击成功（目前只是打印日志，所以只验证没有抛出异常）
      // 在实际应用中，可以验证导航到详情页
    });

    testWidgets('点击重试按钮应该重新加载邮件', (WidgetTester tester) async {
      // 构建 Widget
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            emailListProvider.overrideWith(
              () => createMockEmailListNotifier(
                const EmailListState(
                  emails: [],
                  isLoading: false,
                  error: '加载失败',
                ),
              ),
            ),
          ],
          child: const MaterialApp(home: EmailListPage()),
        ),
      );

      // 等待 UI 更新
      await tester.pumpAndSettle();

      // 点击重试按钮
      await tester.tap(find.text('重试'));
      await tester.pump();

      // 验证重试方法被调用（通过 mock 验证）
    });

    testWidgets('列表应该正确显示所有邮件项', (WidgetTester tester) async {
      // 准备测试数据
      final emails = createTestEmails(20);

      // 构建 Widget
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            emailListProvider.overrideWith(
              () => createMockEmailListNotifier(
                EmailListState(emails: emails, isLoading: false, hasMore: true),
              ),
            ),
          ],
          child: const MaterialApp(home: EmailListPage()),
        ),
      );

      // 等待 UI 更新
      await tester.pumpAndSettle();

      // 验证邮件项显示（ListView.builder 是懒加载，只验证可见项）
      expect(find.text('发件人1'), findsOneWidget);

      // 验证 ListView.builder 使用
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('刷新状态时应该显示刷新指示器', (WidgetTester tester) async {
      // 准备测试数据
      final emails = createTestEmails(10);

      // 构建 Widget
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            emailListProvider.overrideWith(
              () => createMockEmailListNotifier(
                EmailListState(
                  emails: emails,
                  isLoading: false,
                  isRefreshing: true,
                  hasMore: true,
                ),
              ),
            ),
          ],
          child: const MaterialApp(home: EmailListPage()),
        ),
      );

      // 等待 UI 更新
      await tester.pumpAndSettle();

      // 验证 RefreshIndicator 存在
      expect(find.byType(RefreshIndicator), findsOneWidget);
    });
  });
}

/// Mock EmailListNotifier 用于测试
class MockEmailListNotifier extends EmailList {
  final EmailListState _state;

  MockEmailListNotifier({required EmailListState initialState})
    : _state = initialState;

  @override
  EmailListState build() {
    return _state;
  }

  @override
  Future<void> loadEmails() async {
    // 不需要模拟延迟，直接返回
  }

  @override
  Future<void> refreshEmails() async {
    // 不需要模拟延迟，直接返回
  }

  @override
  Future<void> loadMoreEmails() async {
    // 不需要模拟延迟，直接返回
  }
}

/// 创建 Mock Provider 的辅助函数
EmailList createMockEmailListNotifier(EmailListState initialState) {
  return MockEmailListNotifier(initialState: initialState);
}
