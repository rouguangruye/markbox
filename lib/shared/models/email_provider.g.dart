// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmailProviderImpl _$$EmailProviderImplFromJson(Map<String, dynamic> json) =>
    _$EmailProviderImpl(
      name: json['name'] as String,
      displayName: json['displayName'] as String,
      icon: json['icon'] as String,
      imapServer: json['imapServer'] as String,
      imapPort: (json['imapPort'] as num).toInt(),
      useSSL: json['useSSL'] as bool,
      domain: json['domain'] as String?,
    );

Map<String, dynamic> _$$EmailProviderImplToJson(_$EmailProviderImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayName': instance.displayName,
      'icon': instance.icon,
      'imapServer': instance.imapServer,
      'imapPort': instance.imapPort,
      'useSSL': instance.useSSL,
      'domain': instance.domain,
    };
