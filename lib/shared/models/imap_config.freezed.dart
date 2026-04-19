// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'imap_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ImapConfig _$ImapConfigFromJson(Map<String, dynamic> json) {
  return _ImapConfig.fromJson(json);
}

/// @nodoc
mixin _$ImapConfig {
  /// 唯一标识符
  String get id => throw _privateConstructorUsedError;

  /// IMAP 服务器地址
  String get server => throw _privateConstructorUsedError;

  /// IMAP 端口号
  int get port => throw _privateConstructorUsedError;

  /// 邮箱账号
  String get email => throw _privateConstructorUsedError;

  /// 授权码（非明文密码）
  String get password => throw _privateConstructorUsedError;

  /// 是否使用 SSL 加密
  bool get useSSL => throw _privateConstructorUsedError;

  /// 显示名称（可选）
  String? get displayName => throw _privateConstructorUsedError;

  /// 创建时间（毫秒时间戳）
  int get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ImapConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImapConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImapConfigCopyWith<ImapConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImapConfigCopyWith<$Res> {
  factory $ImapConfigCopyWith(
    ImapConfig value,
    $Res Function(ImapConfig) then,
  ) = _$ImapConfigCopyWithImpl<$Res, ImapConfig>;
  @useResult
  $Res call({
    String id,
    String server,
    int port,
    String email,
    String password,
    bool useSSL,
    String? displayName,
    int createdAt,
  });
}

/// @nodoc
class _$ImapConfigCopyWithImpl<$Res, $Val extends ImapConfig>
    implements $ImapConfigCopyWith<$Res> {
  _$ImapConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImapConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? server = null,
    Object? port = null,
    Object? email = null,
    Object? password = null,
    Object? useSSL = null,
    Object? displayName = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            server: null == server
                ? _value.server
                : server // ignore: cast_nullable_to_non_nullable
                      as String,
            port: null == port
                ? _value.port
                : port // ignore: cast_nullable_to_non_nullable
                      as int,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
            useSSL: null == useSSL
                ? _value.useSSL
                : useSSL // ignore: cast_nullable_to_non_nullable
                      as bool,
            displayName: freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ImapConfigImplCopyWith<$Res>
    implements $ImapConfigCopyWith<$Res> {
  factory _$$ImapConfigImplCopyWith(
    _$ImapConfigImpl value,
    $Res Function(_$ImapConfigImpl) then,
  ) = __$$ImapConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String server,
    int port,
    String email,
    String password,
    bool useSSL,
    String? displayName,
    int createdAt,
  });
}

/// @nodoc
class __$$ImapConfigImplCopyWithImpl<$Res>
    extends _$ImapConfigCopyWithImpl<$Res, _$ImapConfigImpl>
    implements _$$ImapConfigImplCopyWith<$Res> {
  __$$ImapConfigImplCopyWithImpl(
    _$ImapConfigImpl _value,
    $Res Function(_$ImapConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ImapConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? server = null,
    Object? port = null,
    Object? email = null,
    Object? password = null,
    Object? useSSL = null,
    Object? displayName = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$ImapConfigImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        server: null == server
            ? _value.server
            : server // ignore: cast_nullable_to_non_nullable
                  as String,
        port: null == port
            ? _value.port
            : port // ignore: cast_nullable_to_non_nullable
                  as int,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
        useSSL: null == useSSL
            ? _value.useSSL
            : useSSL // ignore: cast_nullable_to_non_nullable
                  as bool,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ImapConfigImpl implements _ImapConfig {
  const _$ImapConfigImpl({
    required this.id,
    required this.server,
    required this.port,
    required this.email,
    required this.password,
    required this.useSSL,
    this.displayName,
    this.createdAt = 0,
  });

  factory _$ImapConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImapConfigImplFromJson(json);

  /// 唯一标识符
  @override
  final String id;

  /// IMAP 服务器地址
  @override
  final String server;

  /// IMAP 端口号
  @override
  final int port;

  /// 邮箱账号
  @override
  final String email;

  /// 授权码（非明文密码）
  @override
  final String password;

  /// 是否使用 SSL 加密
  @override
  final bool useSSL;

  /// 显示名称（可选）
  @override
  final String? displayName;

  /// 创建时间（毫秒时间戳）
  @override
  @JsonKey()
  final int createdAt;

  @override
  String toString() {
    return 'ImapConfig(id: $id, server: $server, port: $port, email: $email, password: $password, useSSL: $useSSL, displayName: $displayName, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImapConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.server, server) || other.server == server) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.useSSL, useSSL) || other.useSSL == useSSL) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    server,
    port,
    email,
    password,
    useSSL,
    displayName,
    createdAt,
  );

  /// Create a copy of ImapConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImapConfigImplCopyWith<_$ImapConfigImpl> get copyWith =>
      __$$ImapConfigImplCopyWithImpl<_$ImapConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImapConfigImplToJson(this);
  }
}

abstract class _ImapConfig implements ImapConfig {
  const factory _ImapConfig({
    required final String id,
    required final String server,
    required final int port,
    required final String email,
    required final String password,
    required final bool useSSL,
    final String? displayName,
    final int createdAt,
  }) = _$ImapConfigImpl;

  factory _ImapConfig.fromJson(Map<String, dynamic> json) =
      _$ImapConfigImpl.fromJson;

  /// 唯一标识符
  @override
  String get id;

  /// IMAP 服务器地址
  @override
  String get server;

  /// IMAP 端口号
  @override
  int get port;

  /// 邮箱账号
  @override
  String get email;

  /// 授权码（非明文密码）
  @override
  String get password;

  /// 是否使用 SSL 加密
  @override
  bool get useSSL;

  /// 显示名称（可选）
  @override
  String? get displayName;

  /// 创建时间（毫秒时间戳）
  @override
  int get createdAt;

  /// Create a copy of ImapConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImapConfigImplCopyWith<_$ImapConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
