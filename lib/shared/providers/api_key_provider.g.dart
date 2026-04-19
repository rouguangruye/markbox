// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_key_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$apiKeyHash() => r'061bbda59e775024c24d3d92f15c4c667ca84e8a';

/// API Key Provider
///
/// 管理智谱 API Key 和模型的存储和读取
///
/// Copied from [ApiKey].
@ProviderFor(ApiKey)
final apiKeyProvider = NotifierProvider<ApiKey, ApiKeyConfig>.internal(
  ApiKey.new,
  name: r'apiKeyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$apiKeyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ApiKey = Notifier<ApiKeyConfig>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
