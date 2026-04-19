import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markbox/features/content_rendering/widgets/renderers/plain_text_renderer.dart';

void main() {
  group('PlainTextRenderer 组件测试', () {
    /// 测试基本文本渲染
    testWidgets('渲染基本文本内容', (WidgetTester tester) async {
      // 准备测试数据
      const content = '这是一段普通文本。\n可以包含多行。';

      // 构建 widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PlainTextRenderer(content: content)),
        ),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证组件已渲染
      expect(find.byType(PlainTextRenderer), findsOneWidget);
    });

    /// 测试代码文本渲染
    testWidgets('渲染代码文本', (WidgetTester tester) async {
      // 准备测试数据
      const content = '''
void main() {
  print('Hello, World!');
}

class Example {
  String name;
  int age;

  Example(this.name, this.age);
}
''';

      // 构建 widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PlainTextRenderer(content: content)),
        ),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证组件已渲染
      expect(find.byType(PlainTextRenderer), findsOneWidget);
    });

    /// 测试日志文本渲染
    testWidgets('渲染日志文本', (WidgetTester tester) async {
      // 准备测试数据
      const content = '''
[2024-01-15 10:30:45] INFO: 应用启动
[2024-01-15 10:30:46] DEBUG: 加载配置文件
[2024-01-15 10:30:47] INFO: 连接数据库
[2024-01-15 10:30:48] ERROR: 连接失败 - Connection refused
[2024-01-15 10:30:49] WARN: 重试连接...
''';

      // 构建 widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PlainTextRenderer(content: content)),
        ),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证组件已渲染
      expect(find.byType(PlainTextRenderer), findsOneWidget);
    });

    /// 测试空内容渲染
    testWidgets('渲染空内容', (WidgetTester tester) async {
      // 构建 widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PlainTextRenderer(content: '')),
        ),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证组件已渲染
      expect(find.byType(PlainTextRenderer), findsOneWidget);
    });

    /// 测试长文本渲染
    testWidgets('渲染长文本', (WidgetTester tester) async {
      // 准备测试数据（生成 1000 行文本）
      final content = List.generate(
        1000,
        (index) => '这是第 $index 行文本',
      ).join('\n');

      // 构建 widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PlainTextRenderer(content: content)),
        ),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证组件已渲染
      expect(find.byType(PlainTextRenderer), findsOneWidget);
    });

    /// 测试自定义字体大小
    testWidgets('应用自定义字体大小', (WidgetTester tester) async {
      // 准备测试数据
      const content = '测试文本';

      // 构建 widget（自定义字体大小）
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PlainTextRenderer(content: content, fontSize: 18.0),
          ),
        ),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证组件已渲染
      expect(find.byType(PlainTextRenderer), findsOneWidget);
    });

    /// 测试自定义行高
    testWidgets('应用自定义行高', (WidgetTester tester) async {
      // 准备测试数据
      const content = '测试文本\n第二行\n第三行';

      // 构建 widget（自定义行高）
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PlainTextRenderer(content: content, lineHeight: 2.0),
          ),
        ),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证组件已渲染
      expect(find.byType(PlainTextRenderer), findsOneWidget);
    });

    /// 测试自定义颜色
    testWidgets('应用自定义颜色', (WidgetTester tester) async {
      // 准备测试数据
      const content = '测试文本';

      // 构建 widget（自定义颜色）
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PlainTextRenderer(
              content: content,
              textColor: Colors.green,
              backgroundColor: Colors.black,
            ),
          ),
        ),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证组件已渲染
      expect(find.byType(PlainTextRenderer), findsOneWidget);
    });

    /// 测试自定义内边距
    testWidgets('应用自定义内边距', (WidgetTester tester) async {
      // 准备测试数据
      const content = '测试文本';

      // 构建 widget（自定义内边距）
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PlainTextRenderer(
              content: content,
              padding: EdgeInsets.all(32),
            ),
          ),
        ),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证组件已渲染
      expect(find.byType(PlainTextRenderer), findsOneWidget);
    });

    /// 测试完整自定义样式
    testWidgets('应用完整自定义样式', (WidgetTester tester) async {
      // 准备测试数据
      const content = '测试文本\n第二行';

      // 构建 widget（完整自定义样式）
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PlainTextRenderer(
              content: content,
              fontSize: 16.0,
              lineHeight: 1.8,
              textColor: Colors.white,
              backgroundColor: Color(0xFF2D2D2D),
              padding: EdgeInsets.all(24),
            ),
          ),
        ),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证组件已渲染
      expect(find.byType(PlainTextRenderer), findsOneWidget);
    });

    /// 测试特殊字符
    testWidgets('渲染特殊字符', (WidgetTester tester) async {
      // 准备测试数据
      const content = '''
特殊字符测试：
- Emoji: 😀 🎉 ✅
- 符号: @ # \$ % ^ & * ( ) [ ] { } < > ? / \\ | ~ `
- Unicode: 中文 日本語 한국어 العربية
- 空格和制表符:
  - 空格:     (5个空格)
  - 制表符: \t\t(2个制表符)
''';

      // 构建 widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PlainTextRenderer(content: content)),
        ),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证组件已渲染
      expect(find.byType(PlainTextRenderer), findsOneWidget);
    });

    /// 测试文本选择功能
    testWidgets('支持文本选择', (WidgetTester tester) async {
      // 准备测试数据
      const content = '这是可以选择的文本';

      // 构建 widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PlainTextRenderer(content: content)),
        ),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证组件已渲染
      expect(find.byType(PlainTextRenderer), findsOneWidget);

      // 注意：SelectableText 的选择功能需要更复杂的交互测试，
      // 这里只验证组件构建成功
    });

    /// 测试滚动功能
    testWidgets('支持滚动', (WidgetTester tester) async {
      // 准备测试数据（长文本）
      final content = List.generate(100, (index) => '第 $index 行').join('\n');

      // 构建 widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 300,
              child: PlainTextRenderer(content: content),
            ),
          ),
        ),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证组件已渲染
      expect(find.byType(PlainTextRenderer), findsOneWidget);

      // 验证可以滚动
      final scrollView = find.byType(SingleChildScrollView);
      expect(scrollView, findsOneWidget);
    });
  });

  group('PlainTextRenderer 默认值测试', () {
    /// 测试默认字体大小
    test('默认字体大小为 14.0', () {
      const renderer = PlainTextRenderer(content: 'test');
      expect(renderer.fontSize, equals(14.0));
    });

    /// 测试默认行高
    test('默认行高为 1.5', () {
      const renderer = PlainTextRenderer(content: 'test');
      expect(renderer.lineHeight, equals(1.5));
    });

    /// 测试默认文本颜色
    test('默认文本颜色为白色', () {
      const renderer = PlainTextRenderer(content: 'test');
      expect(renderer.textColor, equals(const Color(0xFFFFFFFF)));
    });

    /// 测试默认背景色
    test('默认背景色为深色', () {
      const renderer = PlainTextRenderer(content: 'test');
      expect(renderer.backgroundColor, equals(const Color(0xFF1E1E1E)));
    });

    /// 测试默认内边距
    test('默认内边距为 16.0', () {
      const renderer = PlainTextRenderer(content: 'test');
      expect(renderer.padding, equals(const EdgeInsets.all(16.0)));
    });
  });

  group('PlainTextRenderer 边界情况测试', () {
    /// 测试超长单行文本
    testWidgets('渲染超长单行文本', (WidgetTester tester) async {
      // 准备测试数据（1000 字符的单行）
      final content = 'A' * 1000;

      // 构建 widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PlainTextRenderer(content: content)),
        ),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证组件已渲染
      expect(find.byType(PlainTextRenderer), findsOneWidget);
    });

    /// 测试大量换行符
    testWidgets('渲染大量换行符', (WidgetTester tester) async {
      // 准备测试数据（100 个换行符）
      final content = '\n' * 100;

      // 构建 widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PlainTextRenderer(content: content)),
        ),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证组件已渲染
      expect(find.byType(PlainTextRenderer), findsOneWidget);
    });

    /// 测试混合空白字符
    testWidgets('渲染混合空白字符', (WidgetTester tester) async {
      // 准备测试数据
      const content = '  空格开头\n\t制表符\n\n\n多个换行\n  ';

      // 构建 widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PlainTextRenderer(content: content)),
        ),
      );

      // 等待渲染完成
      await tester.pumpAndSettle();

      // 验证组件已渲染
      expect(find.byType(PlainTextRenderer), findsOneWidget);
    });
  });
}
