import 'package:freezed_annotation/freezed_annotation.dart';

import 'email_content_type.dart';

part 'parsed_content.freezed.dart';
part 'parsed_content.g.dart';

/// 解析后的邮件内容模型
///
/// 封装邮件解析后的内容数据，包括内容类型、原始内容、字符集和编码信息
@freezed
class ParsedContent with _$ParsedContent {
  const factory ParsedContent({
    /// 内容类型
    required EmailContentType type,

    /// 解析后的内容
    required String content,

    /// 字符集编码（如 UTF-8, GBK 等）
    String? charset,

    /// 传输编码（如 base64, quoted-printable 等）
    String? encoding,
  }) = _ParsedContent;

  factory ParsedContent.fromJson(Map<String, dynamic> json) =>
      _$ParsedContentFromJson(json);
}
