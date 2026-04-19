// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_detail_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmailDetailStateImpl _$$EmailDetailStateImplFromJson(
  Map<String, dynamic> json,
) => _$EmailDetailStateImpl(
  isLoading: json['isLoading'] as bool? ?? false,
  email: json['email'] == null
      ? null
      : Email.fromJson(json['email'] as Map<String, dynamic>),
  error: json['error'] as String?,
);

Map<String, dynamic> _$$EmailDetailStateImplToJson(
  _$EmailDetailStateImpl instance,
) => <String, dynamic>{
  'isLoading': instance.isLoading,
  'email': instance.email,
  'error': instance.error,
};
