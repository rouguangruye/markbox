// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imap_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImapConfigImpl _$$ImapConfigImplFromJson(Map<String, dynamic> json) =>
    _$ImapConfigImpl(
      id: json['id'] as String,
      server: json['server'] as String,
      port: (json['port'] as num).toInt(),
      email: json['email'] as String,
      password: json['password'] as String,
      useSSL: json['useSSL'] as bool,
      displayName: json['displayName'] as String?,
      createdAt: (json['createdAt'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ImapConfigImplToJson(_$ImapConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'server': instance.server,
      'port': instance.port,
      'email': instance.email,
      'password': instance.password,
      'useSSL': instance.useSSL,
      'displayName': instance.displayName,
      'createdAt': instance.createdAt,
    };
