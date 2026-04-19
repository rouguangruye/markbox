// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EmailDetailState _$EmailDetailStateFromJson(Map<String, dynamic> json) {
  return _EmailDetailState.fromJson(json);
}

/// @nodoc
mixin _$EmailDetailState {
  /// 是否正在加载邮件数据
  bool get isLoading => throw _privateConstructorUsedError;

  /// 邮件详情数据
  Email? get email => throw _privateConstructorUsedError;

  /// 错误信息
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this EmailDetailState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailDetailStateCopyWith<EmailDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailDetailStateCopyWith<$Res> {
  factory $EmailDetailStateCopyWith(
    EmailDetailState value,
    $Res Function(EmailDetailState) then,
  ) = _$EmailDetailStateCopyWithImpl<$Res, EmailDetailState>;
  @useResult
  $Res call({bool isLoading, Email? email, String? error});

  $EmailCopyWith<$Res>? get email;
}

/// @nodoc
class _$EmailDetailStateCopyWithImpl<$Res, $Val extends EmailDetailState>
    implements $EmailDetailStateCopyWith<$Res> {
  _$EmailDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? email = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as Email?,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of EmailDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EmailCopyWith<$Res>? get email {
    if (_value.email == null) {
      return null;
    }

    return $EmailCopyWith<$Res>(_value.email!, (value) {
      return _then(_value.copyWith(email: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EmailDetailStateImplCopyWith<$Res>
    implements $EmailDetailStateCopyWith<$Res> {
  factory _$$EmailDetailStateImplCopyWith(
    _$EmailDetailStateImpl value,
    $Res Function(_$EmailDetailStateImpl) then,
  ) = __$$EmailDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, Email? email, String? error});

  @override
  $EmailCopyWith<$Res>? get email;
}

/// @nodoc
class __$$EmailDetailStateImplCopyWithImpl<$Res>
    extends _$EmailDetailStateCopyWithImpl<$Res, _$EmailDetailStateImpl>
    implements _$$EmailDetailStateImplCopyWith<$Res> {
  __$$EmailDetailStateImplCopyWithImpl(
    _$EmailDetailStateImpl _value,
    $Res Function(_$EmailDetailStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmailDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? email = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _$EmailDetailStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as Email?,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailDetailStateImpl implements _EmailDetailState {
  const _$EmailDetailStateImpl({
    this.isLoading = false,
    this.email,
    this.error,
  });

  factory _$EmailDetailStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailDetailStateImplFromJson(json);

  /// 是否正在加载邮件数据
  @override
  @JsonKey()
  final bool isLoading;

  /// 邮件详情数据
  @override
  final Email? email;

  /// 错误信息
  @override
  final String? error;

  @override
  String toString() {
    return 'EmailDetailState(isLoading: $isLoading, email: $email, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailDetailStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isLoading, email, error);

  /// Create a copy of EmailDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailDetailStateImplCopyWith<_$EmailDetailStateImpl> get copyWith =>
      __$$EmailDetailStateImplCopyWithImpl<_$EmailDetailStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailDetailStateImplToJson(this);
  }
}

abstract class _EmailDetailState implements EmailDetailState {
  const factory _EmailDetailState({
    final bool isLoading,
    final Email? email,
    final String? error,
  }) = _$EmailDetailStateImpl;

  factory _EmailDetailState.fromJson(Map<String, dynamic> json) =
      _$EmailDetailStateImpl.fromJson;

  /// 是否正在加载邮件数据
  @override
  bool get isLoading;

  /// 邮件详情数据
  @override
  Email? get email;

  /// 错误信息
  @override
  String? get error;

  /// Create a copy of EmailDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailDetailStateImplCopyWith<_$EmailDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
