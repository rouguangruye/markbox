// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Email _$EmailFromJson(Map<String, dynamic> json) {
  return _Email.fromJson(json);
}

/// @nodoc
mixin _$Email {
  /// 邮件唯一标识符
  String get id => throw _privateConstructorUsedError;

  /// 发件人名称（可能为空）
  String? get senderName => throw _privateConstructorUsedError;

  /// 发件人邮箱地址
  String get senderEmail => throw _privateConstructorUsedError;

  /// 邮件主题
  String get subject => throw _privateConstructorUsedError;

  /// 邮件日期时间
  DateTime get date => throw _privateConstructorUsedError;

  /// 列表预览文本（简短的纯文本，最多 100 字符）
  String? get preview => throw _privateConstructorUsedError;

  /// 邮件完整内容（HTML 或纯文本）
  String? get body => throw _privateConstructorUsedError;

  /// 邮件内容类型
  EmailContentType get contentType => throw _privateConstructorUsedError;

  /// 是否已读
  bool get isRead => throw _privateConstructorUsedError;

  /// AI 生成的摘要（可选）
  String? get summary => throw _privateConstructorUsedError;

  /// 摘要生成状态
  SummaryStatus get summaryStatus => throw _privateConstructorUsedError;

  /// 原始 MIME 消息内容（用于 MimeMessageViewer 渲染）
  String? get mimeMessageRaw => throw _privateConstructorUsedError;

  /// 缓存时间戳（用于缓存过期判断）
  int? get cachedAt => throw _privateConstructorUsedError;

  /// Serializes this Email to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Email
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailCopyWith<Email> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailCopyWith<$Res> {
  factory $EmailCopyWith(Email value, $Res Function(Email) then) =
      _$EmailCopyWithImpl<$Res, Email>;
  @useResult
  $Res call({
    String id,
    String? senderName,
    String senderEmail,
    String subject,
    DateTime date,
    String? preview,
    String? body,
    EmailContentType contentType,
    bool isRead,
    String? summary,
    SummaryStatus summaryStatus,
    String? mimeMessageRaw,
    int? cachedAt,
  });
}

/// @nodoc
class _$EmailCopyWithImpl<$Res, $Val extends Email>
    implements $EmailCopyWith<$Res> {
  _$EmailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Email
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderName = freezed,
    Object? senderEmail = null,
    Object? subject = null,
    Object? date = null,
    Object? preview = freezed,
    Object? body = freezed,
    Object? contentType = null,
    Object? isRead = null,
    Object? summary = freezed,
    Object? summaryStatus = null,
    Object? mimeMessageRaw = freezed,
    Object? cachedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            senderName: freezed == senderName
                ? _value.senderName
                : senderName // ignore: cast_nullable_to_non_nullable
                      as String?,
            senderEmail: null == senderEmail
                ? _value.senderEmail
                : senderEmail // ignore: cast_nullable_to_non_nullable
                      as String,
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            preview: freezed == preview
                ? _value.preview
                : preview // ignore: cast_nullable_to_non_nullable
                      as String?,
            body: freezed == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                      as String?,
            contentType: null == contentType
                ? _value.contentType
                : contentType // ignore: cast_nullable_to_non_nullable
                      as EmailContentType,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
            summary: freezed == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String?,
            summaryStatus: null == summaryStatus
                ? _value.summaryStatus
                : summaryStatus // ignore: cast_nullable_to_non_nullable
                      as SummaryStatus,
            mimeMessageRaw: freezed == mimeMessageRaw
                ? _value.mimeMessageRaw
                : mimeMessageRaw // ignore: cast_nullable_to_non_nullable
                      as String?,
            cachedAt: freezed == cachedAt
                ? _value.cachedAt
                : cachedAt // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EmailImplCopyWith<$Res> implements $EmailCopyWith<$Res> {
  factory _$$EmailImplCopyWith(
    _$EmailImpl value,
    $Res Function(_$EmailImpl) then,
  ) = __$$EmailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? senderName,
    String senderEmail,
    String subject,
    DateTime date,
    String? preview,
    String? body,
    EmailContentType contentType,
    bool isRead,
    String? summary,
    SummaryStatus summaryStatus,
    String? mimeMessageRaw,
    int? cachedAt,
  });
}

