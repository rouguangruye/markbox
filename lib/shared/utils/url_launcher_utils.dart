import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// URL 启动器工具类
///
/// 提供安全的外部链接打开功能，包含用户确认对话框
class UrlLauncherUtils {
  UrlLauncherUtils._();

  /// 带确认对话框的 URL 启动
  ///
  /// 显示确认对话框，用户确认后使用默认浏览器打开链接
  /// [context] BuildContext 用于显示对话框
  /// [url] 要打开的 URL
  static Future<void> launchUrlWithConfirmation(
    BuildContext context,
    String? url,
  ) async {
    if (url == null || url.isEmpty) {
      _showErrorSnackBar(context, '链接地址为空');
      return;
    }

    // 验证 URL 格式
    final uri = Uri.tryParse(url);
    if (uri == null || (!uri.hasScheme)) {
      _showErrorSnackBar(context, '无效的链接地址');
      return;
    }

    // 显示确认对话框
    final confirmed = await _showConfirmationDialog(context, url);
    if (confirmed != true) return;

    // 用户确认后打开链接
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  /// 显示确认对话框
  ///
  /// 返回用户是否确认
  static Future<bool?> _showConfirmationDialog(
    BuildContext context,
    String url,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('打开外部链接'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('即将使用默认浏览器打开以下链接：'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                url,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('打开'),
          ),
        ],
      ),
    );
  }

  /// 显示错误提示
  static void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// 直接打开 URL（无确认对话框）
  ///
  /// 用于需要直接打开链接的场景
  static Future<bool> launchUrlDirect(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme) {
      return false;
    }
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
