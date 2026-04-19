import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../utils/animations.dart';

/// 淡入动画组件
///
/// 子组件在首次构建时自动执行淡入动画
class FadeInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration delay;

  const FadeInWidget({
    super.key,
    required this.child,
    this.duration = AppAnimations.fadeInDuration,
    this.curve = AppAnimations.fadeInCurve,
    this.delay = Duration.zero,
  });

  @override
  State<FadeInWidget> createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.child);
  }
}

/// 滑动淡入动画组件
///
/// 子组件在首次构建时自动执行滑动 + 淡入动画
class SlideFadeInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration delay;
  final Offset offset;

  const SlideFadeInWidget({
    super.key,
    required this.child,
    this.duration = AppAnimations.listItemDuration,
    this.curve = AppAnimations.listItemCurve,
    this.delay = Duration.zero,
    this.offset = AppAnimations.slideUpOffset,
  });

  @override
  State<SlideFadeInWidget> createState() => _SlideFadeInWidgetState();
}

class _SlideFadeInWidgetState extends State<SlideFadeInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: widget.curve);
    _slideAnimation = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(opacity: _fadeAnimation, child: widget.child),
    );
  }
}

/// 缩放动画组件
///
/// 子组件在首次构建时自动执行缩放动画
class ScaleInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration delay;
  final double beginScale;

  const ScaleInWidget({
    super.key,
    required this.child,
    this.duration = AppAnimations.durationNormal,
    this.curve = AppAnimations.curveDefault,
    this.delay = Duration.zero,
    this.beginScale = 0.8,
  });

  @override
  State<ScaleInWidget> createState() => _ScaleInWidgetState();
}

class _ScaleInWidgetState extends State<ScaleInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(
      begin: widget.beginScale,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _animation, child: widget.child);
  }
}

/// 按钮交互动画组件
///
/// 为按钮添加按下缩放效果
class AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Duration duration;
  final double scalePressed;

  const AnimatedButton({
    super.key,
    required this.child,
    this.onPressed,
    this.duration = AppAnimations.buttonDuration,
    this.scalePressed = AppAnimations.buttonScalePressed,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.scalePressed)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: AppAnimations.buttonCurve,
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onPressed?.call();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onPressed != null ? _onTapDown : null,
      onTapUp: widget.onPressed != null ? _onTapUp : null,
      onTapCancel: widget.onPressed != null ? _onTapCancel : null,
      child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
    );
  }
}

/// 卡片交互动画组件
///
/// 为卡片添加悬停和点击效果
class AnimatedCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Duration duration;
  final double scalePressed;
  final bool enableHover;

  const AnimatedCard({
    super.key,
    required this.child,
    this.onTap,
    this.duration = AppAnimations.cardDuration,
    this.scalePressed = AppAnimations.cardScalePressed,
    this.enableHover = true,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.scalePressed)
        .animate(
          CurvedAnimation(parent: _controller, curve: AppAnimations.cardCurve),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap?.call();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  void _onHoverChanged(bool isHovered) {
    if (widget.enableHover) {
      setState(() {
        _isHovered = isHovered;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHoverChanged(true),
      onExit: (_) => _onHoverChanged(false),
      child: GestureDetector(
        onTapDown: widget.onTap != null ? _onTapDown : null,
        onTapUp: widget.onTap != null ? _onTapUp : null,
        onTapCancel: widget.onTap != null ? _onTapCancel : null,
        child: AnimatedContainer(
          duration: widget.duration,
          curve: AppAnimations.cardCurve,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -2.0 : 0.0),
          decoration: BoxDecoration(
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.shadowMedium,
                      blurRadius: 12,
                      spreadRadius: 0,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
        ),
      ),
    );
  }
}

/// 骨架屏组件
///
/// 用于加载状态时显示占位内容
class ShimmerLoading extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerLoading({
    super.key,
    this.width = double.infinity,
    this.height = 16.0,
    this.borderRadius = 8.0,
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.shimmerBase,
                AppColors.shimmerHighlight,
                AppColors.shimmerBase,
              ],
              stops: [0.0, 0.5, 1.0],
              transform: _SlidingGradientTransform(
                slidePercent: _animation.value,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 滑动渐变变换
class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
