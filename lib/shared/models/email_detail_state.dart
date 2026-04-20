import 'package:freezed_annotation/freezed_annotation.dart';

import 'email.dart';

part 'email_detail_state.freezed.dart';
part 'email_detail_state.g.dart';

/// 邮件详情状态
///
/// 用于管理邮件详情页面的加载状态和数据
@freezed
class EmailDetailState with _$EmailDetailState {
  const factory EmailDetailState({
    /// 是否正在加载邮件数据
    @Default(false) bool isLoading,

    /// 内容是否正在渲染（包括 Markdown 解析、HTML WebView 加载等）
    @Default(true) bool isContentLoading,

    /// 邮件详情数据
    Email? email,

    /// 错误信息
    String? error,
  }) = _EmailDetailState;

  factory EmailDetailState.fromJson(Map<String, dynamic> json) =>
      _$EmailDetailStateFromJson(json);
}
