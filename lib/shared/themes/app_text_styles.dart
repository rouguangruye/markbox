import 'package:flutter/material.dart';

/// 应用文字样式
///
/// 定义应用中使用的所有文字样式，遵循简洁现代的设计理念
class AppTextStyles {
  AppTextStyles._();

  // 标题样式
  static TextStyle headlineLarge = const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static TextStyle headlineMedium = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.3,
    height: 1.3,
  );

  static TextStyle headlineSmall = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.4,
  );

  // 副标题样式
  static TextStyle titleLarge = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  static TextStyle titleMedium = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static TextStyle titleSmall = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.4,
  );

  // 正文样式
  static TextStyle bodyLarge = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static TextStyle bodyMedium = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.25,
    height: 1.5,
  );

  static TextStyle bodySmall = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.4,
    height: 1.5,
  );

  // 标签样式
  static TextStyle labelLarge = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static TextStyle labelMedium = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static TextStyle labelSmall = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
  );

  // 按钮文字样式
  static TextStyle button = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static TextStyle buttonLarge = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static TextStyle buttonSmall = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.4,
  );

  // 说明文字样式
  static TextStyle caption = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.4,
    height: 1.4,
  );

  static TextStyle overline = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    height: 1.4,
  );

  // 代码文字样式（用于 JetBrains Mono 字体）
  static TextStyle code = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
    height: 1.6,
    fontFamily: 'JetBrains Mono',
  );

  static TextStyle codeBold = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    height: 1.6,
    fontFamily: 'JetBrains Mono',
  );
}

/// 文字样式扩展方法
///
/// 提供便捷的文字样式修改方法
extension AppTextStyleExtension on TextStyle {
  /// 设置颜色
  TextStyle withColor(Color color) {
    return copyWith(color: color);
  }

  /// 设置字重
  TextStyle withWeight(FontWeight weight) {
    return copyWith(fontWeight: weight);
  }

  /// 设置大小
  TextStyle withSize(double size) {
    return copyWith(fontSize: size);
  }

  /// 设置行高
  TextStyle withHeight(double height) {
    return copyWith(height: height);
  }

  /// 设置字间距
  TextStyle withLetterSpacing(double spacing) {
    return copyWith(letterSpacing: spacing);
  }
}
