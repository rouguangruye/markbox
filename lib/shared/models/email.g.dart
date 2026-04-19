// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmailImpl _$$EmailImplFromJson(Map<String, dynamic> json) => _$EmailImpl(
  id: json['id'] as String,
  senderName: json['senderName'] as String?,
  senderEmail: json['senderEmail'] as String,
  subject: json['subject'] as String,
  date: DateTime.parse(json['date'] as String),
  preview: json['preview'] as String?,
  body: json['body'] as String?,
  contentType:
      $enumDecodeNullable(_$EmailContentTypeEnumMap, json['contentType']) ??
      EmailContentType.unknown,
  isRead: json['isRead'] as bool? ?? false,
  summary: json['summary'] as String?,
  summaryStatus:
      $enumDecodeNullable(_$SummaryStatusEnumMap, json['summaryStatus']) ??
      SummaryStatus.notGenerated,
  mimeMessageRaw: json['mimeMessageRaw'] as String?,
  cachedAt: (json['cachedAt'] as num?)?.toInt(),
);

Map<String, dynamic> _$$EmailImplToJson(_$EmailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderName': instance.senderName,
      'senderEmail': instance.senderEmail,
      'subject': instance.subject,
      'date': instance.date.toIso8601String(),
      'preview': instance.preview,
      'body': instance.body,
      'contentType': _$EmailContentTypeEnumMap[instance.contentType]!,
      'isRead': instance.isRead,
      'summary': instance.summary,
      'summaryStatus': _$SummaryStatusEnumMap[instance.summaryStatus]!,
      'mimeMessageRaw': instance.mimeMessageRaw,
      'cachedAt': instance.cachedAt,
    };

const _$EmailContentTypeEnumMap = {
  EmailContentType.markdown: 'markdown',
  EmailContentType.html: 'html',
  EmailContentType.plainText: 'plainText',
  EmailContentType.unknown: 'unknown',
};

const _$SummaryStatusEnumMap = {
  SummaryStatus.notGenerated: 'notGenerated',
  SummaryStatus.generating: 'generating',
  SummaryStatus.generated: 'generated',
  SummaryStatus.failed: 'failed',
};
