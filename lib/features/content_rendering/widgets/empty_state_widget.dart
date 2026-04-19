import 'package:flutter/material.dart';

/// 统一的空状态提示组件
///
/// 用于显示无内容、加载初始状态等空状态的界面
/// 支持自定义图标、标题、描述和操作按钮
class EmptyStateWidget extends StatelessWidget {
  /// 标题文本
  final String title;

  /// 描述文本（可选）
  final String? description;

  /// 图标，默认为 inbox_outlined
  final IconData icon;

  /// 图标大小，默认为 64
  final double iconSize;

  /// 操作按钮回调（可选）
  final VoidCallback? onAction;

  /// 操作按钮文本（可选）
  final String? actionText;

  /// 背景色（可选）
  final Color? backgroundColor;

  /// 创建空状态组件
  const EmptyStateWidget({
    super.key,
    this.title = '暂无内容',
    this.description,
    this.icon = Icons.inbox_outlined,
    this.iconSize = 64,
    this.onAction,
    this.actionText,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final disabledColor = theme.disabledColor;

    return Container(
      color: backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 图标
            Icon(icon, size: iconSize, color: disabledColor),
            const SizedBox(height: 16),
            // 标题
            Text(title, style: TextStyle(fontSize: 16, color: disabledColor)),
            // 描述（可选）
            if (description != null) ...[
              const SizedBox(height: 8),
              Text(
                description!,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledColor.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
            // 操作按钮（可选）
            if (onAction != null && actionText != null) ...[
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.refresh),
                label: Text(actionText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 空状态类型枚举
enum EmptyStateType {
  /// 无内容
  noContent,

  /// 等待加载
  waitingLoad,

  /// 无搜索结果
  noSearchResult,

  /// 无数据
  noData,
}

/// 扩展方法：根据空状态类型获取配置
extension EmptyStateTypeExtension on EmptyStateType {
  /// 获取标题
  String get title {
    switch (this) {
      case EmptyStateType.noContent:
        return '内容为空';
      case EmptyStateType.waitingLoad:
        return '等待内容加载';
      case EmptyStateType.noSearchResult:
        return '未找到相关内容';
      case EmptyStateType.noData:
        return '暂无数据';
    }
  }

  /// 获取描述
  String? get description {
    switch (this) {
      case EmptyStateType.noContent:
        return null;
      case EmptyStateType.waitingLoad:
        return '请稍候...';
      case EmptyStateType.noSearchResult:
        return '尝试其他关键词';
      case EmptyStateType.noData:
        return null;
    }
  }

  /// 获取图标
  IconData get icon {
    switch (this) {
      case EmptyStateType.noContent:
        return Icons.inbox_outlined;
      case EmptyStateType.waitingLoad:
        return Icons.description_outlined;
      case EmptyStateType.noSearchResult:
        return Icons.search_off_outlined;
      case EmptyStateType.noData:
        return Icons.folder_open_outlined;
    }
  }
}
