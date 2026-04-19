import 'package:flutter/material.dart';

import '../shared/models/email.dart';
import '../shared/models/summary_status.dart';
import '../shared/themes/app_colors.dart';
import '../shared/utils/date_utils.dart';

/// 邮件列表项组件
///
/// 用于展示邮件列表中的单个邮件项，包含发件人头像、主题、预览和时间
/// 支持未读邮件的视觉区分
class EmailListItemWidget extends StatelessWidget {
  /// 邮件数据
  final Email email;

  /// 点击回调
  final VoidCallback? onTap;

  const EmailListItemWidget({super.key, required this.email, this.onTap});

  /// 获取发件人显示名称的首字母
  String _getInitials(String displayName) {
    final words = displayName.trim().split(' ');
    if (words.isEmpty) return '?';
    if (words.length == 1) {
      return words[0].isNotEmpty ? words[0][0].toUpperCase() : '?';
    }
    return (words[0][0] + words[1][0]).toUpperCase();
  }

  /// 获取头像背景颜色（根据发件人名称生成一致的颜色）
  Color _getAvatarColor(String senderName) {
    final colors = [
      const Color(0xFF1E88E5), // 蓝色
      const Color(0xFF43A047), // 绿色
      const Color(0xFFFB8C00), // 橙色
      const Color(0xFF8E24AA), // 紫色
      const Color(0xFFE53935), // 红色
      const Color(0xFF00ACC1), // 青色
      const Color(0xFF7CB342), // 浅绿
      const Color(0xFFFF7043), // 深橙
    ];
    final index = senderName.hashCode % colors.length;
    return colors[index.abs()];
  }

  @override
  Widget build(BuildContext context) {
    final isUnread = !email.isRead;

    // 获取发件人显示名称（优先使用 senderName，降级到 senderEmail）
    final senderDisplayName = email.senderName?.isNotEmpty == true
        ? email.senderName!
        : email.senderEmail;

    // 格式化为真实日期时间
    final formattedDate = DateTimeUtils.formatDateTime(email.date);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 发件人头像
            _buildAvatar(senderDisplayName),
            const SizedBox(width: 12),
            // 邮件内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 第一行：发件人 + 时间
                  Row(
                    children: [
                      // 未读圆点
                      if (isUnread) ...[
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.unreadIndicator,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                      // 发件人名称
                      Expanded(
                        child: Text(
                          senderDisplayName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // 时间
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // 第二行：邮件主题
                  Text(
                    email.subject,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // 第三行：摘要或内容预览（如果有）
                  if (_getDisplayContent() != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      _getDisplayContent()!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textTertiary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 获取显示内容
  ///
  /// 根据摘要状态显示不同内容：
  /// - generated: 显示摘要
  /// - 其他状态: 显示预览文本
  String? _getDisplayContent() {
    // 已生成摘要：显示摘要
    if (email.summaryStatus == SummaryStatus.generated &&
        email.summary != null &&
        email.summary!.isNotEmpty) {
      return email.summary;
    }

    // 其他状态：显示预览文本
    if (email.preview != null && email.preview!.isNotEmpty) {
      return email.preview;
    }

    // 降级：使用 body（兼容旧数据）
    if (email.body != null && email.body!.isNotEmpty) {
      return _extractPreviewText(email.body!);
    }
    return null;
  }

  /// 提取预览文本
  ///
  /// 从完整内容中提取简短的预览文本
  String? _extractPreviewText(String content) {
    if (content.isEmpty) return null;

    String text = content;

    // 去除 HTML 标签
    text = text.replaceAll(
      RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false),
      '',
    );

    // 去除 HTML 实体
    text = text.replaceAll('&nbsp;', ' ');
    text = text.replaceAll('&amp;', '&');
    text = text.replaceAll('&lt;', '<');
    text = text.replaceAll('&gt;', '>');
    text = text.replaceAll('&quot;', '"');
    text = text.replaceAll('&#39;', "'");
    text = text.replaceAll(RegExp(r'&#\d+;'), '');

    // 去除多余的空白字符
    text = text.replaceAll(RegExp(r'\s+'), ' ');
    text = text.trim();

    // 截取前 100 个字符
    if (text.length > 100) {
      text = '${text.substring(0, 100)}...';
    }

    return text.isEmpty ? null : text;
  }

  /// 构建发件人头像
  Widget _buildAvatar(String senderDisplayName) {
    final initials = _getInitials(senderDisplayName);
    final avatarColor = _getAvatarColor(senderDisplayName);

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: avatarColor, shape: BoxShape.circle),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
