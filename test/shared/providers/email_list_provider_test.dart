import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markbox/services/email_service.dart';
import 'package:markbox/shared/models/account_config_state.dart';
import 'package:markbox/shared/models/email.dart';
import 'package:markbox/shared/models/email_list_state.dart';
import 'package:markbox/shared/models/imap_config.dart';
import 'package:markbox/shared/providers/account_config_provider.dart';
import 'package:markbox/shared/providers/email_list_provider.dart';
import 'package:mocktail/mocktail.dart';

// Mock 类
class MockEmailService extends Mock implements EmailService {}

// Fake 类用于注册 fallback value
class FakeImapConfig extends Fake implements ImapConfig {}

void main() {
  late ProviderContainer container;
  late MockEmailService mockEmailService;

  // 测试用的 IMAP 配置
  const testImapConfig = ImapConfig(
    server: 'imap.test.com',
    port: 993,
    email: 'test@test.com',
    password: 'password',
    useSSL: true,
  );

  // 测试用的邮件列表
  final testEmails = List.generate(
    10,
    (index) => Email(
      id: 'email_$index',
      senderEmail: 'sender$index@test.com',
      subject: '测试邮件 $index',
      date: DateTime.now().subtract(Duration(days: index)),
      isRead: index % 2 == 0,
    ),
  );

  setUpAll(() {
    // 注册 fallback value
    registerFallbackValue(FakeImapConfig());
  });

  setUp(() {
    // 初始化 Mock
    mockEmailService = MockEmailService();

    // 创建 ProviderContainer，并覆盖依赖
    container = ProviderContainer(
      overrides: [
        // 覆盖 EmailService Provider
        emailServiceProvider.overrideWithValue(mockEmailService),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('EmailListState 模型测试', () {
    test('初始状态正确', () {
      const state = EmailListState();

      // 验证默认值
      expect(state.emails, isEmpty);
      expect(state.isLoading, false);
      expect(state.isRefreshing, false);
      expect(state.isLoadingMore, false);
      expect(state.error, isNull);
      expect(state.currentPage, 1);
      expect(state.hasMore, true);
      expect(state.totalCount, isNull);
    });

    test('状态 copyWith 修改 emails', () {
      const original = EmailListState();
      final modified = original.copyWith(emails: testEmails);

      expect(modified.emails, equals(testEmails));
      expect(modified.isLoading, false);
      expect(modified.currentPage, 1);
    });

    test('状态 copyWith 修改 isLoading', () {
      const original = EmailListState();
      final modified = original.copyWith(isLoading: true);

      expect(modified.isLoading, true);
      expect(modified.isRefreshing, false);
      expect(modified.isLoadingMore, false);
    });

    test('状态 copyWith 修改 isRefreshing', () {
      const original = EmailListState();
      final modified = original.copyWith(isRefreshing: true);

      expect(modified.isRefreshing, true);
      expect(modified.isLoading, false);
      expect(modified.isLoadingMore, false);
    });

    test('状态 copyWith 修改 isLoadingMore', () {
      const original = EmailListState();
      final modified = original.copyWith(isLoadingMore: true);

      expect(modified.isLoadingMore, true);
      expect(modified.isLoading, false);
      expect(modified.isRefreshing, false);
    });

    test('状态 copyWith 修改 error', () {
      const original = EmailListState();
      final modified = original.copyWith(error: '测试错误');

      expect(modified.error, '测试错误');
      expect(modified.isLoading, false);
    });

    test('状态 copyWith 修改 currentPage', () {
      const original = EmailListState();
      final modified = original.copyWith(currentPage: 2);

      expect(modified.currentPage, 2);
    });

    test('状态 copyWith 修改 hasMore', () {
      const original = EmailListState();
      final modified = original.copyWith(hasMore: false);

      expect(modified.hasMore, false);
    });

    test('状态 copyWith 修改 totalCount', () {
      const original = EmailListState();
      final modified = original.copyWith(totalCount: 100);

      expect(modified.totalCount, 100);
    });

    test('状态 copyWith 清除 error', () {
      const original = EmailListState(error: '原有错误');
      final modified = original.copyWith(error: null);

      expect(modified.error, isNull);
    });
  });

  group('EmailListProvider 初始化测试', () {
    test('初始状态正确', () {
      // 监听 Provider
      final state = container.read(emailListProvider);

      // 验证初始状态
      expect(state.emails, isEmpty);
      expect(state.isLoading, false);
      expect(state.isRefreshing, false);
      expect(state.isLoadingMore, false);
      expect(state.error, isNull);
      expect(state.currentPage, 1);
      expect(state.hasMore, true);
      expect(state.totalCount, isNull);
    });
  });

  group('EmailListProvider 加载邮件测试', () {
    test('加载邮件成功', () async {
      // 设置账户配置
      container.read(accountConfigProvider.notifier).state =
          const AccountConfigState(currentConfig: testImapConfig);

      // 设置 Mock 返回值
      when(
        () => mockEmailService.fetchEmails(
          config: any(named: 'config'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).thenAnswer(
        (_) async => FetchEmailsResult(
          emails: testEmails,
          hasMore: true,
          totalCount: 100,
        ),
      );

      // 执行加载
      await container.read(emailListProvider.notifier).loadEmails();

      // 验证状态
      final state = container.read(emailListProvider);
      expect(state.emails, equals(testEmails));
      expect(state.isLoading, false);
      expect(state.currentPage, 1);
      expect(state.hasMore, true);
      expect(state.totalCount, 100);
      expect(state.error, isNull);

      // 验证 Mock 调用
      verify(
        () => mockEmailService.fetchEmails(
          config: testImapConfig,
          page: 1,
          pageSize: 50,
        ),
      ).called(1);
    });

    test('加载邮件失败（未配置账户）', () async {
      // 不设置账户配置

      // 执行加载
      await container.read(emailListProvider.notifier).loadEmails();

      // 验证状态
      final state = container.read(emailListProvider);
      expect(state.emails, isEmpty);
      expect(state.isLoading, false);
      expect(state.error, '未配置邮箱账户');

      // 验证 Mock 未被调用（因为没有设置 when，如果被调用会抛出异常）
    });

    test('加载邮件失败（网络错误）', () async {
      // 设置账户配置
      container.read(accountConfigProvider.notifier).state =
          const AccountConfigState(currentConfig: testImapConfig);

      // 设置 Mock 抛出异常
      when(
        () => mockEmailService.fetchEmails(
          config: any(named: 'config'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).thenThrow(
        EmailServiceException(
          '网络连接失败',
          errorType: EmailServiceErrorType.networkError,
        ),
      );

      // 执行加载
      await container.read(emailListProvider.notifier).loadEmails();

      // 验证状态
      final state = container.read(emailListProvider);
      expect(state.emails, isEmpty);
      expect(state.isLoading, false);
      expect(state.error, '网络连接失败');
    });
  });

  group('EmailListProvider 刷新邮件测试', () {
    test('刷新邮件成功', () async {
      // 设置账户配置
      container.read(accountConfigProvider.notifier).state =
          const AccountConfigState(currentConfig: testImapConfig);

      // 设置 Mock 返回值
      when(
        () => mockEmailService.fetchEmails(
          config: any(named: 'config'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).thenAnswer(
        (_) async => FetchEmailsResult(
          emails: testEmails,
          hasMore: true,
          totalCount: 100,
        ),
      );

      // 执行刷新
      await container.read(emailListProvider.notifier).refreshEmails();

      // 验证状态
      final state = container.read(emailListProvider);
      expect(state.emails, equals(testEmails));
      expect(state.isRefreshing, false);
      expect(state.currentPage, 1);
      expect(state.hasMore, true);
      expect(state.totalCount, 100);
      expect(state.error, isNull);

      // 验证 Mock 调用
      verify(
        () => mockEmailService.fetchEmails(
          config: testImapConfig,
          page: 1,
          pageSize: 50,
        ),
      ).called(1);
    });

    test('刷新邮件失败（未配置账户）', () async {
      // 不设置账户配置

      // 执行刷新
      await container.read(emailListProvider.notifier).refreshEmails();

      // 验证状态
      final state = container.read(emailListProvider);
      expect(state.emails, isEmpty);
      expect(state.isRefreshing, false);
      expect(state.error, '未配置邮箱账户');
    });
  });

  group('EmailListProvider 分页加载测试', () {
    test('加载更多邮件成功', () async {
      // 设置账户配置
      container.read(accountConfigProvider.notifier).state =
          const AccountConfigState(currentConfig: testImapConfig);

      // 设置初始状态（已加载第一页）
      container.read(emailListProvider.notifier).state = EmailListState(
        emails: testEmails.sublist(0, 5),
        currentPage: 1,
        hasMore: true,
      );

      // 第二页邮件
      final page2Emails = List.generate(
        5,
        (index) => Email(
          id: 'email_page2_$index',
          senderEmail: 'sender_page2_$index@test.com',
          subject: '测试邮件 第二页 $index',
          date: DateTime.now().subtract(Duration(days: index + 5)),
          isRead: false,
        ),
      );

      // 设置 Mock 返回值
      when(
        () => mockEmailService.fetchEmails(
          config: any(named: 'config'),
          page: 2,
          pageSize: any(named: 'pageSize'),
        ),
      ).thenAnswer(
        (_) async => FetchEmailsResult(
          emails: page2Emails,
          hasMore: false,
          totalCount: 10,
        ),
      );

      // 执行加载更多
      await container.read(emailListProvider.notifier).loadMoreEmails();

      // 验证状态
      final state = container.read(emailListProvider);
      expect(state.emails.length, 10); // 第一页 5 封 + 第二页 5 封
      expect(state.isLoadingMore, false);
      expect(state.currentPage, 2);
      expect(state.hasMore, false);
      expect(state.totalCount, 10);
      expect(state.error, isNull);

      // 验证 Mock 调用
      verify(
        () => mockEmailService.fetchEmails(
          config: testImapConfig,
          page: 2,
          pageSize: 50,
        ),
      ).called(1);
    });

    test('加载更多邮件失败（没有更多数据）', () async {
      // 设置初始状态（没有更多数据）
      container.read(emailListProvider.notifier).state = const EmailListState(
        emails: [],
        currentPage: 1,
        hasMore: false,
      );

      // 执行加载更多
      await container.read(emailListProvider.notifier).loadMoreEmails();

      // 验证状态未改变
      final state = container.read(emailListProvider);
      expect(state.emails, isEmpty);
      expect(state.currentPage, 1);
      expect(state.hasMore, false);

      // 验证 Mock 未被调用（因为没有设置 when，如果被调用会抛出异常）
    });

    test('加载更多邮件失败（正在加载）', () async {
      // 设置初始状态（正在加载）
      container.read(emailListProvider.notifier).state = const EmailListState(
        emails: [],
        currentPage: 1,
        hasMore: true,
        isLoadingMore: true,
      );

      // 执行加载更多
      await container.read(emailListProvider.notifier).loadMoreEmails();

      // 验证状态未改变
      final state = container.read(emailListProvider);
      expect(state.isLoadingMore, true);

      // 验证 Mock 未被调用（因为没有设置 when，如果被调用会抛出异常）
    });
  });

  group('EmailListProvider 工具方法测试', () {
    test('清除错误信息', () {
      // 设置初始状态（有错误）
      container.read(emailListProvider.notifier).state = const EmailListState(
        error: '测试错误',
      );

      // 执行清除错误
      container.read(emailListProvider.notifier).clearError();

      // 验证状态
      final state = container.read(emailListProvider);
      expect(state.error, isNull);
    });

    test('重置状态', () {
      // 设置初始状态（有数据）
      container.read(emailListProvider.notifier).state = EmailListState(
        emails: testEmails,
        currentPage: 2,
        hasMore: false,
        totalCount: 100,
        error: '测试错误',
      );

      // 执行重置
      container.read(emailListProvider.notifier).reset();

      // 验证状态
      final state = container.read(emailListProvider);
      expect(state.emails, isEmpty);
      expect(state.isLoading, false);
      expect(state.isRefreshing, false);
      expect(state.isLoadingMore, false);
      expect(state.error, isNull);
      expect(state.currentPage, 1);
      expect(state.hasMore, true);
      expect(state.totalCount, isNull);
    });
  });

  group('EmailListProvider 状态管理测试', () {
    test('状态不可变性', () {
      // 获取初始状态
      final state1 = container.read(emailListProvider);

      // 再次获取状态
      final state2 = container.read(emailListProvider);

      // 验证是同一个实例（因为是 const）
      expect(state1, equals(state2));
    });

    test('状态包含正确的默认值', () {
      final state = container.read(emailListProvider);

      // 验证默认值
      expect(state.emails, isEmpty);
      expect(state.isLoading, false);
      expect(state.isRefreshing, false);
      expect(state.isLoadingMore, false);
      expect(state.error, isNull);
      expect(state.currentPage, 1);
      expect(state.hasMore, true);
      expect(state.totalCount, isNull);
    });
  });
}
