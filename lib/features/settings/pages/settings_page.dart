import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../account/pages/account_list_page.dart';
import '../../../shared/providers/account_config_provider.dart';
import '../../../shared/themes/app_colors.dart';
import '../../../shared/themes/app_text_styles.dart';
import '../../../shared/themes/app_spacing.dart';
import '../../../shared/themes/app_decorations.dart';
import '../../../shared/widgets/animated_widgets.dart';
import '../../../shared/routes/animated_page_route.dart';

/// 设置页面
///
/// 提供应用设置入口，包括账户配置、主题设置等
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 监听账户配置状态
    final configState = ref.watch(accountConfigProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
      ),
      body: ListView(
        children: [
          // 账户设置分组
          _buildSectionHeader(context, '账户设置'),
          _AccountConfigTile(
            configCount: configState.configs.length,
            onTap: () => _navigateToAccountList(context),
          ),

          // 其他设置分组（预留）
          const SizedBox(height: 8),
          _buildSectionHeader(context, '其他设置'),
          ListTile(
            leading: Icon(Icons.info_outline, color: AppColors.textSecondary),
            title: Text(
              '关于',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            subtitle: Text(
              '版本信息',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            trailing: Icon(Icons.chevron_right, color: AppColors.textSecondary),
            onTap: () {
              // TODO: 跳转到关于页面
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('关于页面待实现'),
                  backgroundColor: AppColors.textSecondary,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// 构建分组标题
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: AppTextStyles.titleSmall.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// 跳转到账户列表页面
  void _navigateToAccountList(BuildContext context) {
    PageTransitions.slideFade(context, const AccountListPage());
  }
}

/// 账户配置列表项
///
/// 显示账户配置状态，点击进入配置页面
class _AccountConfigTile extends StatelessWidget {
  const _AccountConfigTile({required this.configCount, required this.onTap});

  final int configCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasConfig = configCount > 0;

    return AnimatedCard(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: AppEdgeInsets.card,
        decoration: AppDecorations.cardFlat(color: AppColors.cardBackground),
        child: Row(
          children: [
            // 图标
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: hasConfig
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.backgroundSecondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                hasConfig ? Icons.mail : Icons.mail_outline,
                color: hasConfig ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 16),

            // 文字内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '邮箱管理',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hasConfig ? '已配置 $configCount 个邮箱' : '点击配置邮箱账户',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: hasConfig
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // 状态指示
            Icon(
              hasConfig ? Icons.check_circle : Icons.arrow_forward_ios,
              size: hasConfig ? 24 : 16,
              color: hasConfig ? AppColors.primary : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