/// @nodoc
class __$$EmailImplCopyWithImpl<$Res>
    extends _$EmailCopyWithImpl<$Res, _$EmailImpl>
    implements _$$EmailImplCopyWith<$Res> {
  __$$EmailImplCopyWithImpl(
    _$EmailImpl _value,
    $Res Function(_$EmailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Email
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderName = freezed,
    Object? senderEmail = null,
    Object? subject = null,
    Object? date = null,
    Object? preview = freezed,
    Object? body = freezed,
    Object? contentType = null,
    Object? isRead = null,
    Object? summary = freezed,
    Object? summaryStatus = null,
    Object? mimeMessageRaw = freezed,
    Object? cachedAt = freezed,
  }) {
    return _then(
      _$EmailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        senderName: freezed == senderName
            ? _value.senderName
            : senderName // ignore: cast_nullable_to_non_nullable
                  as String?,
        senderEmail: null == senderEmail
            ? _value.senderEmail
            : senderEmail // ignore: cast_nullable_to_non_nullable
                  as String,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        preview: freezed == preview
            ? _value.preview
            : preview // ignore: cast_nullable_to_non_nullable
                  as String?,
        body: freezed == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String?,
        contentType: null == contentType
            ? _value.contentType
            : contentType // ignore: cast_nullable_to_non_nullable
                  as EmailContentType,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
        summary: freezed == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String?,
        summaryStatus: null == summaryStatus
            ? _value.summaryStatus
            : summaryStatus // ignore: cast_nullable_to_non_nullable
                  as SummaryStatus,
        mimeMessageRaw: freezed == mimeMessageRaw
            ? _value.mimeMessageRaw
            : mimeMessageRaw // ignore: cast_nullable_to_non_nullable
                  as String?,
        cachedAt: freezed == cachedAt
            ? _value.cachedAt
            : cachedAt // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailImpl implements _Email {
  const _$EmailImpl({
    required this.id,
    this.senderName,
    required this.senderEmail,
    required this.subject,
    required this.date,
    this.preview,
    this.body,
    this.contentType = EmailContentType.unknown,
    this.isRead = false,
    this.summary,
    this.summaryStatus = SummaryStatus.notGenerated,
    this.mimeMessageRaw,
    this.cachedAt,
  });

  factory _$EmailImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailImplFromJson(json);

  /// 邮件唯一标识符
  @override
  final String id;

  /// 发件人名称（可能为空）
  @override
  final String? senderName;

  /// 发件人邮箱地址
  @override
  final String senderEmail;

  /// 邮件主题
  @override
  final String subject;

  /// 邮件日期时间
  @override
  final DateTime date;

  /// 列表预览文本（简短的纯文本，最多 100 字符）
  @override
  final String? preview;

  /// 邮件完整内容（HTML 或纯文本）
  @override
  final String? body;

  /// 邮件内容类型
  @override
  @JsonKey()
  final EmailContentType contentType;

  /// 是否已读
  @override
  @JsonKey()
  final bool isRead;

  /// AI 生成的摘要（可选）
  @override
  final String? summary;

  /// 摘要生成状态
  @override
  @JsonKey()
  final SummaryStatus summaryStatus;

  /// 原始 MIME 消息内容（用于 MimeMessageViewer 渲染）
  @override
  final String? mimeMessageRaw;

  /// 缓存时间戳（用于缓存过期判断）
  @override
  final int? cachedAt;

  @override
  String toString() {
    return 'Email(id: $id, senderName: $senderName, senderEmail: $senderEmail, subject: $subject, date: $date, preview: $preview, body: $body, contentType: $contentType, isRead: $isRead, summary: $summary, summaryStatus: $summaryStatus, mimeMessageRaw: $mimeMessageRaw, cachedAt: $cachedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderEmail, senderEmail) ||
                other.senderEmail == senderEmail) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.preview, preview) || other.preview == preview) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.summaryStatus, summaryStatus) ||
                other.summaryStatus == summaryStatus) &&
            (identical(other.mimeMessageRaw, mimeMessageRaw) ||
                other.mimeMessageRaw == mimeMessageRaw) &&
            (identical(other.cachedAt, cachedAt) ||
                other.cachedAt == cachedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    senderName,
    senderEmail,
    subject,
    date,
    preview,
    body,
    contentType,
    isRead,
    summary,
    summaryStatus,
    mimeMessageRaw,
    cachedAt,
  );

  /// Create a copy of Email
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailImplCopyWith<_$EmailImpl> get copyWith =>
      __$$EmailImplCopyWithImpl<_$EmailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailImplToJson(this);
  }
}

abstract class _Email implements Email {
  const factory _Email({
    required final String id,
    final String? senderName,
    required final String senderEmail,
    required final String subject,
    required final DateTime date,
    final String? preview,
    final String? body,
    final EmailContentType contentType,
    final bool isRead,
    final String? summary,
    final SummaryStatus summaryStatus,
    final String? mimeMessageRaw,
    final int? cachedAt,
  }) = _$EmailImpl;

  factory _Email.fromJson(Map<String, dynamic> json) = _$EmailImpl.fromJson;

  /// 邮件唯一标识符
  @override
  String get id;

  /// 发件人名称（可能为空）
  @override
  String? get senderName;

  /// 发件人邮箱地址
  @override
  String get senderEmail;

  /// 邮件主题
  @override
  String get subject;

  /// 邮件日期时间
  @override
  DateTime get date;

  /// 列表预览文本（简短的纯文本，最多 100 字符）
  @override
  String? get preview;

  /// 邮件完整内容（HTML 或纯文本）
  @override
  String? get body;

  /// 邮件内容类型
  @override
  EmailContentType get contentType;

  /// 是否已读
  @override
  bool get isRead;

  /// AI 生成的摘要（可选）
  @override
  String? get summary;

  /// 摘要生成状态
  @override
  SummaryStatus get summaryStatus;

  /// 原始 MIME 消息内容（用于 MimeMessageViewer 渲染）
  @override
  String? get mimeMessageRaw;

  /// 缓存时间戳（用于缓存过期判断）
  @override
  int? get cachedAt;

  /// Create a copy of Email
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailImplCopyWith<_$EmailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
