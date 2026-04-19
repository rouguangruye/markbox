import 'dart:io';
import 'package:enough_mail/enough_mail.dart';
import 'package:markbox/features/email_parser/services/mime_parser.dart';

void main() async {
  final content = await File(
    '/Users/xufeng/develop/projects/MarkBox/test/resources/skills-cli_使用教程.eml',
  ).readAsString();
  final message = MimeMessage.parseFromText(content);

  print('=== 使用 MimeParser 解析 ===');
  final parser = MimeParser();
  final result = parser.parseMessage(message);

  print('Is Success: ${result.success}');
  print('Error: ${result.errorMessage}');
  if (result.content != null) {
    print('Content Type: ${result.content!.type}');
    print('Content Length: ${result.content!.content.length}');
    print(
      'First 200 chars: ${result.content!.content.substring(0, result.content!.content.length > 200 ? 200 : result.content!.content.length)}',
    );
  }
}
