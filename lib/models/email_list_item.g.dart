// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmailListItemImpl _$$EmailListItemImplFromJson(Map<String, dynamic> json) =>
    _$EmailListItemImpl(
      uid: json['uid'] as String,
      senderName: json['senderName'] as String,
      senderEmail: json['senderEmail'] as String,
      subject: json['subject'] as String,
      receivedDate: DateTime.parse(json['receivedDate'] as String),
      isRead: json['isRead'] as bool? ?? false,
    );

Map<String, dynamic> _$$EmailListItemImplToJson(_$EmailListItemImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'senderName': instance.senderName,
      'senderEmail': instance.senderEmail,
      'subject': instance.subject,
      'receivedDate': instance.receivedDate.toIso8601String(),
      'isRead': instance.isRead,
    };
