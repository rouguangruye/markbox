import 'package:flutter/material.dart';

/// 应用颜色常量
///
/// 定义应用中使用的所有颜色，遵循纯白克制的设计理念
class AppColors {
  AppColors._();

  // 主色调 - 蓝色系（类似 QQ 邮箱）
  static const Color primary = Color(0xFF1E88E5);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryDark = Color(0xFF1565C0);

  // 背景色
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundSecondary = Color(0xFFF5F5F5);
  static const Color backgroundTertiary = Color(0xFFEEEEEE);

  // 文字颜色
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textTertiary = Color(0xFF9E9E9E);
  static const Color textDisabled = Color(0xFFBDBDBD);

  // 分割线和边框
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderLight = Color(0xFFF0F0F0);

  // 状态颜色
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  static const Color error = Color(0xFFF44336);
  static const Color errorLight = Color(0xFFE57373);
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);

  // 卡片和容器
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardShadow = Color(0x1A000000);
  static const Color surface = Color(0xFFFFFFFF);

  // 图标颜色
  static const Color iconPrimary = Color(0xFF616161);
  static const Color iconSecondary = Color(0xFF9E9E9E);

  // 输入框
  static const Color inputBackground = Color(0xFFFAFAFA);
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color inputBorderFocused = Color(0xFF1E88E5);
  static const Color inputBorderError = Color(0xFFF44336);

  // 按钮颜色
  static const Color buttonPrimary = Color(0xFF1E88E5);
  static const Color buttonPrimaryHover = Color(0xFF1565C0);
  static const Color buttonSecondary = Color(0xFFF5F5F5);
  static const Color buttonSecondaryHover = Color(0xFFEEEEEE);

  // 阴影颜色
  static const Color shadowLight = Color(0x0D000000);
  static const Color shadowMedium = Color(0x1A000000);
  static const Color shadowHeavy = Color(0x29000000);

  // 未读邮件标记
  static const Color unreadIndicator = Color(0xFF1E88E5);
  static const Color unreadBackground = Color(0xFFF5F9FF);

  // 骨架屏颜色
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
}

/// 应用颜色扩展方法
///
/// 提供便捷的颜色访问方法
extension AppColorsExtension on Color {
  /// 将颜色转换为 MaterialColor
  MaterialColor toMaterialColor() {
    return MaterialColor(value, <int, Color>{
      50: withOpacity(0.1),
      100: withOpacity(0.2),
      200: withOpacity(0.3),
      300: withOpacity(0.4),
      400: withOpacity(0.5),
      500: withOpacity(0.6),
      600: withOpacity(0.7),
      700: withOpacity(0.8),
      800: withOpacity(0.9),
      900: this,
    });
  }
}
