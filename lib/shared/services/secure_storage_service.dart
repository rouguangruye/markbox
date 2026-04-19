import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/email.dart';
import '../models/imap_config.dart';

/// 安全存储服务
///
/// 使用 flutter_secure_storage 提供安全存储机制
/// 用于存储敏感信息如 IMAP 配置、授权码等
class SecureStorageService {
  // 单例实例
  static final SecureStorageService _instance =
      SecureStorageService._internal();

  // 工厂构造函数返回单例
  factory SecureStorageService() => _instance;

  // 私有构造函数
  SecureStorageService._internal();

  /// FlutterSecureStorage 实例
  ///
  /// Android: 使用 KeyStore 加密存储
  /// iOS: 使用 Keychain 加密存储
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  /// IMAP 配置存储的键名（旧格式，单个配置）
  static const String _imapConfigKey = 'imap_config';

  /// IMAP 配置列表存储的键名（新格式，多个配置）
  static const String _imapConfigsKey = 'imap_configs';

  /// 邮件列表存储的键名
  static const String _emailListKey = 'email_list';

  /// 邮件详情存储的键名前缀
  static const String _emailDetailKeyPrefix = 'email_detail_';

  /// 邮件缓存最大数量
  static const int _maxCachedEmails = 100;

  /// 保存 IMAP 配置列表
  ///
  /// [configs] IMAP 配置列表
  Future<void> saveImapConfigs(List<ImapConfig> configs) async {
    try {
      final jsonString = jsonEncode(configs.map((c) => c.toJson()).toList());
      await _storage.write(key: _imapConfigsKey, value: jsonString);
    } catch (e) {
      throw SecureStorageException('保存 IMAP 配置失败: ${e.toString()}', e);
    }
  }

  /// 加载 IMAP 配置列表
  ///
  /// 返回已保存的 IMAP 配置列表
  /// 如果不存在则返回空列表
  /// 自动迁移旧格式数据
  Future<List<ImapConfig>> loadImapConfigs() async {
    try {
      // 先尝试加载新格式
      final jsonString = await _storage.read(key: _imapConfigsKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final jsonList = jsonDecode(jsonString) as List<dynamic>;
        return jsonList
            .map((json) => ImapConfig.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      // 尝试迁移旧格式
      final oldConfig = await _loadOldImapConfig();
      if (oldConfig != null) {
        // 迁移成功后保存新格式
        final configs = [oldConfig];
        await saveImapConfigs(configs);
        // 删除旧格式
        await _storage.delete(key: _imapConfigKey);
        return configs;
      }

      return [];
    } catch (e) {
      throw SecureStorageException('加载 IMAP 配置失败: ${e.toString()}', e);
    }
  }

  /// 加载旧格式的 IMAP 配置（用于数据迁移）
  Future<ImapConfig?> _loadOldImapConfig() async {
    try {
      final jsonString = await _storage.read(key: _imapConfigKey);
      if (jsonString == null || jsonString.isEmpty) {
        return null;
      }
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;

      // 旧格式数据没有 id 字段，需要生成一个
      final oldData = Map<String, dynamic>.from(jsonMap);
      if (!oldData.containsKey('id') || (oldData['id'] as String).isEmpty) {
        oldData['id'] = 'migrated_${DateTime.now().millisecondsSinceEpoch}';
      }
      if (!oldData.containsKey('createdAt')) {
        oldData['createdAt'] = DateTime.now().millisecondsSinceEpoch;
      }

      return ImapConfig.fromJson(oldData);
    } catch (e) {
      return null;
    }
  }

  /// 删除所有 IMAP 配置
  Future<void> deleteAllImapConfigs() async {
    try {
      await _storage.delete(key: _imapConfigsKey);
      // 同时删除旧格式
      await _storage.delete(key: _imapConfigKey);
    } catch (e) {
      throw SecureStorageException('删除 IMAP 配置失败: ${e.toString()}', e);
    }
  }

  /// 保存完整的 IMAP 配置（兼容旧接口）
  ///
  /// [config] IMAP 配置对象
  @Deprecated('Use saveImapConfigs instead')
  Future<void> saveImapConfig(ImapConfig config) async {
    try {
      final jsonString = jsonEncode(config.toJson());
      await _storage.write(key: _imapConfigKey, value: jsonString);
    } catch (e) {
      throw SecureStorageException('保存 IMAP 配置失败: ${e.toString()}', e);
    }
  }

  /// 加载已保存的 IMAP 配置（兼容旧接口）
  ///
  /// 返回已保存的 IMAP 配置，如果不存在则返回 null
  @Deprecated('Use loadImapConfigs instead')
  Future<ImapConfig?> loadImapConfig() async {
    try {
      final jsonString = await _storage.read(key: _imapConfigKey);
      if (jsonString == null || jsonString.isEmpty) {
        return null;
      }
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return ImapConfig.fromJson(jsonMap);
    } catch (e) {
      throw SecureStorageException('加载 IMAP 配置失败: ${e.toString()}', e);
    }
  }

  /// 删除已保存的 IMAP 配置（兼容旧接口）
  @Deprecated('Use deleteAllImapConfigs instead')
  Future<void> deleteImapConfig() async {
    try {
      await _storage.delete(key: _imapConfigKey);
    } catch (e) {
      throw SecureStorageException('删除 IMAP 配置失败: ${e.toString()}', e);
    }
  }

  /// 保存单个安全值
  ///
  /// [key] 键名
  /// [value] 值
  Future<void> saveSecureValue(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      throw SecureStorageException('保存安全值失败: ${e.toString()}', e);
    }
  }

  /// 获取单个安全值
  ///
  /// [key] 键名
  /// 返回对应的值，如果不存在则返回 null
  Future<String?> getSecureValue(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      throw SecureStorageException('获取安全值失败: ${e.toString()}', e);
    }
  }

