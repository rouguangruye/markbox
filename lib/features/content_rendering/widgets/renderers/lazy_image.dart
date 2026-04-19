import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 延迟加载图片组件
///
/// 支持图片延迟加载、缓存和占位符显示
/// 用于优化包含大量图片的内容渲染性能
class LazyImage extends StatelessWidget {
  /// 图片 URL
  final String imageUrl;

  /// 图片宽度
  final double? width;

  /// 图片高度
  final double? height;

  /// 是否适应容器
  final BoxFit fit;

  /// 占位符组件
  final Widget? placeholder;

  /// 错误组件
  final Widget? errorWidget;

  /// 图片边框圆角
  final BorderRadius? borderRadius;

  /// 创建延迟加载图片组件
  const LazyImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
  });

  /// 判断是否为 base64 图片
  bool get _isBase64Image =>
      imageUrl.startsWith('data:image/') && imageUrl.contains('base64,');

  /// 判断是否为网络图片
  bool get _isNetworkImage =>
      imageUrl.startsWith('http://') || imageUrl.startsWith('https://');

  /// 解析 base64 图片数据
  Uint8List? _parseBase64Image() {
    try {
      // 格式: data:image/png;base64,xxxxx
      final base64Start = imageUrl.indexOf('base64,');
      if (base64Start == -1) return null;

      final base64String = imageUrl.substring(base64Start + 7);
      return base64Decode(base64String);
    } catch (e) {
      debugPrint('Base64 图片解析失败: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (_isBase64Image) {
      // Base64 图片
      final bytes = _parseBase64Image();
      if (bytes != null) {
        imageWidget = Image.memory(
          bytes,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) =>
              errorWidget ?? _buildDefaultErrorWidget(error),
        );
      } else {
        imageWidget = errorWidget ?? _buildDefaultErrorWidget('解析失败');
      }
    } else if (_isNetworkImage) {
      // 网络图片使用 CachedNetworkImage
      imageWidget = CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) =>
            placeholder ?? _buildDefaultPlaceholder(),
        errorWidget: (context, url, error) =>
            errorWidget ?? _buildDefaultErrorWidget(error),
        fadeInDuration: const Duration(milliseconds: 300),
        fadeOutDuration: const Duration(milliseconds: 300),
        memCacheWidth: width != null ? (width! * 2).toInt() : null,
        memCacheHeight: height != null ? (height! * 2).toInt() : null,
      );
    } else {
      // 其他情况（如相对路径、cid: 等）尝试作为网络图片加载
      imageWidget = Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return placeholder ?? _buildDefaultPlaceholder();
        },
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? _buildDefaultErrorWidget(error),
      );
    }

    // 如果有圆角，添加 ClipRRect
    if (borderRadius != null) {
      imageWidget = ClipRRect(borderRadius: borderRadius!, child: imageWidget);
    }

    return imageWidget;
  }

  /// 构建默认占位符
  Widget _buildDefaultPlaceholder() {
    return Container(
      width: width,
      height: height ?? 200,
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: borderRadius,
      ),
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white54),
        ),
      ),
    );
  }

  /// 构建默认错误组件
  Widget _buildDefaultErrorWidget(Object error) {
    return Container(
      width: width,
      height: height ?? 200,
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: borderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image_outlined,
            size: 48,
            color: Colors.white.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 8),
          Text(
            '图片加载失败',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

/// 延迟加载图片构建器
///
/// 用于 Markdown 和 HTML 渲染器中的图片延迟加载
class LazyImageBuilder {
  /// 构建延迟加载图片
  ///
  /// [uri] 图片 URI
  /// [title] 图片标题
  /// [alt] 图片替代文本
  /// 返回延迟加载的图片组件
  static Widget build({
    required String uri,
    String? title,
    String? alt,
    double? width,
    double? height,
  }) {
    return LazyImage(
      imageUrl: uri,
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(8),
    );
  }
}
