import 'package:flutter/material.dart';

/// 应用动画常量
///
/// 定义应用中使用的动画时长和缓动曲线
class AppAnimations {
  AppAnimations._();

  // 动画时长
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 200);
  static const Duration durationSlow = Duration(milliseconds: 300);
  static const Duration durationVerySlow = Duration(milliseconds: 500);

  // 缓动曲线
  static const Curve curveDefault = Curves.easeInOut;
  static const Curve curveEaseIn = Curves.easeIn;
  static const Curve curveEaseOut = Curves.easeOut;
  static const Curve curveEaseInOut = Curves.easeInOut;
  static const Curve curveFastOutSlowIn = Curves.fastOutSlowIn;
  static const Curve curveLinearToEaseOut = Curves.linearToEaseOut;
  static const Curve curveEaseInToLinear = Curves.easeInToLinear;
  static const Curve curveDecelerate = Curves.decelerate;
  static const Curve curveBounceOut = Curves.bounceOut;
  static const Curve curveElasticOut = Curves.elasticOut;

  // 页面转场动画配置
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);
  static const Curve pageTransitionCurve = Curves.easeInOut;

  // 列表项动画配置
  static const Duration listItemDuration = Duration(milliseconds: 200);
  static const Curve listItemCurve = Curves.easeOut;
  static const Duration listItemStaggerDelay = Duration(milliseconds: 50);

  // 按钮动画配置
  static const Duration buttonDuration = Duration(milliseconds: 150);
  static const Curve buttonCurve = Curves.easeInOut;
  static const double buttonScalePressed = 0.98;

  // 输入框动画配置
  static const Duration inputDuration = Duration(milliseconds: 200);
  static const Curve inputCurve = Curves.easeInOut;

  // 卡片动画配置
  static const Duration cardDuration = Duration(milliseconds: 200);
  static const Curve cardCurve = Curves.easeOut;
  static const double cardScalePressed = 0.98;
  static const double cardElevationHover = 4.0;
  static const double cardElevationNormal = 0.0;

  // 淡入淡出动画配置
  static const Duration fadeInDuration = Duration(milliseconds: 200);
  static const Duration fadeOutDuration = Duration(milliseconds: 150);
  static const Curve fadeInCurve = Curves.easeIn;
  static const Curve fadeOutCurve = Curves.easeOut;

  // 滑动动画配置
  static const Offset slideUpOffset = Offset(0, 0.1);
  static const Offset slideDownOffset = Offset(0, -0.1);
  static const Offset slideLeftOffset = Offset(0.1, 0);
  static const Offset slideRightOffset = Offset(-0.1, 0);
}

/// 动画工具方法
///
/// 提供常用的动画创建方法
class AnimationUtils {
  AnimationUtils._();

  /// 创建淡入动画
  static Animation<double> createFadeInAnimation(
    AnimationController controller, {
    Curve curve = AppAnimations.curveDefault,
  }) {
    return CurvedAnimation(parent: controller, curve: curve);
  }

  /// 创建滑动动画
  static Animation<Offset> createSlideAnimation(
    AnimationController controller, {
    Offset begin = Offset.zero,
    Offset end = const Offset(0, 0.1),
    Curve curve = AppAnimations.curveDefault,
  }) {
    return Tween<Offset>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(parent: controller, curve: curve));
  }

  /// 创建缩放动画
  static Animation<double> createScaleAnimation(
    AnimationController controller, {
    double begin = 0.0,
    double end = 1.0,
    Curve curve = AppAnimations.curveDefault,
  }) {
    return Tween<double>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(parent: controller, curve: curve));
  }

  /// 创建交错动画
  ///
  /// [index] 列表项索引
  /// [totalItems] 总项数
  /// [controller] 动画控制器
  /// [itemDuration] 单个项的动画时长
  /// [staggerDelay] 交错延迟
  static Animation<double> createStaggeredAnimation({
    required int index,
    required AnimationController controller,
    Duration itemDuration = AppAnimations.listItemDuration,
    Duration staggerDelay = AppAnimations.listItemStaggerDelay,
  }) {
    final delay = staggerDelay.inMilliseconds * index;
    final start = delay / controller.duration!.inMilliseconds;
    final end =
        (delay + itemDuration.inMilliseconds) /
        controller.duration!.inMilliseconds;

    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          start.clamp(0.0, 1.0),
          end.clamp(0.0, 1.0),
          curve: AppAnimations.listItemCurve,
        ),
      ),
    );
  }

  /// 创建抖动动画（用于错误提示）
  static Animation<double> createShakeAnimation(
    AnimationController controller, {
    double amplitude = 10.0,
  }) {
    return TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: amplitude,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: amplitude,
          end: -amplitude,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: -amplitude,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 25,
      ),
    ]).animate(controller);
  }
}

/// 动画状态混入
///
/// 为 StatefulWidget 提供动画状态管理
mixin AnimationStateMixin<T extends StatefulWidget>
    on State<T>, SingleTickerProviderStateMixin<T> {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: AppAnimations.durationNormal,
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: AppAnimations.curveDefault,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  /// 启动动画
  void startAnimation() {
    animationController.forward();
  }

  /// 反向动画
  void reverseAnimation() {
    animationController.reverse();
  }

  /// 重置动画
  void resetAnimation() {
    animationController.reset();
  }

  /// 重复动画
  void repeatAnimation() {
    animationController.repeat();
  }
}
