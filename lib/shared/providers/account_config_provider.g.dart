// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accountConfigHash() => r'e81c153005e5b024542cf136f1a5370ca630070f';

/// 账户配置 Provider
///
/// 管理账户配置的状态，包括加载、保存、更新和删除配置
/// keepAlive: true 保持状态不被自动释放，避免页面跳转时配置丢失
///
/// Copied from [AccountConfig].
@ProviderFor(AccountConfig)
final accountConfigProvider =
    NotifierProvider<AccountConfig, AccountConfigState>.internal(
      AccountConfig.new,
      name: r'accountConfigProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$accountConfigHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AccountConfig = Notifier<AccountConfigState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
