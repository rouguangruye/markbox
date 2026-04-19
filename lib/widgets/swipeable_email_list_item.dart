import 'package:flutter/material.dart';

import '../shared/models/email.dart';
import '../shared/themes/app_colors.dart';
import 'email_list_item.dart';

/// 可滑动的邮件列表项组件
///
/// 支持左滑删除，包装了 EmailListItemWidget
class SwipeableEmailListItem extends StatelessWidget {
  /// 邮件数据
  final Email email;

  /// 点击回调
  final VoidCallback? onTap;

  /// 删除确认回调
  /// 返回 true 表示确认删除，false 表示取消
  final Future<bool> Function()? onDeleteConfirm;

  const SwipeableEmailListItem({
    super.key,
    required this.email,
    this.onTap,
    this.onDeleteConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(email.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        // 如果有删除确认回调，调用它
        if (onDeleteConfirm != null) {
          return await onDeleteConfirm!();
        }
        // 默认返回 false，需要外部处理确认逻辑
        return false;
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: AppColors.error,
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      child: EmailListItemWidget(email: email, onTap: onTap),
    );
  }
}
