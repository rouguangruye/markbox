import 'package:flutter/material.dart';

/// 统一的错误 UI 组件
///
/// 用于显示渲染错误、解析失败等异常情况的界面
/// 支持自定义错误信息、图标和重试操作
class RenderErrorWidget extends StatelessWidget {
  /// 错误信息
  final String? message;

  /// 错误图标，默认为 error_outline
  final IconData icon;

  /// 图标大小，默认为 64
  final double iconSize;

  /// 重试按钮回调（可选）
  final VoidCallback? onRetry;

  /// 重试按钮文本，默认为"重试"
  final String retryText;

  /// 背景色（可选）
  final Color? backgroundColor;

  /// 是否显示重试按钮，默认为 true
  final bool showRetryButton;

  /// 创建错误组件
  const RenderErrorWidget({
    super.key,
    this.message,
    this.icon = Icons.error_outline,
    this.iconSize = 64,
    this.onRetry,
    this.retryText = '重试',
    this.backgroundColor,
    this.showRetryButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorColor = theme.colorScheme.error;
    final disabledColor = theme.disabledColor;

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 错误图标
            Icon(icon, size: iconSize, color: errorColor),
            const SizedBox(height: 16),
            // 错误标题
            Text(
              '渲染失败',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: errorColor,
              ),
            ),
            // 错误信息（可选）
            if (message != null) ...[
              const SizedBox(height: 8),
              Text(
                message!,
                style: TextStyle(fontSize: 14, color: disabledColor),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            // 重试按钮（可选）
            if (showRetryButton && onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(retryText),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 渲染错误类型枚举
enum RenderErrorType {
  /// 解析错误
  parseError,

  /// 渲染错误
  renderError,

  /// 网络错误
  networkError,

  /// 未知错误
  unknownError,
}

/// 扩展方法：根据错误类型获取错误信息
extension RenderErrorTypeExtension on RenderErrorType {
  /// 获取错误提示信息
  String get errorMessage {
    switch (this) {
      case RenderErrorType.parseError:
        return '内容解析失败';
      case RenderErrorType.renderError:
        return '内容渲染失败';
      case RenderErrorType.networkError:
        return '网络连接失败';
      case RenderErrorType.unknownError:
        return '未知错误';
    }
  }

  /// 获取错误图标
  IconData get icon {
    switch (this) {
      case RenderErrorType.parseError:
        return Icons.broken_image_outlined;
      case RenderErrorType.renderError:
        return Icons.error_outline;
      case RenderErrorType.networkError:
        return Icons.wifi_off_outlined;
      case RenderErrorType.unknownError:
        return Icons.help_outline;
    }
  }
}
