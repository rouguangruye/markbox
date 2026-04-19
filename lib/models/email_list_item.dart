import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_list_item.freezed.dart';
part 'email_list_item.g.dart';

/// 邮件列表项模型
///
/// 用于表示邮件列表中的单封邮件基本信息
@freezed
class EmailListItem with _$EmailListItem {
  const factory EmailListItem({
    /// 邮件唯一标识
    required String uid,

    /// 发件人显示名
    required String senderName,

    /// 发件人邮箱地址
    required String senderEmail,

    /// 邮件主题
    required String subject,

    /// 接收时间
    required DateTime receivedDate,

    /// 是否已读
    @Default(false) bool isRead,
  }) = _EmailListItem;

  factory EmailListItem.fromJson(Map<String, dynamic> json) =>
      _$EmailListItemFromJson(json);
}
