import 'package:flutter/material.dart';
import '../utils/animations.dart';

/// 淡入淡出页面转场
///
/// 类似 iOS 风格的页面转场动画
class FadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final Duration duration;
  final Curve curve;

  FadePageRoute({
    required this.page,
    this.duration = AppAnimations.pageTransitionDuration,
    this.curve = AppAnimations.pageTransitionCurve,
    super.settings,
    super.fullscreenDialog,
    super.allowSnapshotting,
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionDuration: duration,
         reverseTransitionDuration: duration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           return FadeTransition(
             opacity: CurvedAnimation(parent: animation, curve: curve),
             child: child,
           );
         },
       );
}

/// 滑动淡入页面转场
///
/// 页面从右侧滑入并淡入
/// 使用 allowSnapshotting 避免返回动画时 WebView 销毁导致的残影
class SlideFadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final Duration duration;
  final Duration reverseDuration;
  final Curve curve;
  final Offset beginOffset;

  SlideFadePageRoute({
    required this.page,
    this.duration = AppAnimations.pageTransitionDuration,
    this.reverseDuration = const Duration(milliseconds: 300),
    this.curve = AppAnimations.pageTransitionCurve,
    this.beginOffset = const Offset(0.1, 0),
    super.settings,
    super.fullscreenDialog,
    super.allowSnapshotting = true, // 默认启用快照，避免 WebView 返回残影
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionDuration: duration,
         reverseTransitionDuration: reverseDuration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           final fadeAnimation = CurvedAnimation(
             parent: animation,
             curve: curve,
           );
           final slideAnimation = Tween<Offset>(
             begin: beginOffset,
             end: Offset.zero,
           ).animate(CurvedAnimation(parent: animation, curve: curve));

           return SlideTransition(
             position: slideAnimation,
             child: FadeTransition(opacity: fadeAnimation, child: child),
           );
         },
       );
}

/// 缩放淡入页面转场
///
/// 页面从小到大缩放并淡入
class ScaleFadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final Duration duration;
  final Curve curve;
  final double beginScale;

  ScaleFadePageRoute({
    required this.page,
    this.duration = AppAnimations.pageTransitionDuration,
    this.curve = AppAnimations.pageTransitionCurve,
    this.beginScale = 0.95,
    super.settings,
    super.fullscreenDialog,
    super.allowSnapshotting,
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionDuration: duration,
         reverseTransitionDuration: duration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           final fadeAnimation = CurvedAnimation(
             parent: animation,
             curve: curve,
           );
           final scaleAnimation = Tween<double>(
             begin: beginScale,
             end: 1.0,
           ).animate(CurvedAnimation(parent: animation, curve: curve));

           return ScaleTransition(
             scale: scaleAnimation,
             child: FadeTransition(opacity: fadeAnimation, child: child),
           );
         },
       );
}

/// 底部滑入页面转场
///
/// 页面从底部滑入（类似模态对话框）
class BottomSlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final Duration duration;
  final Curve curve;

  BottomSlidePageRoute({
    required this.page,
    this.duration = AppAnimations.pageTransitionDuration,
    this.curve = AppAnimations.pageTransitionCurve,
    super.settings,
    super.fullscreenDialog,
    super.allowSnapshotting,
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionDuration: duration,
         reverseTransitionDuration: duration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           final slideAnimation = Tween<Offset>(
             begin: const Offset(0, 1),
             end: Offset.zero,
           ).animate(CurvedAnimation(parent: animation, curve: curve));

           return SlideTransition(position: slideAnimation, child: child);
         },
       );
}

/// 页面转场工具类
///
/// 提供便捷的页面转场导航方法
class PageTransitions {
  PageTransitions._();

  /// 淡入淡出转场导航
  static Future<T?> fade<T>(
    BuildContext context,
    Widget page, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
  }) {
    return Navigator.of(context).push<T>(
      FadePageRoute<T>(
        page: page,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  /// 滑动淡入转场导航
  static Future<T?> slideFade<T>(
    BuildContext context,
    Widget page, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
    Offset beginOffset = const Offset(0.1, 0),
  }) {
    return Navigator.of(context).push<T>(
      SlideFadePageRoute<T>(
        page: page,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
        beginOffset: beginOffset,
      ),
    );
  }

  /// 缩放淡入转场导航
  static Future<T?> scaleFade<T>(
    BuildContext context,
    Widget page, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
    double beginScale = 0.95,
  }) {
    return Navigator.of(context).push<T>(
      ScaleFadePageRoute<T>(
        page: page,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
        beginScale: beginScale,
      ),
    );
  }

  /// 底部滑入转场导航
  static Future<T?> bottomSlide<T>(
    BuildContext context,
    Widget page, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
  }) {
    return Navigator.of(context).push<T>(
      BottomSlidePageRoute<T>(
        page: page,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  /// 替换当前页面（淡入淡出）
  static Future<T?> fadeReplacement<T, TO extends Object?>(
    BuildContext context,
    Widget page, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
    TO? result,
  }) {
    return Navigator.of(context).pushReplacement<T, TO>(
      FadePageRoute<T>(
        page: page,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
      ),
      result: result,
    );
  }

  /// 替换当前页面（滑动淡入）
  static Future<T?> slideFadeReplacement<T, TO extends Object?>(
    BuildContext context,
    Widget page, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
    TO? result,
    Offset beginOffset = const Offset(0.1, 0),
  }) {
    return Navigator.of(context).pushReplacement<T, TO>(
      SlideFadePageRoute<T>(
        page: page,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
        beginOffset: beginOffset,
      ),
      result: result,
    );
  }
}
