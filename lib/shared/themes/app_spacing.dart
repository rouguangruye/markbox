import 'package:flutter/material.dart';

/// 应用间距常量
///
/// 定义应用中使用的所有间距，遵循 8px 网格系统
class AppSpacing {
  AppSpacing._();

  // 基础间距单位
  static const double unit = 8.0;

  // 常用间距
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // 页面边距
  static const double pageHorizontal = 16.0;
  static const double pageVertical = 16.0;

  // 卡片内边距
  static const double cardPadding = 16.0;
  static const double cardPaddingSmall = 12.0;
  static const double cardPaddingLarge = 24.0;

  // 列表项间距
  static const double listItemVertical = 12.0;
  static const double listItemHorizontal = 16.0;

  // 元素间距
  static const double elementVertical = 8.0;
  static const double elementHorizontal = 8.0;

  // 输入框间距
  static const double inputVertical = 16.0;
  static const double inputHorizontal = 16.0;

  // 按钮间距
  static const double buttonVertical = 12.0;
  static const double buttonHorizontal = 16.0;

  // 图标间距
  static const double iconTextGap = 8.0;
  static const double iconPadding = 12.0;

  // 分组间距
  static const double sectionVertical = 24.0;
  static const double sectionHorizontal = 16.0;

  // 分割线上下间距
  static const double dividerVertical = 8.0;
}

/// 应用边距
///
/// 提供便捷的 EdgeInsets 创建方法
class AppEdgeInsets {
  AppEdgeInsets._();

  // 无边距
  static const EdgeInsets zero = EdgeInsets.zero;

  // 全方向边距
  static const EdgeInsets all4 = EdgeInsets.all(4.0);
  static const EdgeInsets all8 = EdgeInsets.all(8.0);
  static const EdgeInsets all12 = EdgeInsets.all(12.0);
  static const EdgeInsets all16 = EdgeInsets.all(16.0);
  static const EdgeInsets all24 = EdgeInsets.all(24.0);
  static const EdgeInsets all32 = EdgeInsets.all(32.0);

  // 水平边距
  static const EdgeInsets horizontal8 = EdgeInsets.symmetric(horizontal: 8.0);
  static const EdgeInsets horizontal16 = EdgeInsets.symmetric(horizontal: 16.0);
  static const EdgeInsets horizontal24 = EdgeInsets.symmetric(horizontal: 24.0);

  // 垂直边距
  static const EdgeInsets vertical4 = EdgeInsets.symmetric(vertical: 4.0);
  static const EdgeInsets vertical8 = EdgeInsets.symmetric(vertical: 8.0);
  static const EdgeInsets vertical12 = EdgeInsets.symmetric(vertical: 12.0);
  static const EdgeInsets vertical16 = EdgeInsets.symmetric(vertical: 16.0);
  static const EdgeInsets vertical24 = EdgeInsets.symmetric(vertical: 24.0);

  // 页面边距
  static const EdgeInsets page = EdgeInsets.all(16.0);
  static const EdgeInsets pageHorizontal = EdgeInsets.symmetric(
    horizontal: 16.0,
  );

  // 卡片边距
  static const EdgeInsets card = EdgeInsets.all(16.0);
  static const EdgeInsets cardSmall = EdgeInsets.all(12.0);
  static const EdgeInsets cardLarge = EdgeInsets.all(24.0);

  // 列表项边距
  static const EdgeInsets listItem = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 12.0,
  );

  // 按钮边距
  static const EdgeInsets button = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 12.0,
  );

  // 输入框边距
  static const EdgeInsets input = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 16.0,
  );
}

/// 应用尺寸
///
/// 定义应用中使用的各种尺寸
class AppSizes {
  AppSizes._();

  // 圆角
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  static const double radiusRound = 100.0;

  // 图标大小
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXLarge = 48.0;
  static const double iconXXLarge = 64.0;

  // 按钮高度
  static const double buttonHeightSmall = 32.0;
  static const double buttonHeight = 40.0;
  static const double buttonHeightLarge = 48.0;

  // 输入框高度
  static const double inputHeight = 56.0;

  // 卡片最小高度
  static const double cardMinHeight = 80.0;

  // 列表项高度
  static const double listItemHeight = 72.0;

  // AppBar 高度
  static const double appBarHeight = 56.0;

  // 底部导航栏高度
  static const double bottomNavBarHeight = 56.0;

  // 分割线粗细
  static const double dividerThickness = 1.0;
  static const double dividerThicknessThin = 0.5;

  // 边框粗细
  static const double borderWidth = 1.0;
  static const double borderWidthThick = 2.0;
}
