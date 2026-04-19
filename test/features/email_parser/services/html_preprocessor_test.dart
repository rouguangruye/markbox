import 'package:flutter_test/flutter_test.dart';
import 'package:markbox/features/email_parser/services/html_preprocessor.dart';

void main() {
  late HtmlPreprocessor preprocessor;

  setUp(() {
    preprocessor = HtmlPreprocessor();
  });

  group('HtmlPreprocessor', () {
    group('移除 script 标签', () {
      test('移除 script 标签及其内容', () {
        const html = '<div><script>alert("xss")</script><p>Hello</p></div>';
        final result = preprocessor.preprocess(html);
        expect(result, isNot(contains('script')));
        expect(result, isNot(contains('alert')));
        expect(result, contains('Hello'));
      });

      test('移除带属性的 script 标签', () {
        const html =
            '<div><script type="text/javascript">function foo() {}</script><p>Content</p></div>';
        final result = preprocessor.preprocess(html);
        expect(result, isNot(contains('script')));
        expect(result, isNot(contains('function foo')));
        expect(result, contains('Content'));
      });

      test('移除招商银行邮件中的 JavaScript', () {
        const html =
            '<html><head><SCRIPT type="text/javascript">function selectPage(idx) { var page = document.getElementById("p1"); }</SCRIPT></head><body><p>账单</p></body></html>';
        final result = preprocessor.preprocess(html);
        expect(result, isNot(contains('selectPage')));
        expect(result, isNot(contains('SCRIPT')));
        expect(result, contains('账单'));
      });
    });

    group('移除 Outlook 条件注释', () {
      test('移除简单的条件注释', () {
        const html =
            '<div><!--[if mso]><table><tr><td><![endif]--><p>Content</p><!--[if mso]></td></tr></table><![endif]--></div>';
        final result = preprocessor.preprocess(html);
        expect(result, isNot(contains('[if mso]')));
        expect(result, contains('Content'));
      });

      test('移除 n8n 邮件中的条件注释', () {
        const html =
            '<!--[if true]><table role="none"><tr><td><![endif]--><div>Content</div><!--[if true]></td></tr></table><![endif]-->';
        final result = preprocessor.preprocess(html);
        expect(result, isNot(contains('[if true]')));
        expect(result, contains('Content'));
      });
    });

    group('移除跟踪像素', () {
      test('移除 1x1 像素的 img 标签', () {
        const html =
            '<div><img src="https://track.example.com/pixel.gif" width="1" height="1"/><p>Content</p></div>';
        final result = preprocessor.preprocess(html);
        expect(result, isNot(contains('pixel.gif')));
        expect(result, contains('Content'));
      });

      test('保留正常尺寸的图片', () {
        const html =
            '<div><img src="https://example.com/logo.png" width="100" height="50"/><p>Content</p></div>';
        final result = preprocessor.preprocess(html);
        expect(result, contains('logo.png'));
        expect(result, contains('Content'));
      });

      test('移除 style 中 display:none 的 1px 图片', () {
        const html =
            '<img src="https://track.com/pixel" width="1" style="display:none !important; max-height: 1px"/>';
        final result = preprocessor.preprocess(html);
        expect(result, isNot(contains('track.com')));
      });
    });

    group('安全过滤 - 移除事件属性', () {
      test('移除 onclick 属性', () {
        const html = '<div onclick="alert(1)">Content</div>';
        final result = preprocessor.preprocess(html);
        expect(result, isNot(contains('onclick')));
        expect(result, contains('Content'));
      });

      test('移除 onerror 属性', () {
        const html = '<img src="x" onerror="alert(1)"/>';
        final result = preprocessor.preprocess(html);
        expect(result, isNot(contains('onerror')));
      });

      test('保留非事件属性', () {
        const html = '<a href="https://example.com" class="link">Link</a>';
        final result = preprocessor.preprocess(html);
        expect(result, contains('href'));
        expect(result, contains('class'));
        expect(result, contains('Link'));
      });
    });

    group('<style> 块完整保留', () {
      test('<style> 块不被修改或内联化', () {
        const html =
            '<style>.header { color: red; background: linear-gradient(135deg, #667eea, #764ba2); }</style><div class="header">Title</div>';
        final result = preprocessor.preprocess(html);
        expect(result, contains('<style>'));
        expect(result, contains('linear-gradient'));
        expect(
          result,
          contains('.header { color: red; background: linear-gradient'),
        );
        expect(result, contains('Title'));
      });

      test('保留 AI 科技简报的完整 style 块和结构', () {
        const html = '''
<html>
<head>
<style>
  body { font-family: sans-serif; line-height: 1.6; }
  .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 10px; }
  .article { background: white; border-radius: 10px; padding: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
</style>
</head>
<body>
<div class="header"><h1>AI科技简报</h1></div>
<div class="card"><p>内容</p></div>
</body>
</html>''';
        final result = preprocessor.preprocess(html);

        // 完整结构保留
        expect(result, contains('<html>'));
        expect(result, contains('<head>'));
        expect(result, contains('<style>'));
        expect(result, contains('</style>'));
        expect(result, contains('<body>'));

        // CSS 完整保留（不内联化）
        expect(
          result,
          contains('background: linear-gradient(135deg, #667eea 0%'),
        );
        expect(result, contains('border-radius: 10px'));
        expect(result, contains('box-shadow: 0 2px 4px rgba'));

        // 内容保留
        expect(result, contains('AI科技简报'));
        expect(result, contains('内容'));
      });
    });

    group('空输入处理', () {
      test('空字符串返回空字符串', () {
        final result = preprocessor.preprocess('');
        expect(result, isEmpty);
      });

      test('纯文本内容不变', () {
        const text = 'Hello World';
        final result = preprocessor.preprocess(text);
        expect(result, contains('Hello World'));
      });
    });

    group('综合测试', () {
      test('处理包含多种问题的邮件 HTML，保留完整样式结构', () {
        const html = '''
<html>
<head>
  <style>.content { color: #333; font-size: 14px; background: linear-gradient(to bottom, #fff, #f5f5f5); }</style>
  <script>function track() {}</script>
</head>
<body>
  <!--[if true]><table role="none"><tr><td><![endif]-->
  <div class="content" onclick="track()">
    <p>Hello</p>
    <img src="https://track.com/pixel" width="1" height="1"/>
    <img src="https://example.com/logo.png" width="200" height="100"/>
  </div>
  <!--[if true]></td></tr></table><![endif]-->
</body>
</html>
''';
        final result = preprocessor.preprocess(html);

        // script 被移除
        expect(result, isNot(contains('script')));
        expect(result, isNot(contains('function track')));

        // 条件注释被移除
        expect(result, isNot(contains('[if true]')));

        // 跟踪像素被移除
        expect(result, isNot(contains('track.com/pixel')));

        // 事件属性被移除
        expect(result, isNot(contains('onclick')));

        // <style> 块完整保留
        expect(result, contains('<style>'));
        expect(result, contains('linear-gradient'));

        // 正常图片保留
        expect(result, contains('logo.png'));

        // 内容保留
        expect(result, contains('Hello'));
      });
    });
  });
}
