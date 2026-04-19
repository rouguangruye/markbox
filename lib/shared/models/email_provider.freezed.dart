// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EmailProvider _$EmailProviderFromJson(Map<String, dynamic> json) {
  return _EmailProvider.fromJson(json);
}

/// @nodoc
mixin _$EmailProvider {
  /// 服务商名称（唯一标识）
  String get name => throw _privateConstructorUsedError;

  /// 显示名称（用于 UI 展示）
  String get displayName => throw _privateConstructorUsedError;

  /// 图标路径（资源路径或网络 URL）
  String get icon => throw _privateConstructorUsedError;

  /// IMAP 服务器地址
  String get imapServer => throw _privateConstructorUsedError;

  /// IMAP 端口号
  int get imapPort => throw _privateConstructorUsedError;

  /// 是否使用 SSL 加密
  bool get useSSL => throw _privateConstructorUsedError;

  /// 邮箱域名后缀（可选，用于自动识别邮箱服务商）
  String? get domain => throw _privateConstructorUsedError;

  /// Serializes this EmailProvider to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailProvider
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailProviderCopyWith<EmailProvider> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailProviderCopyWith<$Res> {
  factory $EmailProviderCopyWith(
    EmailProvider value,
    $Res Function(EmailProvider) then,
  ) = _$EmailProviderCopyWithImpl<$Res, EmailProvider>;
  @useResult
  $Res call({
    String name,
    String displayName,
    String icon,
    String imapServer,
    int imapPort,
    bool useSSL,
    String? domain,
  });
}

/// @nodoc
class _$EmailProviderCopyWithImpl<$Res, $Val extends EmailProvider>
    implements $EmailProviderCopyWith<$Res> {
  _$EmailProviderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailProvider
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayName = null,
    Object? icon = null,
    Object? imapServer = null,
    Object? imapPort = null,
    Object? useSSL = null,
    Object? domain = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String,
            imapServer: null == imapServer
                ? _value.imapServer
                : imapServer // ignore: cast_nullable_to_non_nullable
                      as String,
            imapPort: null == imapPort
                ? _value.imapPort
                : imapPort // ignore: cast_nullable_to_non_nullable
                      as int,
            useSSL: null == useSSL
                ? _value.useSSL
                : useSSL // ignore: cast_nullable_to_non_nullable
                      as bool,
            domain: freezed == domain
                ? _value.domain
                : domain // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EmailProviderImplCopyWith<$Res>
    implements $EmailProviderCopyWith<$Res> {
  factory _$$EmailProviderImplCopyWith(
    _$EmailProviderImpl value,
    $Res Function(_$EmailProviderImpl) then,
  ) = __$$EmailProviderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String displayName,
    String icon,
    String imapServer,
    int imapPort,
    bool useSSL,
    String? domain,
  });
}

/// @nodoc
class __$$EmailProviderImplCopyWithImpl<$Res>
    extends _$EmailProviderCopyWithImpl<$Res, _$EmailProviderImpl>
    implements _$$EmailProviderImplCopyWith<$Res> {
  __$$EmailProviderImplCopyWithImpl(
    _$EmailProviderImpl _value,
    $Res Function(_$EmailProviderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmailProvider
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayName = null,
    Object? icon = null,
    Object? imapServer = null,
    Object? imapPort = null,
    Object? useSSL = null,
    Object? domain = freezed,
  }) {
    return _then(
      _$EmailProviderImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String,
        imapServer: null == imapServer
            ? _value.imapServer
            : imapServer // ignore: cast_nullable_to_non_nullable
                  as String,
        imapPort: null == imapPort
            ? _value.imapPort
            : imapPort // ignore: cast_nullable_to_non_nullable
                  as int,
        useSSL: null == useSSL
            ? _value.useSSL
            : useSSL // ignore: cast_nullable_to_non_nullable
                  as bool,
        domain: freezed == domain
            ? _value.domain
            : domain // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailProviderImpl implements _EmailProvider {
  const _$EmailProviderImpl({
    required this.name,
    required this.displayName,
    required this.icon,
    required this.imapServer,
    required this.imapPort,
    required this.useSSL,
    this.domain,
  });

  factory _$EmailProviderImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailProviderImplFromJson(json);

  /// 服务商名称（唯一标识）
  @override
  final String name;

  /// 显示名称（用于 UI 展示）
  @override
  final String displayName;

  /// 图标路径（资源路径或网络 URL）
  @override
  final String icon;

  /// IMAP 服务器地址
  @override
  final String imapServer;

  /// IMAP 端口号
  @override
  final int imapPort;

  /// 是否使用 SSL 加密
  @override
  final bool useSSL;

  /// 邮箱域名后缀（可选，用于自动识别邮箱服务商）
  @override
  final String? domain;

  @override
  String toString() {
    return 'EmailProvider(name: $name, displayName: $displayName, icon: $icon, imapServer: $imapServer, imapPort: $imapPort, useSSL: $useSSL, domain: $domain)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailProviderImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.imapServer, imapServer) ||
                other.imapServer == imapServer) &&
            (identical(other.imapPort, imapPort) ||
                other.imapPort == imapPort) &&
            (identical(other.useSSL, useSSL) || other.useSSL == useSSL) &&
            (identical(other.domain, domain) || other.domain == domain));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    displayName,
    icon,
    imapServer,
    imapPort,
    useSSL,
    domain,
  );

  /// Create a copy of EmailProvider
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailProviderImplCopyWith<_$EmailProviderImpl> get copyWith =>
      __$$EmailProviderImplCopyWithImpl<_$EmailProviderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailProviderImplToJson(this);
  }
}

abstract class _EmailProvider implements EmailProvider {
  const factory _EmailProvider({
    required final String name,
    required final String displayName,
    required final String icon,
    required final String imapServer,
    required final int imapPort,
    required final bool useSSL,
    final String? domain,
  }) = _$EmailProviderImpl;

  factory _EmailProvider.fromJson(Map<String, dynamic> json) =
      _$EmailProviderImpl.fromJson;

  /// 服务商名称（唯一标识）
  @override
  String get name;

  /// 显示名称（用于 UI 展示）
  @override
  String get displayName;

  /// 图标路径（资源路径或网络 URL）
  @override
  String get icon;

  /// IMAP 服务器地址
  @override
  String get imapServer;

  /// IMAP 端口号
  @override
  int get imapPort;

  /// 是否使用 SSL 加密
  @override
  bool get useSSL;

  /// 邮箱域名后缀（可选，用于自动识别邮箱服务商）
  @override
  String? get domain;

  /// Create a copy of EmailProvider
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailProviderImplCopyWith<_$EmailProviderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
