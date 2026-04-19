import 'dart:io';
import 'package:enough_mail/enough_mail.dart';

void main() async {
  final testDir = Directory(
    '/Users/xufeng/develop/projects/MarkBox/test/resources',
  );

  for (final file in testDir.listSync()) {
    if (file is File && file.path.endsWith('.eml')) {
      print('\n${'=' * 60}');
      print('文件: ${file.path.split('/').last}');
      print('=' * 60);

      final content = await file.readAsString();
      final message = MimeMessage.parseFromText(content);

      // 测试 enough_mail 的解码方法
      print('Media Type: ${message.mediaType}');
      print('Has parts: ${message.parts != null && message.parts!.isNotEmpty}');

      final htmlPart = message.decodeTextHtmlPart();
      final textPart = message.decodeTextPlainPart();

      print(
        '\ndecodeTextHtmlPart(): ${htmlPart != null ? "${htmlPart.length} 字符" : "null"}',
      );
      print(
        'decodeTextPlainPart(): ${textPart != null ? "${textPart.length} 字符" : "null"}',
      );

      if (htmlPart != null) {
        print('\n--- HTML 内容前 500 字符 ---');
        print(
          htmlPart.substring(0, htmlPart.length > 500 ? 500 : htmlPart.length),
        );
      }

      if (textPart != null && htmlPart == null) {
        print('\n--- 纯文本内容前 500 字符 ---');
        print(
          textPart.substring(0, textPart.length > 500 ? 500 : textPart.length),
        );
      }

      // 遍历 parts
      if (message.parts != null) {
        print('\n--- Parts 详情 ---');
        for (var i = 0; i < message.parts!.length; i++) {
          final part = message.parts![i];
          print('Part $i: ${part.mediaType}');
          final decoded = part.decodeContentText();
          print('  解码后长度: ${decoded?.length ?? 0}');
        }
      }
    }
  }
}
