import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/account/pages/provider_selection_page.dart';
import 'pages/email_list_page.dart';
import 'shared/providers/account_config_provider.dart';
import 'shared/themes/app_colors.dart';
import 'shared/themes/app_text_styles.dart';
import 'shared/themes/app_spacing.dart';
import 'shared/routes/animated_page_route.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

/// 应用主入口
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MarkBox',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
          primary: AppColors.primary,
          surface: AppColors.background,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textPrimary,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: AppTextStyles.titleLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: AppColors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            side: BorderSide(
              color: AppColors.border,
              width: AppSizes.borderWidth,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.inputBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            borderSide: BorderSide(color: AppColors.inputBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            borderSide: BorderSide(color: AppColors.inputBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            borderSide: BorderSide(
              color: AppColors.inputBorderFocused,
              width: AppSizes.borderWidthThick,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            borderSide: BorderSide(color: AppColors.inputBorderError),
          ),
          contentPadding: AppEdgeInsets.input,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonPrimary,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: AppEdgeInsets.button,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            ),
            textStyle: AppTextStyles.button,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: AppEdgeInsets.button,
            textStyle: AppTextStyles.button,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: AppEdgeInsets.button,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            ),
            side: BorderSide(color: AppColors.primary),
            textStyle: AppTextStyles.button,
          ),
        ),
        dividerTheme: DividerThemeData(
          color: AppColors.divider,
          thickness: AppSizes.dividerThickness,
          space: AppSpacing.md,
        ),
        textTheme: TextTheme(
          headlineLarge: AppTextStyles.headlineLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          headlineMedium: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          headlineSmall: AppTextStyles.headlineSmall.copyWith(
            color: AppColors.textPrimary,
          ),
          titleLarge: AppTextStyles.titleLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          titleMedium: AppTextStyles.titleMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          titleSmall: AppTextStyles.titleSmall.copyWith(
            color: AppColors.textPrimary,
          ),
          bodyLarge: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          bodyMedium: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          bodySmall: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
          labelLarge: AppTextStyles.labelLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          labelMedium: AppTextStyles.labelMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          labelSmall: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
          primary: AppColors.primaryLight,
          surface: const Color(0xFF121212),
          error: AppColors.errorLight,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xFF121212),
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: AppTextStyles.titleLarge.copyWith(
            color: Colors.white,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            side: BorderSide(
              color: const Color(0xFF2C2C2C),
              width: AppSizes.borderWidth,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2C2C2C),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            borderSide: BorderSide(color: const Color(0xFF3C3C3C)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            borderSide: BorderSide(color: const Color(0xFF3C3C3C)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            borderSide: BorderSide(
              color: AppColors.primaryLight,
              width: AppSizes.borderWidthThick,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            borderSide: BorderSide(color: AppColors.errorLight),
          ),
          contentPadding: AppEdgeInsets.input,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryLight,
            foregroundColor: Colors.black,
            elevation: 0,
            padding: AppEdgeInsets.button,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            ),
            textStyle: AppTextStyles.button,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryLight,
            padding: AppEdgeInsets.button,
            textStyle: AppTextStyles.button,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryLight,
            padding: AppEdgeInsets.button,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            ),
            side: BorderSide(color: AppColors.primaryLight),
            textStyle: AppTextStyles.button,
          ),
        ),
        dividerTheme: DividerThemeData(
          color: const Color(0xFF2C2C2C),
          thickness: AppSizes.dividerThickness,
          space: AppSpacing.md,
        ),
        textTheme: TextTheme(
          headlineLarge: AppTextStyles.headlineLarge.copyWith(
            color: Colors.white,
          ),
          headlineMedium: AppTextStyles.headlineMedium.copyWith(
            color: Colors.white,
          ),
          headlineSmall: AppTextStyles.headlineSmall.copyWith(
            color: Colors.white,
          ),
          titleLarge: AppTextStyles.titleLarge.copyWith(color: Colors.white),
          titleMedium: AppTextStyles.titleMedium.copyWith(color: Colors.white),
          titleSmall: AppTextStyles.titleSmall.copyWith(color: Colors.white),
          bodyLarge: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
          bodyMedium: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
          bodySmall: AppTextStyles.bodySmall.copyWith(
            color: const Color(0xFFB0B0B0),
          ),
          labelLarge: AppTextStyles.labelLarge.copyWith(color: Colors.white),
          labelMedium: AppTextStyles.labelMedium.copyWith(
            color: const Color(0xFFB0B0B0),
          ),
          labelSmall: AppTextStyles.labelSmall.copyWith(
            color: const Color(0xFF808080),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

/// 主页面
///
/// 应用的主入口页面，提供导航到各个功能模块
/// 首次启动时会检查配置状态，未配置时跳转到配置页面
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

/// HomePage 的状态类
class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    // 在下一帧加载配置，避免在 build 期间修改状态
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadConfig();
    });
  }

  /// 加载账户配置
  Future<void> _loadConfig() async {
    await ref.read(accountConfigProvider.notifier).loadConfigs();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 监听账户配置状态
    final accountConfig = ref.watch(accountConfigProvider);

    // 如果尚未初始化或正在加载，显示加载指示器
    if (!accountConfig.isInitialized || accountConfig.isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                '正在加载配置...',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // 如果未配置账户，跳转到配置页面
    if (accountConfig.configs.isEmpty) {
      // 使用 WidgetsBinding 确保导航在当前帧完成后执行
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          SlideFadePageRoute(page: const ProviderSelectionPage()),
        );
      });

      // 返回空白页面，避免闪烁
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                '正在跳转到配置页面...',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // 已配置账户，直接跳转到邮件列表页面
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(
        context,
      ).pushReplacement(SlideFadePageRoute(page: const EmailListPage()));
    });

    // 返回加载页面，等待跳转
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              '正在加载邮件列表...',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
