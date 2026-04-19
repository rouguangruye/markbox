import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/email_detail_state.dart';
import '../services/secure_storage_service.dart';
import '../../services/email_service.dart';
import 'account_config_provider.dart';
import 'email_list_provider.dart';

part 'email_detail_provider.g.dart';

/// 邮件详情 Provider
///
/// 管理邮件详情的加载状态，支持根据邮件 ID 加载详情
@riverpod
class EmailDetail extends _$EmailDetail {
  /// 邮件服务实例
  late final EmailService _emailService;

  /// 安全存储服务实例
  late final SecureStorageService _storageService;

  @override
  EmailDetailState build() {
    // 初始化服务实例
    _emailService = ref.watch(emailServiceProvider);
    _storageService = SecureStorageService();

    // 返回初始状态
    return const EmailDetailState();
  }

  /// 加载邮件详情
  ///
  /// [emailId] 邮件 ID
  /// 从 IMAP 服务器获取邮件详情
  Future<void> loadEmailDetail(String emailId) async {
    // 设置加载状态
    state = state.copyWith(isLoading: true, error: null);

    // 获取当前账户配置列表
    final accountConfig = ref.read(accountConfigProvider);
    final configs = accountConfig.configs;

    // 检查是否有配置
    if (configs.isEmpty) {
      state = state.copyWith(error: '未配置邮箱账户', isLoading: false);
      return;
    }

    // 尝试从所有配置的账户获取邮件详情
    for (final config in configs) {
      try {
        // 获取邮件详情
        final email = await _emailService.fetchEmailDetail(
          config: config,
          messageId: emailId,
        );

        // 更新状态
        state = state.copyWith(email: email, isLoading: false, error: null);

        // 保存到本地缓存
        await _storageService.saveEmailDetail(email);

        // 更新本地邮件列表中的已读状态
        // 使用 BODY[] 获取邮件详情后，服务器会自动设置 \Seen 标志
        ref.read(emailListProvider.notifier).markEmailAsRead(emailId);
        return;
      } catch (e) {
        // 继续尝试下一个配置
        continue;
      }
    }

    // 所有配置都无法获取邮件详情
    state = state.copyWith(isLoading: false, error: '加载邮件详情失败');
  }

  /// 清除错误信息
  ///
  /// 清除当前状态中的错误信息
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// 重置状态
  ///
  /// 将状态重置为初始状态
  void reset() {
    state = const EmailDetailState();
  }
}
