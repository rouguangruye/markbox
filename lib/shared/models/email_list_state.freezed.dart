// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$EmailListState {
  /// 邮件列表数据
  List<Email> get emails => throw _privateConstructorUsedError;

  /// 是否正在加载（首次加载）
  bool get isLoading => throw _privateConstructorUsedError;

  /// 是否正在刷新（下拉刷新）
  bool get isRefreshing => throw _privateConstructorUsedError;

  /// 是否正在加载更多（分页加载）
  bool get isLoadingMore => throw _privateConstructorUsedError;

  /// 是否已初始化（已加载过数据）
  bool get isInitialized => throw _privateConstructorUsedError;

  /// 错误信息
  String? get error => throw _privateConstructorUsedError;

  /// 当前页码（从 1 开始）
  int get currentPage => throw _privateConstructorUsedError;

  /// 是否有更多数据
  bool get hasMore => throw _privateConstructorUsedError;

  /// 邮件总数（如果服务器支持）
  int? get totalCount => throw _privateConstructorUsedError;

  /// Create a copy of EmailListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailListStateCopyWith<EmailListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailListStateCopyWith<$Res> {
  factory $EmailListStateCopyWith(
    EmailListState value,
    $Res Function(EmailListState) then,
  ) = _$EmailListStateCopyWithImpl<$Res, EmailListState>;
  @useResult
  $Res call({
    List<Email> emails,
    bool isLoading,
    bool isRefreshing,
    bool isLoadingMore,
    bool isInitialized,
    String? error,
    int currentPage,
    bool hasMore,
    int? totalCount,
  });
}

/// @nodoc
class _$EmailListStateCopyWithImpl<$Res, $Val extends EmailListState>
    implements $EmailListStateCopyWith<$Res> {
  _$EmailListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emails = null,
    Object? isLoading = null,
    Object? isRefreshing = null,
    Object? isLoadingMore = null,
    Object? isInitialized = null,
    Object? error = freezed,
    Object? currentPage = null,
    Object? hasMore = null,
    Object? totalCount = freezed,
  }) {
    return _then(
      _value.copyWith(
            emails: null == emails
                ? _value.emails
                : emails // ignore: cast_nullable_to_non_nullable
                      as List<Email>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRefreshing: null == isRefreshing
                ? _value.isRefreshing
                : isRefreshing // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            isInitialized: null == isInitialized
                ? _value.isInitialized
                : isInitialized // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            totalCount: freezed == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EmailListStateImplCopyWith<$Res>
    implements $EmailListStateCopyWith<$Res> {
  factory _$$EmailListStateImplCopyWith(
    _$EmailListStateImpl value,
    $Res Function(_$EmailListStateImpl) then,
  ) = __$$EmailListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Email> emails,
    bool isLoading,
    bool isRefreshing,
    bool isLoadingMore,
    bool isInitialized,
    String? error,
    int currentPage,
    bool hasMore,
    int? totalCount,
  });
}

/// @nodoc
class __$$EmailListStateImplCopyWithImpl<$Res>
    extends _$EmailListStateCopyWithImpl<$Res, _$EmailListStateImpl>
    implements _$$EmailListStateImplCopyWith<$Res> {
  __$$EmailListStateImplCopyWithImpl(
    _$EmailListStateImpl _value,
    $Res Function(_$EmailListStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmailListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emails = null,
    Object? isLoading = null,
    Object? isRefreshing = null,
    Object? isLoadingMore = null,
    Object? isInitialized = null,
    Object? error = freezed,
    Object? currentPage = null,
    Object? hasMore = null,
    Object? totalCount = freezed,
  }) {
    return _then(
      _$EmailListStateImpl(
        emails: null == emails
            ? _value._emails
            : emails // ignore: cast_nullable_to_non_nullable
                  as List<Email>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRefreshing: null == isRefreshing
            ? _value.isRefreshing
            : isRefreshing // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        isInitialized: null == isInitialized
            ? _value.isInitialized
            : isInitialized // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalCount: freezed == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$EmailListStateImpl implements _EmailListState {
  const _$EmailListStateImpl({
    final List<Email> emails = const [],
    this.isLoading = false,
    this.isRefreshing = false,
    this.isLoadingMore = false,
    this.isInitialized = false,
    this.error,
    this.currentPage = 1,
    this.hasMore = true,
    this.totalCount,
  }) : _emails = emails;

  /// 邮件列表数据
  final List<Email> _emails;

  /// 邮件列表数据
  @override
  @JsonKey()
  List<Email> get emails {
    if (_emails is EqualUnmodifiableListView) return _emails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_emails);
  }

  /// 是否正在加载（首次加载）
  @override
  @JsonKey()
  final bool isLoading;

  /// 是否正在刷新（下拉刷新）
  @override
  @JsonKey()
  final bool isRefreshing;

  /// 是否正在加载更多（分页加载）
  @override
  @JsonKey()
  final bool isLoadingMore;

  /// 是否已初始化（已加载过数据）
  @override
  @JsonKey()
  final bool isInitialized;

  /// 错误信息
  @override
  final String? error;

  /// 当前页码（从 1 开始）
  @override
  @JsonKey()
  final int currentPage;

  /// 是否有更多数据
  @override
  @JsonKey()
  final bool hasMore;

  /// 邮件总数（如果服务器支持）
  @override
  final int? totalCount;

  @override
  String toString() {
    return 'EmailListState(emails: $emails, isLoading: $isLoading, isRefreshing: $isRefreshing, isLoadingMore: $isLoadingMore, isInitialized: $isInitialized, error: $error, currentPage: $currentPage, hasMore: $hasMore, totalCount: $totalCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailListStateImpl &&
            const DeepCollectionEquality().equals(other._emails, _emails) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isRefreshing, isRefreshing) ||
                other.isRefreshing == isRefreshing) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_emails),
    isLoading,
    isRefreshing,
    isLoadingMore,
    isInitialized,
    error,
    currentPage,
    hasMore,
    totalCount,
  );

  /// Create a copy of EmailListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailListStateImplCopyWith<_$EmailListStateImpl> get copyWith =>
      __$$EmailListStateImplCopyWithImpl<_$EmailListStateImpl>(
        this,
        _$identity,
      );
}

abstract class _EmailListState implements EmailListState {
  const factory _EmailListState({
    final List<Email> emails,
    final bool isLoading,
    final bool isRefreshing,
    final bool isLoadingMore,
    final bool isInitialized,
    final String? error,
    final int currentPage,
    final bool hasMore,
    final int? totalCount,
  }) = _$EmailListStateImpl;

  /// 邮件列表数据
  @override
  List<Email> get emails;

  /// 是否正在加载（首次加载）
  @override
  bool get isLoading;

  /// 是否正在刷新（下拉刷新）
  @override
  bool get isRefreshing;

  /// 是否正在加载更多（分页加载）
  @override
  bool get isLoadingMore;

  /// 是否已初始化（已加载过数据）
  @override
  bool get isInitialized;

  /// 错误信息
  @override
  String? get error;

  /// 当前页码（从 1 开始）
  @override
  int get currentPage;

  /// 是否有更多数据
  @override
  bool get hasMore;

  /// 邮件总数（如果服务器支持）
  @override
  int? get totalCount;

  /// Create a copy of EmailListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailListStateImplCopyWith<_$EmailListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
