// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_config_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AccountConfigState {
  /// 所有已配置的 IMAP 配置列表
  List<ImapConfig> get configs => throw _privateConstructorUsedError;

  /// 是否正在加载
  bool get isLoading => throw _privateConstructorUsedError;

  /// 是否正在保存
  bool get isSaving => throw _privateConstructorUsedError;

  /// 是否已初始化（从存储加载完成）
  bool get isInitialized => throw _privateConstructorUsedError;

  /// 错误信息（可选）
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of AccountConfigState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountConfigStateCopyWith<AccountConfigState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountConfigStateCopyWith<$Res> {
  factory $AccountConfigStateCopyWith(
    AccountConfigState value,
    $Res Function(AccountConfigState) then,
  ) = _$AccountConfigStateCopyWithImpl<$Res, AccountConfigState>;
  @useResult
  $Res call({
    List<ImapConfig> configs,
    bool isLoading,
    bool isSaving,
    bool isInitialized,
    String? error,
  });
}

/// @nodoc
class _$AccountConfigStateCopyWithImpl<$Res, $Val extends AccountConfigState>
    implements $AccountConfigStateCopyWith<$Res> {
  _$AccountConfigStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountConfigState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? configs = null,
    Object? isLoading = null,
    Object? isSaving = null,
    Object? isInitialized = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            configs: null == configs
                ? _value.configs
                : configs // ignore: cast_nullable_to_non_nullable
                      as List<ImapConfig>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSaving: null == isSaving
                ? _value.isSaving
                : isSaving // ignore: cast_nullable_to_non_nullable
                      as bool,
            isInitialized: null == isInitialized
                ? _value.isInitialized
                : isInitialized // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AccountConfigStateImplCopyWith<$Res>
    implements $AccountConfigStateCopyWith<$Res> {
  factory _$$AccountConfigStateImplCopyWith(
    _$AccountConfigStateImpl value,
    $Res Function(_$AccountConfigStateImpl) then,
  ) = __$$AccountConfigStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ImapConfig> configs,
    bool isLoading,
    bool isSaving,
    bool isInitialized,
    String? error,
  });
}

/// @nodoc
class __$$AccountConfigStateImplCopyWithImpl<$Res>
    extends _$AccountConfigStateCopyWithImpl<$Res, _$AccountConfigStateImpl>
    implements _$$AccountConfigStateImplCopyWith<$Res> {
  __$$AccountConfigStateImplCopyWithImpl(
    _$AccountConfigStateImpl _value,
    $Res Function(_$AccountConfigStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountConfigState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? configs = null,
    Object? isLoading = null,
    Object? isSaving = null,
    Object? isInitialized = null,
    Object? error = freezed,
  }) {
    return _then(
      _$AccountConfigStateImpl(
        configs: null == configs
            ? _value._configs
            : configs // ignore: cast_nullable_to_non_nullable
                  as List<ImapConfig>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSaving: null == isSaving
            ? _value.isSaving
            : isSaving // ignore: cast_nullable_to_non_nullable
                  as bool,
        isInitialized: null == isInitialized
            ? _value.isInitialized
            : isInitialized // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AccountConfigStateImpl implements _AccountConfigState {
  const _$AccountConfigStateImpl({
    final List<ImapConfig> configs = const [],
    this.isLoading = false,
    this.isSaving = false,
    this.isInitialized = false,
    this.error,
  }) : _configs = configs;

  /// 所有已配置的 IMAP 配置列表
  final List<ImapConfig> _configs;

  /// 所有已配置的 IMAP 配置列表
  @override
  @JsonKey()
  List<ImapConfig> get configs {
    if (_configs is EqualUnmodifiableListView) return _configs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_configs);
  }

  /// 是否正在加载
  @override
  @JsonKey()
  final bool isLoading;

  /// 是否正在保存
  @override
  @JsonKey()
  final bool isSaving;

  /// 是否已初始化（从存储加载完成）
  @override
  @JsonKey()
  final bool isInitialized;

  /// 错误信息（可选）
  @override
  final String? error;

  @override
  String toString() {
    return 'AccountConfigState(configs: $configs, isLoading: $isLoading, isSaving: $isSaving, isInitialized: $isInitialized, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountConfigStateImpl &&
            const DeepCollectionEquality().equals(other._configs, _configs) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_configs),
    isLoading,
    isSaving,
    isInitialized,
    error,
  );

  /// Create a copy of AccountConfigState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountConfigStateImplCopyWith<_$AccountConfigStateImpl> get copyWith =>
      __$$AccountConfigStateImplCopyWithImpl<_$AccountConfigStateImpl>(
        this,
        _$identity,
      );
}

abstract class _AccountConfigState implements AccountConfigState {
  const factory _AccountConfigState({
    final List<ImapConfig> configs,
    final bool isLoading,
    final bool isSaving,
    final bool isInitialized,
    final String? error,
  }) = _$AccountConfigStateImpl;

  /// 所有已配置的 IMAP 配置列表
  @override
  List<ImapConfig> get configs;

  /// 是否正在加载
  @override
  bool get isLoading;

  /// 是否正在保存
  @override
  bool get isSaving;

  /// 是否已初始化（从存储加载完成）
  @override
  bool get isInitialized;

  /// 错误信息（可选）
  @override
  String? get error;

  /// Create a copy of AccountConfigState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountConfigStateImplCopyWith<_$AccountConfigStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
