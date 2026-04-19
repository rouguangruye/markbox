import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markbox/features/content_rendering/widgets/renderers/html_renderer.dart';
import 'package:markbox/features/content_rendering/widgets/renderers/webview_html_renderer.dart';

void main() {
  group('HtmlRenderer 统一 WebView 测试', () {
    testWidgets('HTML 内容统一使用 WebView 渲染', (WidgetTester tester) async {
      const html = '<p>测试内容</p>';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: HtmlRenderer(htmlContent: html)),
        ),
      );

      // HtmlRenderer 应始终返回 WebViewHtmlRenderer
      expect(find.byType(WebViewHtmlRenderer), findsOneWidget);
    });

    testWidgets('大型 HTML 内容也使用 WebView', (WidgetTester tester) async {
      var bigHtml = '';
      for (var i = 0; i < 2000; i++) {
        bigHtml += '<div>内容 $i</div>';
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: HtmlRenderer(htmlContent: bigHtml)),
        ),
      );

      expect(find.byType(WebViewHtmlRenderer), findsOneWidget);
    });

    testWidgets('支持 backgroundColor 参数', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HtmlRenderer(
              htmlContent: '<p>Test</p>',
              backgroundColor: Color(0xFF2D2D2D),
            ),
          ),
        ),
      );

      expect(find.byType(HtmlRenderer), findsOneWidget);
      expect(find.byType(WebViewHtmlRenderer), findsOneWidget);
    });
  });
}
