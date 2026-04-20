import 'package:enough_mail/enough_mail.dart';
import 'package:enough_mail_flutter/enough_mail_flutter.dart';
import 'package:flutter/material.dart';

/// 邮件内容渲染组件
///
/// 使用官方 MimeMessageViewer 组件渲染邮件内容。
/// 支持 HTML、纯文本、multipart 等所有邮件格式。
/// 使用 flutter_inappwebview 引擎，性能优于 webview_flutter。
class MessageViewerWidget extends StatefulWidget {
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

  /// 内容加载完成回调
  final VoidCallback? onContentReady;

  const MessageViewerWidget({
    super.key,
    required this.mimeMessageRaw,
    this.blockExternalImages = false,
    this.backgroundColor,
    this.isVisible = true,
    this.onContentReady,
  });

  @override
  State<MessageViewerWidget> createState() => _MessageViewerWidgetState();
}

class _MessageViewerWidgetState extends State<MessageViewerWidget> {
  /// WebView 控制器
  InAppWebViewController? _controller;

  /// 是否已经通知内容加载完成
  bool _hasNotifiedReady = false;

  @override
  void dispose() {
    _controller = null;
    super.dispose();
  }

  /// 处理 WebView 创建
  void _onWebViewCreated(InAppWebViewController controller) {
    _controller = controller;
    // 使用定时器检查加载状态
    _checkLoadingStatus();
  }

  /// 检查加载状态
  ///
  /// 由于 MimeMessageViewer 没有暴露 onLoadStop 回调，
  /// 我们需要通过定时器检查 WebView 的加载状态
  void _checkLoadingStatus() {
    Future.delayed(const Duration(milliseconds: 100), () async {
      if (!mounted || _hasNotifiedReady) return;

      final controller = _controller;
      if (controller == null) {
        _checkLoadingStatus();
        return;
      }

      try {
        // 检查 WebView 是否正在加载
        final isLoading = await controller.isLoading();
        if (!isLoading) {
          // 加载完成，通知父组件
          setState(() {
            _hasNotifiedReady = true;
          });
          widget.onContentReady?.call();
        } else {
          // 继续检查
          _checkLoadingStatus();
        }
      } catch (e) {
        // 忽略错误，继续检查
        _checkLoadingStatus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 解析 MIME 消息
    final mimeMessage = MimeMessage.parseFromText(widget.mimeMessageRaw);

    // 使用 Visibility 包裹，在返回动画前隐藏 WebView
    return Visibility(
      visible: widget.isVisible,
      maintainState: true, // 保持状态，避免重建
      child: Container(
        color: widget.backgroundColor,
        child: MimeMessageViewer(
          mimeMessage: mimeMessage,
          blockExternalImages: widget.blockExternalImages,
          onWebViewCreated: _onWebViewCreated,
        ),
      ),
    );
  }
}
