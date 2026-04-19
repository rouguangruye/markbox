import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';

/// 应用装饰样式
///
/// 定义应用中使用的各种装饰样式，遵循简洁现代的设计理念
class AppDecorations {
  AppDecorations._();

  // 卡片装饰
  static BoxDecoration card({
    Color? color,
    BorderRadius? borderRadius,
    BoxBorder? border,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: color ?? AppColors.cardBackground,
      borderRadius:
          borderRadius ?? BorderRadius.circular(AppSizes.radiusMedium),
      border: border,
      boxShadow: boxShadow ?? [AppShadows.card],
    );
  }

  static BoxDecoration cardFlat({
    Color? color,
    BorderRadius? borderRadius,
    BoxBorder? border,
  }) {
    return BoxDecoration(
      color: color ?? AppColors.cardBackground,
      borderRadius:
          borderRadius ?? BorderRadius.circular(AppSizes.radiusMedium),
      border:
          border ??
          Border.all(color: AppColors.border, width: AppSizes.borderWidth),
    );
  }

  // 输入框装饰
  static InputDecoration input({
    String? labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? fillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: fillColor ?? AppColors.inputBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        borderSide: BorderSide(color: borderColor ?? AppColors.inputBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        borderSide: BorderSide(color: borderColor ?? AppColors.inputBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        borderSide: BorderSide(
          color: focusedBorderColor ?? AppColors.inputBorderFocused,
          width: AppSizes.borderWidthThick,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        borderSide: BorderSide(
          color: errorBorderColor ?? AppColors.inputBorderError,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        borderSide: BorderSide(
          color: errorBorderColor ?? AppColors.inputBorderError,
          width: AppSizes.borderWidthThick,
        ),
      ),
      contentPadding: AppEdgeInsets.input,
    );
  }

  // 按钮装饰
  static BoxDecoration button({
    Color? color,
    BorderRadius? borderRadius,
    BoxBorder? border,
  }) {
    return BoxDecoration(
      color: color ?? AppColors.buttonPrimary,
      borderRadius:
          borderRadius ?? BorderRadius.circular(AppSizes.radiusMedium),
      border: border,
    );
  }

  static BoxDecoration buttonOutlined({
    Color? borderColor,
    BorderRadius? borderRadius,
  }) {
    return BoxDecoration(
      color: Colors.transparent,
      borderRadius:
          borderRadius ?? BorderRadius.circular(AppSizes.radiusMedium),
      border: Border.all(
        color: borderColor ?? AppColors.primary,
        width: AppSizes.borderWidth,
      ),
    );
  }

  // 图标容器装饰
  static BoxDecoration iconContainer({
    Color? color,
    BorderRadius? borderRadius,
    BoxBorder? border,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: color ?? AppColors.backgroundSecondary,
      borderRadius:
          borderRadius ?? BorderRadius.circular(AppSizes.radiusMedium),
      border: border,
      boxShadow: boxShadow,
    );
  }

  // 分隔线装饰
  static BoxDecoration divider({Color? color, double? thickness}) {
    return BoxDecoration(
      color: color ?? AppColors.divider,
      border: Border(
        bottom: BorderSide(
          color: color ?? AppColors.divider,
          width: thickness ?? AppSizes.dividerThickness,
        ),
      ),
    );
  }

  // 标签装饰
  static BoxDecoration badge({Color? color, BorderRadius? borderRadius}) {
    return BoxDecoration(
      color: color ?? AppColors.primary,
      borderRadius: borderRadius ?? BorderRadius.circular(AppSizes.radiusRound),
    );
  }

  // 骨架屏装饰
  static BoxDecoration shimmer({Color? color, BorderRadius? borderRadius}) {
    return BoxDecoration(
      color: color ?? AppColors.shimmerBase,
      borderRadius: borderRadius ?? BorderRadius.circular(AppSizes.radiusSmall),
    );
  }
}

/// 应用阴影
///
/// 定义应用中使用的各种阴影效果
class AppShadows {
  AppShadows._();

  // 轻微阴影（用于卡片）
  static BoxShadow get card => BoxShadow(
    color: AppColors.shadowLight,
    blurRadius: 8,
    spreadRadius: 0,
    offset: const Offset(0, 2),
  );

  // 中等阴影（用于浮动元素）
  static BoxShadow get floating => BoxShadow(
    color: AppColors.shadowMedium,
    blurRadius: 16,
    spreadRadius: 0,
    offset: const Offset(0, 4),
  );

  // 深度阴影（用于对话框）
  static BoxShadow get dialog => BoxShadow(
    color: AppColors.shadowHeavy,
    blurRadius: 24,
    spreadRadius: 0,
    offset: const Offset(0, 8),
  );

  // 按钮阴影
  static BoxShadow button({Color? color}) => BoxShadow(
    color: color ?? AppColors.shadowLight,
    blurRadius: 4,
    spreadRadius: 0,
    offset: const Offset(0, 2),
  );

  // 图标容器阴影
  static BoxShadow iconContainer({Color? color}) => BoxShadow(
    color: color ?? AppColors.shadowLight,
    blurRadius: 12,
    spreadRadius: 0,
    offset: const Offset(0, 4),
  );
}

/// 应用圆角
///
/// 提供便捷的 BorderRadius 创建方法
class AppRadius {
  AppRadius._();

  static BorderRadius get small => BorderRadius.circular(AppSizes.radiusSmall);
  static BorderRadius get medium =>
      BorderRadius.circular(AppSizes.radiusMedium);
  static BorderRadius get large => BorderRadius.circular(AppSizes.radiusLarge);
  static BorderRadius get xLarge =>
      BorderRadius.circular(AppSizes.radiusXLarge);
  static BorderRadius get round => BorderRadius.circular(AppSizes.radiusRound);

  // 自定义圆角
  static BorderRadius custom(double radius) => BorderRadius.circular(radius);

  // 只有顶部圆角
  static BorderRadius get topSmall =>
      BorderRadius.vertical(top: Radius.circular(AppSizes.radiusSmall));
  static BorderRadius get topMedium =>
      BorderRadius.vertical(top: Radius.circular(AppSizes.radiusMedium));
  static BorderRadius get topLarge =>
      BorderRadius.vertical(top: Radius.circular(AppSizes.radiusLarge));

  // 只有底部圆角
  static BorderRadius get bottomSmall =>
      BorderRadius.vertical(bottom: Radius.circular(AppSizes.radiusSmall));
  static BorderRadius get bottomMedium =>
      BorderRadius.vertical(bottom: Radius.circular(AppSizes.radiusMedium));
  static BorderRadius get bottomLarge =>
      BorderRadius.vertical(bottom: Radius.circular(AppSizes.radiusLarge));
}
