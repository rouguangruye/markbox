import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/secure_storage_service.dart';

part 'api_key_provider.g.dart';

/// API Key 配置状态
class ApiKeyConfig {
  final String? apiKey;
  final String model;

  const ApiKeyConfig({this.apiKey, this.model = 'glm-4-flash'});

  ApiKeyConfig copyWith({String? apiKey, String? model}) {
    return ApiKeyConfig(
      apiKey: apiKey ?? this.apiKey,
      model: model ?? this.model,
    );
  }
}

/// API Key Provider
///
/// 管理智谱 API Key 和模型的存储和读取
@Riverpod(keepAlive: true)
class ApiKey extends _$ApiKey {
  /// 安全存储服务实例
  late final SecureStorageService _storageService;

  @override
  ApiKeyConfig build() {
    _storageService = SecureStorageService();
    return const ApiKeyConfig();
  }

  /// 加载配置
  ///
  /// 从安全存储中加载已保存的 API Key 和模型
  Future<ApiKeyConfig> loadConfig() async {
    final apiKey = await _storageService.loadApiKey();
    final model = await _storageService.loadModel();
    final config = ApiKeyConfig(apiKey: apiKey, model: model);
    state = config;
    return config;
  }

  /// 保存 API Key
  ///
  /// 将 API Key 保存到安全存储
  Future<void> saveApiKey(String apiKey) async {
    await _storageService.saveApiKey(apiKey);
    state = state.copyWith(apiKey: apiKey);
  }

  /// 保存模型
  ///
  /// 将模型名称保存到安全存储
  Future<void> saveModel(String model) async {
    await _storageService.saveModel(model);
    state = state.copyWith(model: model);
  }

  /// 清除配置
  ///
  /// 从安全存储中删除 API Key 和模型
  Future<void> clearConfig() async {
    await _storageService.clearApiKey();
    await _storageService.clearModel();
    state = const ApiKeyConfig();
  }
}
