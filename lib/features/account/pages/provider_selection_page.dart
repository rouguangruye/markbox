import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/constants/email_providers.dart';
import '../../../shared/models/email_provider.dart';
import '../../../shared/models/imap_config.dart';
import '../../../shared/themes/app_colors.dart';
import '../../../shared/themes/app_text_styles.dart';
import '../../../shared/themes/app_spacing.dart';
import '../../../shared/themes/app_decorations.dart';
import '../../../shared/widgets/animated_widgets.dart';
import '../../../shared/routes/animated_page_route.dart';
import 'imap_config_page.dart';

/// 邮箱服务商选择页面
///
/// 提供预设邮箱服务商的快速选择功能，以及手动配置入口
class ProviderSelectionPage extends ConsumerWidget {
  const ProviderSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('选择邮箱服务商'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppEdgeInsets.page,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 页面说明
              FadeInWidget(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  '请选择您的邮箱服务商',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              FadeInWidget(
                duration: const Duration(milliseconds: 300),
                delay: const Duration(milliseconds: 50),
                child: Text(
                  '选择预设服务商可自动配置服务器信息',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 服务商网格列表
              Expanded(child: _buildProviderGrid(context, ref)),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建服务商网格列表
  Widget _buildProviderGrid(BuildContext context, WidgetRef ref) {
    // 获取预设服务商列表
    final providers = EmailProviders.all;

    return LayoutBuilder(
      builder: (context, constraints) {
        // 响应式布局：根据屏幕宽度计算列数
        int crossAxisCount = 2;
        if (constraints.maxWidth >= 600) {
          crossAxisCount = 3;
        }
        if (constraints.maxWidth >= 900) {
          crossAxisCount = 4;
        }

        return GridView.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.0,
          children: [
            // 预设服务商卡片
            ...providers.asMap().entries.map(
              (entry) => SlideFadeInWidget(
                duration: const Duration(milliseconds: 300),
                delay: Duration(milliseconds: entry.key * 50),
                offset: const Offset(0, 0.15),
                child: _ProviderCard(
                  provider: entry.value,
                  onTap: () => _onProviderTap(context, ref, entry.value),
                ),
              ),
            ),
            // "其他邮箱"卡片
            SlideFadeInWidget(
              duration: const Duration(milliseconds: 300),
              delay: Duration(milliseconds: providers.length * 50),
              offset: const Offset(0, 0.15),
              child: _OtherProviderCard(
                onTap: () => _onOtherProviderTap(context),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 处理预设服务商点击事件
  ///
  /// 自动填充该服务商的 IMAP 配置，并跳转到 IMAP 配置页面
  void _onProviderTap(
    BuildContext context,
    WidgetRef ref,
    EmailProvider provider,
  ) {
    // 创建预填充的 IMAP 配置（邮箱和密码需要用户输入）
    // id 和 createdAt 会在 ImapConfigPage 保存时生成
    final presetConfig = ImapConfig(
      id: '',
      server: provider.imapServer,
      port: provider.imapPort,
      email: '',
      password: '',
      useSSL: provider.useSSL,
    );

    // 跳转到 IMAP 配置页面，传递预设配置
    PageTransitions.slideFade(context, ImapConfigPage(config: presetConfig));
  }

  /// 处理"其他邮箱"点击事件
  ///
  /// 跳转到手动配置页面
  void _onOtherProviderTap(BuildContext context) {
    // 跳转到 IMAP 配置页面（手动配置模式）
    PageTransitions.slideFade(context, const ImapConfigPage());
  }
}

/// 服务商卡片组件
///
/// 显示单个预设邮箱服务商的卡片
class _ProviderCard extends StatelessWidget {
  const _ProviderCard({required this.provider, required this.onTap});

  final EmailProvider provider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      onTap: onTap,
      child: Container(
        padding: AppEdgeInsets.card,
        decoration: AppDecorations.cardFlat(color: AppColors.cardBackground),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 服务商图标
            Container(
              width: 64,
              height: 64,
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                provider.icon,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // 加载失败时显示备用图标
                  return Icon(
                    Icons.email_outlined,
                    size: 32,
                    color: AppColors.primary,
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // 服务商名称
            Text(
              provider.displayName,
              style: AppTextStyles.titleSmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // 服务商域名
            Text(
              provider.domain ?? '',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// "其他邮箱"卡片组件
///
/// 提供手动配置邮箱的入口
class _OtherProviderCard extends StatelessWidget {
  const _OtherProviderCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      onTap: onTap,
      child: Container(
        padding: AppEdgeInsets.card,
        decoration: AppDecorations.cardFlat(
          color: AppColors.backgroundSecondary.withValues(alpha: 0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 图标
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.add_circle_outline,
                size: 32,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),

            // 标题
            Text(
              '其他邮箱',
              style: AppTextStyles.titleSmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),

            // 说明
            Text(
              '手动配置',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
