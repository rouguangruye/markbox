import 'package:freezed_annotation/freezed_annotation.dart';

import 'summary_status.dart';
import 'package:markbox/features/email_parser/models/email_content_type.dart';

part 'email.freezed.dart';
part 'email.g.dart';

/// 邮件数据模型
///
/// 用于存储邮件的基本信息
@freezed
class Email with _$Email {
  const factory Email({
    /// 邮件唯一标识符
    required String id,

    /// 发件人名称（可能为空）
    String? senderName,

    /// 发件人邮箱地址
    required String senderEmail,

    /// 邮件主题
    required String subject,

    /// 邮件日期时间
    required DateTime date,

    /// 列表预览文本（简短的纯文本，最多 100 字符）
    String? preview,

    /// 邮件完整内容（HTML 或纯文本）
    String? body,

    /// 邮件内容类型
    @Default(EmailContentType.unknown) EmailContentType contentType,

    /// 是否已读
    @Default(false) bool isRead,

    /// AI 生成的摘要（可选）
    String? summary,

    /// 摘要生成状态
    @Default(SummaryStatus.notGenerated) SummaryStatus summaryStatus,

    /// 原始 MIME 消息内容（用于 MimeMessageViewer 渲染）
    String? mimeMessageRaw,
  }) = _Email;

  factory Email.fromJson(Map<String, dynamic> json) => _$EmailFromJson(json);
}
