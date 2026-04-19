import 'package:freezed_annotation/freezed_annotation.dart';

import 'email.dart';

part 'email_list_state.freezed.dart';

/// 邮件列表状态
///
/// 管理邮件列表的加载、刷新、分页等状态
@freezed
class EmailListState with _$EmailListState {
  const factory EmailListState({
    /// 邮件列表数据
    @Default([]) List<Email> emails,

    /// 是否正在加载（首次加载）
    @Default(false) bool isLoading,

    /// 是否正在刷新（下拉刷新）
    @Default(false) bool isRefreshing,

    /// 是否正在加载更多（分页加载）
    @Default(false) bool isLoadingMore,

    /// 是否已初始化（已加载过数据）
    @Default(false) bool isInitialized,

    /// 错误信息
    String? error,

    /// 当前页码（从 1 开始）
    @Default(1) int currentPage,

    /// 是否有更多数据
    @Default(true) bool hasMore,

    /// 邮件总数（如果服务器支持）
    int? totalCount,
  }) = _EmailListState;
}
