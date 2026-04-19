// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParsedContentImpl _$$ParsedContentImplFromJson(Map<String, dynamic> json) =>
    _$ParsedContentImpl(
      type: $enumDecode(_$EmailContentTypeEnumMap, json['type']),
      content: json['content'] as String,
      charset: json['charset'] as String?,
      encoding: json['encoding'] as String?,
    );

Map<String, dynamic> _$$ParsedContentImplToJson(_$ParsedContentImpl instance) =>
    <String, dynamic>{
      'type': _$EmailContentTypeEnumMap[instance.type]!,
      'content': instance.content,
      'charset': instance.charset,
      'encoding': instance.encoding,
    };

const _$EmailContentTypeEnumMap = {
  EmailContentType.markdown: 'markdown',
  EmailContentType.html: 'html',
  EmailContentType.plainText: 'plainText',
  EmailContentType.unknown: 'unknown',
};