  /// 删除单个安全值
  ///
  /// [key] 键名
  Future<void> deleteSecureValue(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      throw SecureStorageException('删除安全值失败: ${e.toString()}', e);
    }
  }

  /// 清空所有安全存储的数据
  ///
  /// 谨慎使用，会删除所有已保存的敏感信息
  Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw SecureStorageException('清空安全存储失败: ${e.toString()}', e);
    }
  }

  /// 检查指定键是否存在
  ///
  /// [key] 键名
  /// 返回是否存在该键
  Future<bool> containsKey(String key) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (e) {
      throw SecureStorageException('检查键是否存在失败: ${e.toString()}', e);
    }
  }

  /// 获取所有已存储的键
  ///
  /// 返回所有键的集合
  Future<Set<String>> getAllKeys() async {
    try {
      final Map<String, String> allValues = await _storage.readAll();
      return allValues.keys.toSet();
    } catch (e) {
      throw SecureStorageException('获取所有键失败: ${e.toString()}', e);
    }
  }

  /// 保存邮件列表缓存
  ///
  /// [emails] 邮件列表
  ///
  /// 将邮件列表序列化为 JSON 并安全存储
  /// 最多缓存 [_maxCachedEmails] 封邮件
  Future<void> saveEmailList(List<Email> emails) async {
    try {
      // 限制缓存数量，只保留最近的邮件
      final emailsToSave = emails.length > _maxCachedEmails
          ? emails.sublist(0, _maxCachedEmails)
          : emails;

      // 序列化为 JSON 字符串
      final jsonString = jsonEncode(
        emailsToSave.map((e) => e.toJson()).toList(),
      );

      // 使用安全存储保存
      await _storage.write(key: _emailListKey, value: jsonString);
    } catch (e) {
      throw SecureStorageException('保存邮件列表失败: ${e.toString()}', e);
    }
  }

  /// 加载邮件列表缓存
  ///
  /// 返回已保存的邮件列表，如果不存在则返回空列表
  Future<List<Email>> loadEmailList() async {
    try {
      // 从安全存储读取
      final jsonString = await _storage.read(key: _emailListKey);

      // 如果不存在则返回空列表
      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      // 反序列化 JSON 为邮件列表
      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) => Email.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // 加载失败时返回空列表，不抛出异常
      return [];
    }
  }

  /// 清除邮件列表缓存
  Future<void> clearEmailList() async {
    try {
      await _storage.delete(key: _emailListKey);
    } catch (e) {
      throw SecureStorageException('清除邮件列表失败: ${e.toString()}', e);
    }
  }

  /// 保存单个邮件详情缓存
  ///
  /// [email] 邮件详情对象
  Future<void> saveEmailDetail(Email email) async {
    try {
      final key = '$_emailDetailKeyPrefix${email.id}';
      final jsonString = jsonEncode(email.toJson());
      await _storage.write(key: key, value: jsonString);
    } catch (e) {
      throw SecureStorageException('保存邮件详情失败: ${e.toString()}', e);
    }
  }

  /// 加载单个邮件详情缓存
  ///
  /// [emailId] 邮件 ID
  /// 返回已保存的邮件详情，如果不存在则返回 null
  Future<Email?> loadEmailDetail(String emailId) async {
    try {
      final key = '$_emailDetailKeyPrefix$emailId';
      final jsonString = await _storage.read(key: key);

      if (jsonString == null || jsonString.isEmpty) {
        return null;
      }

      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return Email.fromJson(jsonMap);
    } catch (e) {
      // 加载失败时返回 null，不抛出异常
      return null;
    }
  }

  /// 清除单个邮件详情缓存
  ///
  /// [emailId] 邮件 ID
  Future<void> clearEmailDetail(String emailId) async {
    try {
      final key = '$_emailDetailKeyPrefix$emailId';
      await _storage.delete(key: key);
    } catch (e) {
      throw SecureStorageException('清除邮件详情失败: ${e.toString()}', e);
    }
  }

  /// API Key 存储的键名
  static const String _apiKeyKey = 'zhipu_api_key';

  /// 模型存储的键名
  static const String _modelKey = 'zhipu_model';

  /// 保存 API Key
  ///
  /// [apiKey] API Key 字符串
  Future<void> saveApiKey(String apiKey) async {
    try {
      await _storage.write(key: _apiKeyKey, value: apiKey);
    } catch (e) {
      throw SecureStorageException('保存 API Key 失败: ${e.toString()}', e);
    }
  }

  /// 加载 API Key
  ///
  /// 返回已保存的 API Key，如果不存在则返回 null
  Future<String?> loadApiKey() async {
    try {
      return await _storage.read(key: _apiKeyKey);
    } catch (e) {
      return null;
    }
  }

  /// 清除 API Key
  Future<void> clearApiKey() async {
    try {
      await _storage.delete(key: _apiKeyKey);
    } catch (e) {
      throw SecureStorageException('清除 API Key 失败: ${e.toString()}', e);
    }
  }

  /// 保存模型名称
  ///
  /// [model] 模型名称
  Future<void> saveModel(String model) async {
    try {
      await _storage.write(key: _modelKey, value: model);
    } catch (e) {
      throw SecureStorageException('保存模型失败: ${e.toString()}', e);
    }
  }

  /// 加载模型名称
  ///
  /// 返回已保存的模型名称，如果不存在则返回默认模型
  Future<String> loadModel() async {
    try {
      final model = await _storage.read(key: _modelKey);
      return model ?? 'glm-4-flash';
    } catch (e) {
      return 'glm-4-flash';
    }
  }

  /// 清除模型配置
  Future<void> clearModel() async {
    try {
      await _storage.delete(key: _modelKey);
    } catch (e) {
      throw SecureStorageException('清除模型失败: ${e.toString()}', e);
    }
  }
}

/// 安全存储异常
class SecureStorageException implements Exception {
  final String message;
  final dynamic originalError;

  SecureStorageException(this.message, [this.originalError]);

  @override
  String toString() => 'SecureStorageException: $message';
}
