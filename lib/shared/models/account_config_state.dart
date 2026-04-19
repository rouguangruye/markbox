import 'package:freezed_annotation/freezed_annotation.dart';

import 'imap_config.dart';

part 'account_config_state.freezed.dart';

/// 账户配置状态
///
/// 用于管理账户配置的状态信息
@freezed
class AccountConfigState with _$AccountConfigState {
  const factory AccountConfigState({
    /// 所有已配置的 IMAP 配置列表
    @Default([]) List<ImapConfig> configs,

    /// 是否正在加载
    @Default(false) bool isLoading,

    /// 是否正在保存
    @Default(false) bool isSaving,

    /// 是否已初始化（从存储加载完成）
    @Default(false) bool isInitialized,

    /// 错误信息（可选）
    String? error,
  }) = _AccountConfigState;
}
