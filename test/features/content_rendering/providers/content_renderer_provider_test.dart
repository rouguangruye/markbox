import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markbox/features/content_rendering/providers/content_renderer_provider.dart';
import 'package:markbox/features/email_parser/models/email_content_type.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    // 创建 ProviderContainer
    container = ProviderContainer();
  });

  tearDown(() {
    // 清理资源
    container.dispose();
  });

  group('ContentRendererState 模型测试', () {
    /// 测试初始状态
    test('初始状态正确', () {
      const state = ContentRendererState();

      // 验证默认值
      expect(state.content, isNull);
      expect(state.contentType, equals(EmailContentType.unknown));
      expect(state.renderStatus, equals(RenderStatus.initial));
      expect(state.errorMessage, isNull);
    });

    /// 测试 copyWith 修改 content
    test('状态 copyWith 修改 content', () {
      const original = ContentRendererState();
      final modified = original.copyWith(content: '测试内容');

      expect(modified.content, equals('测试内容'));
      expect(modified.contentType, equals(EmailContentType.unknown));
      expect(modified.renderStatus, equals(RenderStatus.initial));
    });

    /// 测试 copyWith 修改 contentType
    test('状态 copyWith 修改 contentType', () {
      const original = ContentRendererState();
      final modified = original.copyWith(contentType: EmailContentType.html);

      expect(modified.content, isNull);
      expect(modified.contentType, equals(EmailContentType.html));
      expect(modified.renderStatus, equals(RenderStatus.initial));
    });

    /// 测试 copyWith 修改 renderStatus
    test('状态 copyWith 修改 renderStatus', () {
      const original = ContentRendererState();
      final modified = original.copyWith(renderStatus: RenderStatus.loading);

      expect(modified.content, isNull);
      expect(modified.contentType, equals(EmailContentType.unknown));
      expect(modified.renderStatus, equals(RenderStatus.loading));
    });

    /// 测试 copyWith 修改 errorMessage
    test('状态 copyWith 修改 errorMessage', () {
      const original = ContentRendererState();
      final modified = original.copyWith(errorMessage: '测试错误');

      expect(modified.content, isNull);
      expect(modified.errorMessage, equals('测试错误'));
    });

    /// 测试 copyWith 清除 content
    test('状态 copyWith 清除 content', () {
      const original = ContentRendererState(content: '原有内容');
      final modified = original.copyWith(clearContent: true);

      expect(modified.content, isNull);
    });

    /// 测试 copyWith 清除 error
    test('状态 copyWith 清除 error', () {
      const original = ContentRendererState(errorMessage: '原有错误');
      final modified = original.copyWith(clearError: true);

      expect(modified.errorMessage, isNull);
    });

    /// 测试 toString 方法
    test('toString 方法返回正确格式', () {
      const state = ContentRendererState(
        content: '测试内容',
        contentType: EmailContentType.markdown,
        renderStatus: RenderStatus.success,
        errorMessage: null,
      );

      final str = state.toString();

      // toString 返回内容长度，而不是内容本身
      expect(str.contains('4 chars'), isTrue);
      expect(str.contains('markdown'), isTrue);
      expect(str.contains('success'), isTrue);
    });
  });

  group('ContentRenderer Provider 初始化测试', () {
    /// 测试初始状态
    test('初始状态正确', () {
      // 监听 Provider
      final state = container.read(contentRendererProvider);

      // 验证初始状态
      expect(state.content, isNull);
      expect(state.contentType, equals(EmailContentType.unknown));
      expect(state.renderStatus, equals(RenderStatus.initial));
      expect(state.errorMessage, isNull);
    });
  });

  group('ContentRenderer Provider 内容设置测试', () {
    /// 测试设置 Markdown 内容
    test('设置 Markdown 内容', () async {
      // 准备测试数据
      const markdownContent = '''
# 标题

- 列表项 1
- 列表项 2

**粗体文本**
''';

      // 设置内容
      await container
          .read(contentRendererProvider.notifier)
          .setContent(markdownContent);

      // 验证状态
      final state = container.read(contentRendererProvider);
      expect(state.content, equals(markdownContent));
      expect(state.contentType, equals(EmailContentType.markdown));
      expect(state.renderStatus, equals(RenderStatus.success));
      expect(state.errorMessage, isNull);
    });

    /// 测试设置 HTML 内容
    test('设置 HTML 内容', () async {
      // 准备测试数据
      const htmlContent = '''
<!DOCTYPE html>
<html>
<body>
  <h1>标题</h1>
  <p>段落</p>
</body>
</html>
''';

      // 设置内容
      await container
          .read(contentRendererProvider.notifier)
          .setContent(htmlContent);

      // 验证状态
      final state = container.read(contentRendererProvider);
      expect(state.content, equals(htmlContent));
      expect(state.contentType, equals(EmailContentType.html));
      expect(state.renderStatus, equals(RenderStatus.success));
      expect(state.errorMessage, isNull);
    });

    /// 测试设置纯文本内容
    test('设置纯文本内容', () async {
      // 准备测试数据
      const plainTextContent = '这是一段普通文本，没有特殊格式。';

      // 设置内容
      await container
          .read(contentRendererProvider.notifier)
          .setContent(plainTextContent);

      // 验证状态
      final state = container.read(contentRendererProvider);
      expect(state.content, equals(plainTextContent));
      expect(state.contentType, equals(EmailContentType.plainText));
      expect(state.renderStatus, equals(RenderStatus.success));
      expect(state.errorMessage, isNull);
    });

    /// 测试设置空内容
    test('设置空内容', () async {
      // 设置空内容
      await container.read(contentRendererProvider.notifier).setContent('');

      // 验证状态
      final state = container.read(contentRendererProvider);
      expect(state.content, isNull);
      expect(state.contentType, equals(EmailContentType.unknown));
      expect(state.renderStatus, equals(RenderStatus.initial));
      expect(state.errorMessage, isNull);
    });

    /// 测试清除内容
    test('清除内容', () async {
      // 先设置内容
      await container.read(contentRendererProvider.notifier).setContent('# 标题');

      // 清除内容
      container.read(contentRendererProvider.notifier).clearContent();

      // 验证状态
      final state = container.read(contentRendererProvider);
      expect(state.content, isNull);
      expect(state.contentType, equals(EmailContentType.unknown));
      expect(state.renderStatus, equals(RenderStatus.initial));
      expect(state.errorMessage, isNull);
    });
  });

  group('ContentRenderer Provider 内容类型检测测试', () {
    /// 测试检测 HTML 内容 - DOCTYPE
    test('检测 HTML 内容 - DOCTYPE', () async {
      const content = '<!DOCTYPE html><html><body>内容</body></html>';

      await container
          .read(contentRendererProvider.notifier)
          .setContent(content);

      final state = container.read(contentRendererProvider);
      expect(state.contentType, equals(EmailContentType.html));
    });

    /// 测试检测 HTML 内容 - 常见标签
    test('检测 HTML 内容 - 常见标签', () async {
      const content = '<div><p>段落</p><span>文本</span></div>';

      await container
          .read(contentRendererProvider.notifier)
          .setContent(content);

      final state = container.read(contentRendererProvider);
      expect(state.contentType, equals(EmailContentType.html));
    });

    /// 测试检测 HTML 内容 - 闭合标签
    test('检测 HTML 内容 - 闭合标签', () async {
      const content = '文本</p>更多文本';

      await container
          .read(contentRendererProvider.notifier)
          .setContent(content);

      final state = container.read(contentRendererProvider);
      expect(state.contentType, equals(EmailContentType.html));
    });

    /// 测试检测 Markdown 内容 - 标题
    test('检测 Markdown 内容 - 标题', () async {
      const content = '''
# 一级标题
## 二级标题
### 三级标题
''';

      await container
          .read(contentRendererProvider.notifier)
          .setContent(content);

      final state = container.read(contentRendererProvider);
      expect(state.contentType, equals(EmailContentType.markdown));
    });

    /// 测试检测 Markdown 内容 - 列表
    test('检测 Markdown 内容 - 列表', () async {
      const content = '''
- 列表项 1
- 列表项 2
- 列表项 3
''';

      await container
          .read(contentRendererProvider.notifier)
          .setContent(content);

      final state = container.read(contentRendererProvider);
      expect(state.contentType, equals(EmailContentType.markdown));
    });

    /// 测试检测 Markdown 内容 - 代码块
    test('检测 Markdown 内容 - 代码块', () async {
      const content = '''
```dart
void main() {
  print('Hello');
}
```
''';

      await container
          .read(contentRendererProvider.notifier)
          .setContent(content);

      final state = container.read(contentRendererProvider);
      expect(state.contentType, equals(EmailContentType.markdown));
    });

    /// 测试检测 Markdown 内容 - 链接
    test('检测 Markdown 内容 - 链接', () async {
      // 链接加粗体，确保分数达到阈值
      const content = '这是一个[链接](https://example.com)示例，包含**粗体**文本。';

      await container
          .read(contentRendererProvider.notifier)
          .setContent(content);

      final state = container.read(contentRendererProvider);
      expect(state.contentType, equals(EmailContentType.markdown));
    });

    /// 测试检测 Markdown 内容 - 强调
    test('检测 Markdown 内容 - 强调', () async {
      const content = '这是**粗体**和*斜体*文本。';

      await container
          .read(contentRendererProvider.notifier)
          .setContent(content);

      final state = container.read(contentRendererProvider);
      expect(state.contentType, equals(EmailContentType.markdown));
    });

    /// 测试检测纯文本内容
    test('检测纯文本内容', () async {
      const content = '这是一段普通文本，没有任何特殊格式。';

      await container
          .read(contentRendererProvider.notifier)
          .setContent(content);

      final state = container.read(contentRendererProvider);
      expect(state.contentType, equals(EmailContentType.plainText));
    });

    /// 测试 HTML 优先级高于 Markdown
    test('HTML 优先级高于 Markdown', () async {
      // 包含 HTML 标签和 Markdown 标记的内容
      const content = '''
<div>
# 标题
- 列表项
</div>
''';

      await container
          .read(contentRendererProvider.notifier)
          .setContent(content);

      final state = container.read(contentRendererProvider);
      // HTML 应该被优先识别
      expect(state.contentType, equals(EmailContentType.html));
    });
  });

  group('ContentRenderer Provider 手动设置类型测试', () {
    /// 测试手动设置内容类型
    test('手动设置内容类型', () async {
      // 先设置内容
      await container.read(contentRendererProvider.notifier).setContent('普通文本');

      // 手动设置类型
      container
          .read(contentRendererProvider.notifier)
          .setContentType(EmailContentType.html);

      // 验证状态
      final state = container.read(contentRendererProvider);
      expect(state.contentType, equals(EmailContentType.html));
    });
  });

  group('ContentRenderer Provider 状态管理测试', () {
    /// 测试状态不可变性
    test('状态不可变性', () {
      // 获取初始状态
      final state1 = container.read(contentRendererProvider);

      // 再次获取状态
      final state2 = container.read(contentRendererProvider);

      // 验证是同一个实例（因为是 const）
      expect(state1, equals(state2));
    });

    /// 测试状态更新
    test('状态更新', () async {
      // 获取初始状态
      final initialState = container.read(contentRendererProvider);
      expect(initialState.renderStatus, equals(RenderStatus.initial));

      // 设置内容
      await container.read(contentRendererProvider.notifier).setContent('测试');

      // 获取更新后的状态
      final updatedState = container.read(contentRendererProvider);
      expect(updatedState.renderStatus, equals(RenderStatus.success));
      expect(updatedState.content, equals('测试'));
    });
  });

  group('ContentRenderer Provider 边界情况测试', () {
    /// 测试只有空白字符的内容
    test('处理只有空白字符的内容', () async {
      const content = '   \n\t\n   ';

      await container
          .read(contentRendererProvider.notifier)
          .setContent(content);

      final state = container.read(contentRendererProvider);
      // 只有空白字符的内容会被识别为 unknown
      expect(state.contentType, equals(EmailContentType.unknown));
    });

    /// 测试大量内容
    test('处理大量内容', () async {
      // 生成大量 Markdown 内容
      final content = List.generate(
        1000,
        (index) => '# 标题 $index\n\n段落 $index',
      ).join('\n\n');

      await container
          .read(contentRendererProvider.notifier)
          .setContent(content);

      final state = container.read(contentRendererProvider);
      expect(state.contentType, equals(EmailContentType.markdown));
      expect(state.renderStatus, equals(RenderStatus.success));
    });

    /// 测试混合格式内容
    test('处理混合格式内容', () async {
      // 包含 HTML 和 Markdown 特征的内容
      const content = '''
<div>
# Markdown 标题
<p>HTML 段落</p>
- Markdown 列表
</div>
''';

      await container
          .read(contentRendererProvider.notifier)
          .setContent(content);

      final state = container.read(contentRendererProvider);
      // HTML 应该被优先识别
      expect(state.contentType, equals(EmailContentType.html));
    });

    /// 测试特殊字符
    test('处理特殊字符', () async {
      const content = '''
特殊字符测试：
- Emoji: 😀 🎉
- 符号: @ # \$ %
- Unicode: 中文 日本語
''';

      await container
          .read(contentRendererProvider.notifier)
          .setContent(content);

      final state = container.read(contentRendererProvider);
      expect(state.contentType, equals(EmailContentType.markdown));
      expect(state.renderStatus, equals(RenderStatus.success));
    });
  });
}
