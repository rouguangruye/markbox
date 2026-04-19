import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/account_config_state.dart';
import '../models/imap_config.dart';
import '../services/imap_service.dart';
import '../services/secure_storage_service.dart';

part 'account_config_provider.g.dart';

/// 账户配置 Provider
///
/// 管理账户配置的状态，包括加载、保存、更新和删除配置
/// keepAlive: true 保持状态不被自动释放，避免页面跳转时配置丢失
@Riverpod(keepAlive: true)
class AccountConfig extends _$AccountConfig {
  /// 安全存储服务实例
  late final SecureStorageService _storageService;

  /// IMAP 服务实例
  late final ImapService _imapService;

  @override
  AccountConfigState build() {
    // 初始化服务实例
    _storageService = SecureStorageService();
    _imapService = ImapService();

    // 返回初始状态
    return const AccountConfigState();
  }

  /// 加载已保存的配置列表
  ///
  /// 从安全存储中加载已保存的 IMAP 配置列表
  /// 加载成功后会更新 configs 状态
  Future<void> loadConfigs() async {
    // 设置加载状态
    state = state.copyWith(isLoading: true, error: null);

    try {
      // 从安全存储加载配置列表
      final configs = await _storageService.loadImapConfigs();

      // 更新状态
      state = state.copyWith(
        configs: configs,
        isLoading: false,
        isInitialized: true,
      );
    } on SecureStorageException catch (e) {
      // 处理安全存储异常
      state = state.copyWith(
        isLoading: false,
        isInitialized: true,
        error: e.message,
      );
    } catch (e) {
      // 处理其他异常
      state = state.copyWith(
        isLoading: false,
        isInitialized: true,
        error: '加载配置失败: ${e.toString()}',
      );
    }
  }

  /// 添加新配置
  ///
  /// [config] 要添加的 IMAP 配置
  /// 添加前会先测试连接，连接成功后才会保存
  /// 返回是否添加成功
  Future<bool> addConfig(ImapConfig config) async {
    // 设置保存状态
    state = state.copyWith(isSaving: true, error: null);

    try {
      // 先测试连接
      final result = await _imapService.testConnectionWithValidation(config);

      if (!result.success) {
        // 连接测试失败
        state = state.copyWith(
          isSaving: false,
          error: result.errorMessage ?? '连接测试失败',
        );
        return false;
      }

      // 连接测试成功，添加配置到列表
      final newConfigs = [...state.configs, config];
      await _storageService.saveImapConfigs(newConfigs);

      // 更新状态
      state = state.copyWith(configs: newConfigs, isSaving: false);

      return true;
    } on SecureStorageException catch (e) {
      // 处理安全存储异常
      state = state.copyWith(isSaving: false, error: e.message);
      return false;
    } catch (e) {
      // 处理其他异常
      state = state.copyWith(isSaving: false, error: '保存配置失败: ${e.toString()}');
      return false;
    }
  }

  /// 更新现有配置
  ///
  /// [config] 更新后的 IMAP 配置
  /// 更新前会先测试连接，连接成功后才会更新
  /// 返回是否更新成功
  Future<bool> updateConfig(ImapConfig config) async {
    // 设置保存状态
    state = state.copyWith(isSaving: true, error: null);

    try {
      // 先测试连接
      final result = await _imapService.testConnectionWithValidation(config);

      if (!result.success) {
        // 连接测试失败
        state = state.copyWith(
          isSaving: false,
          error: result.errorMessage ?? '连接测试失败',
        );
        return false;
      }

      // 连接测试成功，更新配置
      final newConfigs = state.configs.map((c) {
        return c.id == config.id ? config : c;
      }).toList();
      await _storageService.saveImapConfigs(newConfigs);

      // 更新状态
      state = state.copyWith(configs: newConfigs, isSaving: false);

      return true;
    } on SecureStorageException catch (e) {
      // 处理安全存储异常
      state = state.copyWith(isSaving: false, error: e.message);
      return false;
    } catch (e) {
      // 处理其他异常
      state = state.copyWith(isSaving: false, error: '更新配置失败: ${e.toString()}');
      return false;
    }
  }

  /// 删除配置
  ///
  /// [configId] 要删除的配置 ID
  Future<void> deleteConfig(String configId) async {
    // 设置加载状态（删除操作也需要时间）
    state = state.copyWith(isLoading: true, error: null);

    try {
      // 从列表中移除配置
      final newConfigs = state.configs.where((c) => c.id != configId).toList();
      await _storageService.saveImapConfigs(newConfigs);

      // 更新状态
      state = state.copyWith(configs: newConfigs, isLoading: false);
    } on SecureStorageException catch (e) {
      // 处理安全存储异常
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      // 处理其他异常
      state = state.copyWith(
        isLoading: false,
        error: '删除配置失败: ${e.toString()}',
      );
    }
  }

  /// 根据 ID 获取配置
  ///
  /// [id] 配置 ID
  /// 返回对应的配置，如果不存在则返回 null
  ImapConfig? getConfigById(String id) {
    return state.configs.firstWhereOrNull((c) => c.id == id);
  }

  /// 清除错误信息
  ///
  /// 清除当前状态中的错误信息
  void clearError() {
    state = state.copyWith(error: null);
  }
}
