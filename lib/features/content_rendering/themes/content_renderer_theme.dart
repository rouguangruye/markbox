import 'package:flutter/material.dart';

/// 内容渲染器深色主题配置
///
/// 提供统一的深色主题颜色配置，用于 Markdown、HTML 和纯文本渲染器
/// 确保所有渲染器使用一致的颜色方案
class ContentRendererTheme {
  // ==================== 背景颜色 ====================

  /// 主背景色 - 深色主题基础背景
  /// 用于渲染器的主容器背景
  static const Color backgroundColor = Color(0xFF1E1E1E);

  /// 代码块背景色
  /// 用于行内代码和代码块的背景
  static const Color codeBackgroundColor = Color(0xFF2D2D2D);

  /// 代码块 Atom One Dark 背景色
  /// 用于语法高亮代码块的背景
  static const Color codeBlockAtomBackground = Color(0xFF282C34);

  /// 表格背景色
  /// 用于表格行的背景
  static const Color tableBackgroundColor = Color(0xFF252525);

  /// 表格表头背景色
  /// 用于表格标题行的背景
  static const Color tableHeaderBackgroundColor = Color(0xFF2A2A2A);

  /// 引用块背景色
  /// 用于 blockquote 的背景
  static const Color blockquoteBackgroundColor = Color(0xFF1E1E1E);

  // ==================== 文字颜色 ====================

  /// 主文字颜色 - 白色
  /// 用于标题、强调文本等重要内容
  static const Color textPrimary = Colors.white;

  /// 次要文字颜色 - 70% 不透明度白色
  /// 用于正文、列表项等常规内容
  static const Color textSecondary = Colors.white70;

  /// 辅助文字颜色 - 60% 不透明度白色
  /// 用于引用块、次要说明等
  static const Color textTertiary = Colors.white60;

  /// 禁用文字颜色 - 54% 不透明度白色
  /// 用于删除线、禁用状态等
  static const Color textDisabled = Colors.white54;

  /// 占位文字颜色 - 38% 不透明度白色
  /// 用于提示文字、占位符等
  static const Color textHint = Colors.white38;

  // ==================== 链接颜色 ====================

  /// 链接颜色 - 紫色
  /// 用于 Markdown 渲染器中的链接
  static const Color linkColor = Color(0xFFBB86FC);

  /// HTML 链接颜色 - 青色
  /// 用于 HTML 渲染器中的链接（与 Markdown 区分）
  static const Color htmlLinkColor = Color(0xFF4FC3F7);

  // ==================== 边框颜色 ====================

  /// 主边框颜色
  /// 用于分割线、表格边框等
  static const Color borderColor = Color(0xFF3A3A3A);

  /// 次要边框颜色 - 24% 不透明度白色
  /// 用于水平分割线等
  static const Color borderSecondary = Colors.white24;

  // ==================== 特殊元素颜色 ====================

  /// 行内代码文字颜色 - 紫色
  /// 用于 Markdown 和 HTML 中的行内代码
  static const Color inlineCodeTextColor = Color(0xFFCE93D8);

  /// 引用块边框颜色
  /// 用于 blockquote 左侧边框
  static const Color blockquoteBorderColor = Color(0xFF546E7A);

  /// 引用块文字颜色
  /// 用于 blockquote 内的文字
  static const Color blockquoteTextColor = Color(0xFFB0BEC5);

  /// 删除线文字颜色
  /// 用于删除线文本
  static const Color strikethroughTextColor = Color(0xFF9E9E9E);

  /// 标记高亮背景色
  /// 用于 mark 标签的背景
  static const Color markBackgroundColor = Color(0xFFFFEB3B);

  // ==================== 错误状态颜色 ====================

  /// 错误背景色
  /// 用于错误提示容器的背景
  static Color get errorBackgroundColor => Colors.red.withValues(alpha: 0.1);

  /// 错误边框色
  /// 用于错误提示容器的边框
  static Color get errorBorderColor => Colors.red.withValues(alpha: 0.3);

