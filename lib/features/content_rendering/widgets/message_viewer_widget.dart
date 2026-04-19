import 'package:enough_mail/enough_mail.dart';
import 'package:enough_mail_flutter/enough_mail_flutter.dart';
import 'package:flutter/material.dart';

/// 邮件内容渲染组件
///
/// 使用官方 MimeMessageViewer 组件渲染邮件内容。
/// 支持 HTML、纯文本、multipart 等所有邮件格式。
/// 使用 flutter_inappwebview 引擎，性能优于 webview_flutter。
class MessageViewerWidget extends StatelessWidget {
  /// 原始 MIME 消息内容
  final String mimeMessageRaw;

  /// 是否阻止外部图片加载
  final bool blockExternalImages;

  /// 背景色
  final Color? backgroundColor;

  /// 是否可见
  ///
  /// 用于在页面返回动画前隐藏 WebView，避免残影
  final bool isVisible;

  const MessageViewerWidget({
    super.key,
    required this.mimeMessageRaw,
    this.blockExternalImages = false,
    this.backgroundColor,
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    // 解析 MIME 消息
    final mimeMessage = MimeMessage.parseFromText(mimeMessageRaw);

    // 使用 Visibility 包裹，在返回动画前隐藏 WebView
    return Visibility(
      visible: isVisible,
      maintainState: true, // 保持状态，避免重建
      child: Container(
        color: backgroundColor,
        child: MimeMessageViewer(
          mimeMessage: mimeMessage,
          blockExternalImages: blockExternalImages,
        ),
      ),
    );
  }
}
