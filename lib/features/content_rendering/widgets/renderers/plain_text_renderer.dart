import 'package:flutter/material.dart';

/// 纯文本渲染器组件
///
/// 用于渲染纯文本内容，支持文本选择、等宽字体显示和垂直滚动
/// 主要用于显示代码、日志等需要保留格式的文本内容
/// 包含异常捕获，确保渲染稳定性
class PlainTextRenderer extends StatelessWidget {
  /// 要渲染的文本内容
  final String content;

  /// 字体大小，默认为 14
  final double fontSize;

  /// 行高倍数，默认为 1.5
  final double lineHeight;

  /// 文字颜色，默认为白色 (#FFFFFF)
  final Color textColor;

  /// 背景色，默认为深色 (#1E1E1E)
  final Color backgroundColor;

  /// 内边距，默认为 16.0
  final EdgeInsets padding;

  const PlainTextRenderer({
    super.key,
    required this.content,
    this.fontSize = 14.0,
    this.lineHeight = 1.5,
    this.textColor = const Color(0xFFFFFFFF),
    this.backgroundColor = const Color(0xFF1E1E1E),
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    try {
      // 使用 SingleChildScrollView 实现垂直滚动
      return Container(
        color: backgroundColor,
        child: SingleChildScrollView(
          // 垂直滚动
          scrollDirection: Axis.vertical,
          // 使用 SelectableText 支持文本选择
          child: Padding(
            padding: padding,
            child: SelectableText(
              content,
              style: TextStyle(
                // 使用 JetBrains Mono 等宽字体
                fontFamily: 'JetBrains Mono',
                fontSize: fontSize,
                // 行高通过 height 属性设置，值为字体大小的倍数
                height: lineHeight,
                color: textColor,
              ),
            ),
          ),
        ),
      );
    } catch (e) {
      // 捕获异常，返回错误提示
      debugPrint('纯文本渲染失败: $e');
      return _buildErrorWidget(e.toString());
    }
  }

  /// 构建错误提示组件
  ///
  /// 当纯文本渲染失败时显示错误信息
  Widget _buildErrorWidget(String errorMessage) {
    return Container(
      color: backgroundColor,
      padding: padding,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 16),
            Text('文本渲染失败', style: TextStyle(fontSize: 16, color: textColor)),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: TextStyle(
                fontSize: 12,
                color: textColor.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