  /// 警告图标颜色
  /// 用于错误提示中的图标
  static const Color warningIconColor = Colors.orange;

  // ==================== 字体配置 ====================

  /// 代码字体
  /// 用于代码块、行内代码等
  static const String codeFontFamily = 'JetBrains Mono';

  /// 正文字体大小
  static const double bodyFontSize = 16.0;

  /// 代码字体大小
  static const double codeFontSize = 14.0;

  /// 小号代码字体大小
  static const double smallCodeFontSize = 13.0;

  /// 行高倍数
  static const double lineHeight = 1.6;

  /// 代码行高倍数
  static const double codeLineHeight = 1.5;

  // ==================== 标题字体大小 ====================

  /// H1 字体大小
  static const double h1FontSize = 32.0;

  /// H2 字体大小
  static const double h2FontSize = 28.0;

  /// H3 字体大小
  static const double h3FontSize = 24.0;

  /// H4 字体大小
  static const double h4FontSize = 20.0;

  /// H5 字体大小
  static const double h5FontSize = 18.0;

  /// H6 字体大小
  static const double h6FontSize = 16.0;

  // ==================== 间距配置 ====================

  /// 默认内边距
  static const double defaultPadding = 16.0;

  /// 代码块内边距
  static const double codeBlockPadding = 16.0;

  /// 小内边距
  static const double smallPadding = 8.0;

  /// 列表缩进
  static const double listIndent = 24.0;

  // ==================== 圆角配置 ====================

  /// 默认圆角
  static const double defaultBorderRadius = 8.0;

  /// 小圆角
  static const double smallBorderRadius = 4.0;

  // ==================== 工具方法 ====================

  /// 获取文字颜色（根据亮度模式）
  ///
  /// [isDark] 是否为深色模式
  /// [darkColor] 深色模式下的颜色
  /// [lightColor] 浅色模式下的颜色
  static Color getTextColor({
    required bool isDark,
    Color? darkColor,
    Color? lightColor,
  }) {
    return isDark
        ? (darkColor ?? textSecondary)
        : (lightColor ?? Colors.black87);
  }

  /// 获取背景颜色（根据亮度模式）
  ///
  /// [isDark] 是否为深色模式
  /// [darkColor] 深色模式下的颜色
  /// [lightColor] 浅色模式下的颜色
  static Color getBackgroundColor({
    required bool isDark,
    Color? darkColor,
    Color? lightColor,
  }) {
    return isDark
        ? (darkColor ?? backgroundColor)
        : (lightColor ?? Colors.grey.shade100);
  }

  /// 获取代码块样式
  ///
  /// 返回代码块的基础文本样式
  static TextStyle getCodeTextStyle({
    double fontSize = codeFontSize,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: codeFontFamily,
      fontSize: fontSize,
      height: codeLineHeight,
      color: color ?? textPrimary,
    );
  }

  /// 获取正文样式
  ///
  /// 返回正文的基础文本样式
  static TextStyle getBodyTextStyle({
    double fontSize = bodyFontSize,
    Color? color,
  }) {
    return TextStyle(
      fontSize: fontSize,
      height: lineHeight,
      color: color ?? textSecondary,
    );
  }

  /// 获取标题样式
  ///
  /// [level] 标题级别 (1-6)
  /// [isDark] 是否为深色模式
  static TextStyle getHeadingStyle({required int level, required bool isDark}) {
    final fontSize = switch (level) {
      1 => h1FontSize,
      2 => h2FontSize,
      3 => h3FontSize,
      4 => h4FontSize,
      5 => h5FontSize,
      _ => h6FontSize,
    };

    final fontWeight = level <= 2 ? FontWeight.bold : FontWeight.w600;
    final color = isDark ? textPrimary : Colors.black;

    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: 1.3,
    );
  }

  // 私有构造函数，防止实例化
  ContentRendererTheme._();
}
