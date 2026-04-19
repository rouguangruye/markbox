import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:markbox/shared/models/email.dart';
import 'package:markbox/widgets/email_list_item.dart';

void main() {
  group('EmailListItemWidget 测试', () {
    /// 创建测试用的邮件数据
    Email createTestEmail({
      String id = 'test-id',
      String? senderName,
      required String senderEmail,
      String subject = '测试主题',
      DateTime? date,
      bool isRead = false,
    }) {
      return Email(
        id: id,
        senderName: senderName,
        senderEmail: senderEmail,
        subject: subject,
        date: date ?? DateTime.now(),
        isRead: isRead,
      );
    }

    testWidgets('应该正确渲染邮件列表项的所有内容', (WidgetTester tester) async {
      // 准备测试数据
      final email = createTestEmail(
        senderName: '张三',
        senderEmail: 'zhangsan@example.com',
        subject: '这是一封测试邮件',
        date: DateTime.now().subtract(const Duration(minutes: 5)),
      );

      // 构建 Widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmailListItemWidget(email: email, onTap: () {}),
          ),
        ),
      );

      // 验证发件人名称显示
      expect(find.text('张三'), findsOneWidget);

      // 验证邮件主题显示
      expect(find.text('这是一封测试邮件'), findsOneWidget);

      // 验证相对时间显示
      expect(find.text('5分钟前'), findsOneWidget);
    });

    testWidgets('发件人名称降级逻辑：当 senderName 为空时应该显示 senderEmail', (
      WidgetTester tester,
    ) async {
      // 准备测试数据 - senderName 为空
      final email = createTestEmail(
        senderName: null,
        senderEmail: 'lisi@example.com',
        subject: '测试邮件',
      );

      // 构建 Widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmailListItemWidget(email: email, onTap: () {}),
          ),
        ),
      );

      // 验证显示邮箱地址
      expect(find.text('lisi@example.com'), findsOneWidget);
    });

    testWidgets('发件人名称降级逻辑：当 senderName 为空字符串时应该显示 senderEmail', (
      WidgetTester tester,
    ) async {
      // 准备测试数据 - senderName 为空字符串
      final email = createTestEmail(
        senderName: '',
        senderEmail: 'wangwu@example.com',
        subject: '测试邮件',
      );

      // 构建 Widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmailListItemWidget(email: email, onTap: () {}),
          ),
        ),
      );

      // 验证显示邮箱地址
      expect(find.text('wangwu@example.com'), findsOneWidget);
    });

    testWidgets('相对时间格式化：刚刚（小于1分钟）', (WidgetTester tester) async {
      // 准备测试数据 - 30秒前
      final email = createTestEmail(
        senderEmail: 'test@example.com',
        date: DateTime.now().subtract(const Duration(seconds: 30)),
      );

      // 构建 Widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmailListItemWidget(email: email, onTap: () {}),
          ),
        ),
      );

      // 验证显示"刚刚"
      expect(find.text('刚刚'), findsOneWidget);
    });

    testWidgets('相对时间格式化：分钟前（小于1小时）', (WidgetTester tester) async {
      // 准备测试数据 - 30分钟前
      final email = createTestEmail(
        senderEmail: 'test@example.com',
        date: DateTime.now().subtract(const Duration(minutes: 30)),
      );

      // 构建 Widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmailListItemWidget(email: email, onTap: () {}),
          ),
        ),
      );

      // 验证显示"30分钟前"
      expect(find.text('30分钟前'), findsOneWidget);
    });

    testWidgets('相对时间格式化：小时前（小于24小时）', (WidgetTester tester) async {
      // 准备测试数据 - 5小时前
      final email = createTestEmail(
        senderEmail: 'test@example.com',
        date: DateTime.now().subtract(const Duration(hours: 5)),
      );

      // 构建 Widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmailListItemWidget(email: email, onTap: () {}),
          ),
        ),
      );

      // 验证显示"5小时前"
      expect(find.text('5小时前'), findsOneWidget);
    });

    testWidgets('相对时间格式化：天前（大于等于24小时）', (WidgetTester tester) async {
      // 准备测试数据 - 3天前
      final email = createTestEmail(
        senderEmail: 'test@example.com',
        date: DateTime.now().subtract(const Duration(days: 3)),
      );

      // 构建 Widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmailListItemWidget(email: email, onTap: () {}),
          ),
        ),
      );

      // 验证显示"3天前"
      expect(find.text('3天前'), findsOneWidget);
    });

    testWidgets('点击事件应该被正确触发', (WidgetTester tester) async {
      // 准备测试数据
      bool tapped = false;
      final email = createTestEmail(
        senderEmail: 'test@example.com',
        subject: '测试点击',
      );

      // 构建 Widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmailListItemWidget(
              email: email,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      // 查找 InkWell 并触发点击
      final inkWell = find.byType(InkWell);
      expect(inkWell, findsOneWidget);

      // 模拟点击
      await tester.tap(inkWell);
      await tester.pump();

      // 验证点击事件被触发
      expect(tapped, isTrue);
    });

    testWidgets('长主题应该被截断并显示省略号', (WidgetTester tester) async {
      // 准备测试数据 - 超长主题
      final longSubject = '这是一封非常非常非常非常非常非常非常非常非常非常非常非常非常非常非常长的邮件主题';
      final email = createTestEmail(
        senderEmail: 'test@example.com',
        subject: longSubject,
      );

      // 构建 Widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300, // 限制宽度
              child: EmailListItemWidget(email: email, onTap: () {}),
            ),
          ),
        ),
      );

      // 验证主题文本存在
      final subjectWidget = find.text(longSubject);
      expect(subjectWidget, findsOneWidget);

      // 验证文本溢出属性
      final textWidget = tester.widget<Text>(subjectWidget);
      expect(textWidget.maxLines, equals(1));
      expect(textWidget.overflow, equals(TextOverflow.ellipsis));
    });

    testWidgets('未读邮件发件人名称应该使用中等字重', (WidgetTester tester) async {
      // 准备测试数据 - 未读邮件
      final email = createTestEmail(
        senderName: '测试用户',
        senderEmail: 'test@example.com',
        isRead: false,
      );

      // 构建 Widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmailListItemWidget(email: email, onTap: () {}),
          ),
        ),
      );

      // 查找发件人名称文本
      final senderText = find.text('测试用户');
      expect(senderText, findsOneWidget);

      // 验证文本样式 - 使用 w500
      final textWidget = tester.widget<Text>(senderText);
      expect(textWidget.style?.fontWeight, equals(FontWeight.w500));
    });

    testWidgets('已读邮件发件人名称应该使用中等字重', (WidgetTester tester) async {
      // 准备测试数据 - 已读邮件
      final email = createTestEmail(
        senderName: '测试用户',
        senderEmail: 'test@example.com',
        isRead: true,
      );

      // 构建 Widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmailListItemWidget(email: email, onTap: () {}),
          ),
        ),
      );

      // 查找发件人名称文本
      final senderText = find.text('测试用户');
      expect(senderText, findsOneWidget);

      // 验证文本样式 - 使用 w500
      final textWidget = tester.widget<Text>(senderText);
      expect(textWidget.style?.fontWeight, equals(FontWeight.w500));
    });

    testWidgets('未读邮件主题应该使用正常字重', (WidgetTester tester) async {
      // 准备测试数据 - 未读邮件
      final email = createTestEmail(
        senderEmail: 'test@example.com',
        subject: '测试主题',
        isRead: false,
      );

      // 构建 Widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmailListItemWidget(email: email, onTap: () {}),
          ),
        ),
      );

      // 查找主题文本
      final subjectText = find.text('测试主题');
      expect(subjectText, findsOneWidget);

      // 验证文本样式 - 使用正常字重
      final textWidget = tester.widget<Text>(subjectText);
      expect(
        textWidget.style?.fontWeight == null ||
            textWidget.style?.fontWeight == FontWeight.normal,
        isTrue,
      );
    });

    testWidgets('已读邮件主题应该使用正常字重', (WidgetTester tester) async {
      // 准备测试数据 - 已读邮件
      final email = createTestEmail(
        senderEmail: 'test@example.com',
        subject: '测试主题',
        isRead: true,
      );

      // 构建 Widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmailListItemWidget(email: email, onTap: () {}),
          ),
        ),
      );

      // 查找主题文本
      final subjectText = find.text('测试主题');
      expect(subjectText, findsOneWidget);

      // 验证文本样式 - 使用正常字重
      final textWidget = tester.widget<Text>(subjectText);
      expect(
        textWidget.style?.fontWeight == null ||
            textWidget.style?.fontWeight == FontWeight.normal,
        isTrue,
      );
    });
  });
}
