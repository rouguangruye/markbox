// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_list_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EmailListItem _$EmailListItemFromJson(Map<String, dynamic> json) {
  return _EmailListItem.fromJson(json);
}

/// @nodoc
mixin _$EmailListItem {
  /// 邮件唯一标识
  String get uid => throw _privateConstructorUsedError;

  /// 发件人显示名
  String get senderName => throw _privateConstructorUsedError;

  /// 发件人邮箱地址
  String get senderEmail => throw _privateConstructorUsedError;

  /// 邮件主题
  String get subject => throw _privateConstructorUsedError;

  /// 接收时间
  DateTime get receivedDate => throw _privateConstructorUsedError;

  /// 是否已读
  bool get isRead => throw _privateConstructorUsedError;

  /// Serializes this EmailListItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailListItemCopyWith<EmailListItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailListItemCopyWith<$Res> {
  factory $EmailListItemCopyWith(
    EmailListItem value,
    $Res Function(EmailListItem) then,
  ) = _$EmailListItemCopyWithImpl<$Res, EmailListItem>;
  @useResult
  $Res call({
    String uid,
    String senderName,
    String senderEmail,
    String subject,
    DateTime receivedDate,
    bool isRead,
  });
}

/// @nodoc
class _$EmailListItemCopyWithImpl<$Res, $Val extends EmailListItem>
    implements $EmailListItemCopyWith<$Res> {
  _$EmailListItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? senderName = null,
    Object? senderEmail = null,
    Object? subject = null,
    Object? receivedDate = null,
    Object? isRead = null,
  }) {
    return _then(
      _value.copyWith(
            uid: null == uid
                ? _value.uid
                : uid // ignore: cast_nullable_to_non_nullable
                      as String,
            senderName: null == senderName
                ? _value.senderName
                : senderName // ignore: cast_nullable_to_non_nullable
                      as String,
            senderEmail: null == senderEmail
                ? _value.senderEmail
                : senderEmail // ignore: cast_nullable_to_non_nullable
                      as String,
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            receivedDate: null == receivedDate
                ? _value.receivedDate
                : receivedDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EmailListItemImplCopyWith<$Res>
    implements $EmailListItemCopyWith<$Res> {
  factory _$$EmailListItemImplCopyWith(
    _$EmailListItemImpl value,
    $Res Function(_$EmailListItemImpl) then,
  ) = __$$EmailListItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String uid,
    String senderName,
    String senderEmail,
    String subject,
    DateTime receivedDate,
    bool isRead,
  });
}

/// @nodoc
class __$$EmailListItemImplCopyWithImpl<$Res>
    extends _$EmailListItemCopyWithImpl<$Res, _$EmailListItemImpl>
    implements _$$EmailListItemImplCopyWith<$Res> {
  __$$EmailListItemImplCopyWithImpl(
    _$EmailListItemImpl _value,
    $Res Function(_$EmailListItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmailListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? senderName = null,
    Object? senderEmail = null,
    Object? subject = null,
    Object? receivedDate = null,
    Object? isRead = null,
  }) {
    return _then(
      _$EmailListItemImpl(
        uid: null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
        senderName: null == senderName
            ? _value.senderName
            : senderName // ignore: cast_nullable_to_non_nullable
                  as String,
        senderEmail: null == senderEmail
            ? _value.senderEmail
            : senderEmail // ignore: cast_nullable_to_non_nullable
                  as String,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        receivedDate: null == receivedDate
            ? _value.receivedDate
            : receivedDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailListItemImpl implements _EmailListItem {
  const _$EmailListItemImpl({
    required this.uid,
    required this.senderName,
    required this.senderEmail,
    required this.subject,
    required this.receivedDate,
    this.isRead = false,
  });

  factory _$EmailListItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailListItemImplFromJson(json);

  /// 邮件唯一标识
  @override
  final String uid;

  /// 发件人显示名
  @override
  final String senderName;

  /// 发件人邮箱地址
  @override
  final String senderEmail;

  /// 邮件主题
  @override
  final String subject;

  /// 接收时间
  @override
  final DateTime receivedDate;

  /// 是否已读
  @override
  @JsonKey()
  final bool isRead;

  @override
  String toString() {
    return 'EmailListItem(uid: $uid, senderName: $senderName, senderEmail: $senderEmail, subject: $subject, receivedDate: $receivedDate, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailListItemImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderEmail, senderEmail) ||
                other.senderEmail == senderEmail) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.receivedDate, receivedDate) ||
                other.receivedDate == receivedDate) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    uid,
    senderName,
    senderEmail,
    subject,
    receivedDate,
    isRead,
  );

  /// Create a copy of EmailListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailListItemImplCopyWith<_$EmailListItemImpl> get copyWith =>
      __$$EmailListItemImplCopyWithImpl<_$EmailListItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailListItemImplToJson(this);
  }
}

abstract class _EmailListItem implements EmailListItem {
  const factory _EmailListItem({
    required final String uid,
    required final String senderName,
    required final String senderEmail,
    required final String subject,
    required final DateTime receivedDate,
    final bool isRead,
  }) = _$EmailListItemImpl;

  factory _EmailListItem.fromJson(Map<String, dynamic> json) =
      _$EmailListItemImpl.fromJson;

  /// 邮件唯一标识
  @override
  String get uid;

  /// 发件人显示名
  @override
  String get senderName;

  /// 发件人邮箱地址
  @override
  String get senderEmail;

  /// 邮件主题
  @override
  String get subject;

  /// 接收时间
  @override
  DateTime get receivedDate;

  /// 是否已读
  @override
  bool get isRead;

  /// Create a copy of EmailListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailListItemImplCopyWith<_$EmailListItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
