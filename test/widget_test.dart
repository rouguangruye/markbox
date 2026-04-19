// MarkBox 应用基础测试
//
// 测试应用主页面是否正确渲染

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markbox/features/account/pages/provider_selection_page.dart';
import 'package:markbox/main.dart';
import 'package:markbox/shared/models/account_config_state.dart';
import 'package:markbox/shared/providers/account_config_provider.dart';

void main() {
  testWidgets('应用启动测试 - 未配置账户', (WidgetTester tester) async {
    // 构建应用并触发渲染，使用未配置的 mock provider
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          accountConfigProvider.overrideWith(
            () => MockAccountConfigUnconfigured(),
          ),
        ],
        child: const MyApp(),
      ),
    );

    // 等待渲染完成
    await tester.pumpAndSettle();

    // 验证 MaterialApp 存在
    expect(find.byType(MaterialApp), findsOneWidget);

    // 验证跳转到配置页面
    expect(find.byType(ProviderSelectionPage), findsOneWidget);
  });
}

/// Mock AccountConfig Provider，返回未配置状态
class MockAccountConfigUnconfigured extends AccountConfig {
  @override
  AccountConfigState build() {
    return const AccountConfigState(currentConfig: null, isInitialized: true);
  }
}
