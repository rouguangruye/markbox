// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parsed_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ParsedContent _$ParsedContentFromJson(Map<String, dynamic> json) {
  return _ParsedContent.fromJson(json);
}

/// @nodoc
mixin _$ParsedContent {
  /// 内容类型
  EmailContentType get type => throw _privateConstructorUsedError;

  /// 解析后的内容
  String get content => throw _privateConstructorUsedError;

  /// 字符集编码（如 UTF-8, GBK 等）
  String? get charset => throw _privateConstructorUsedError;

  /// 传输编码（如 base64, quoted-printable 等）
  String? get encoding => throw _privateConstructorUsedError;

  /// Serializes this ParsedContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParsedContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParsedContentCopyWith<ParsedContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedContentCopyWith<$Res> {
  factory $ParsedContentCopyWith(
    ParsedContent value,
    $Res Function(ParsedContent) then,
  ) = _$ParsedContentCopyWithImpl<$Res, ParsedContent>;
  @useResult
  $Res call({
    EmailContentType type,
    String content,
    String? charset,
    String? encoding,
  });
}

/// @nodoc
class _$ParsedContentCopyWithImpl<$Res, $Val extends ParsedContent>
    implements $ParsedContentCopyWith<$Res> {
  _$ParsedContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParsedContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? content = null,
    Object? charset = freezed,
    Object? encoding = freezed,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as EmailContentType,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            charset: freezed == charset
                ? _value.charset
                : charset // ignore: cast_nullable_to_non_nullable
                      as String?,
            encoding: freezed == encoding
                ? _value.encoding
                : encoding // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ParsedContentImplCopyWith<$Res>
    implements $ParsedContentCopyWith<$Res> {
  factory _$$ParsedContentImplCopyWith(
    _$ParsedContentImpl value,
    $Res Function(_$ParsedContentImpl) then,
  ) = __$$ParsedContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    EmailContentType type,
    String content,
    String? charset,
    String? encoding,
  });
}

/// @nodoc
class __$$ParsedContentImplCopyWithImpl<$Res>
    extends _$ParsedContentCopyWithImpl<$Res, _$ParsedContentImpl>
    implements _$$ParsedContentImplCopyWith<$Res> {
  __$$ParsedContentImplCopyWithImpl(
    _$ParsedContentImpl _value,
    $Res Function(_$ParsedContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ParsedContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? content = null,
    Object? charset = freezed,
    Object? encoding = freezed,
  }) {
    return _then(
      _$ParsedContentImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as EmailContentType,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        charset: freezed == charset
            ? _value.charset
            : charset // ignore: cast_nullable_to_non_nullable
                  as String?,
        encoding: freezed == encoding
            ? _value.encoding
            : encoding // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedContentImpl implements _ParsedContent {
  const _$ParsedContentImpl({
    required this.type,
    required this.content,
    this.charset,
    this.encoding,
  });

  factory _$ParsedContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParsedContentImplFromJson(json);

  /// 内容类型
  @override
  final EmailContentType type;

  /// 解析后的内容
  @override
  final String content;

  /// 字符集编码（如 UTF-8, GBK 等）
  @override
  final String? charset;

  /// 传输编码（如 base64, quoted-printable 等）
  @override
  final String? encoding;

  @override
  String toString() {
    return 'ParsedContent(type: $type, content: $content, charset: $charset, encoding: $encoding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParsedContentImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.charset, charset) || other.charset == charset) &&
            (identical(other.encoding, encoding) ||
                other.encoding == encoding));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, content, charset, encoding);

  /// Create a copy of ParsedContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParsedContentImplCopyWith<_$ParsedContentImpl> get copyWith =>
      __$$ParsedContentImplCopyWithImpl<_$ParsedContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParsedContentImplToJson(this);
  }
}

abstract class _ParsedContent implements ParsedContent {
  const factory _ParsedContent({
    required final EmailContentType type,
    required final String content,
    final String? charset,
    final String? encoding,
  }) = _$ParsedContentImpl;

  factory _ParsedContent.fromJson(Map<String, dynamic> json) =
      _$ParsedContentImpl.fromJson;

  /// 内容类型
  @override
  EmailContentType get type;

  /// 解析后的内容
  @override
  String get content;

  /// 字符集编码（如 UTF-8, GBK 等）
  @override
  String? get charset;

  /// 传输编码（如 base64, quoted-printable 等）
  @override
  String? get encoding;

  /// Create a copy of ParsedContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParsedContentImplCopyWith<_$ParsedContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
