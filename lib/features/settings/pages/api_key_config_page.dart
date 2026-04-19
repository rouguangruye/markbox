import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/themes/app_colors.dart';
import '../../../shared/themes/app_text_styles.dart';
import '../../../shared/themes/app_spacing.dart';
import '../../../shared/providers/api_key_provider.dart';

/// 可用的智谱模型列表
const List<Map<String, String>> kAvailableModels = [
  {'value': 'glm-4-flash', 'label': 'GLM-4-Flash（快速）'},
  {'value': 'glm-4', 'label': 'GLM-4（标准）'},
  {'value': 'glm-4-plus', 'label': 'GLM-4-Plus（增强）'},
  {'value': 'glm-4-air', 'label': 'GLM-4-Air（轻量）'},
];

/// API Key 配置页面
///
/// 用于配置智谱 API Key 和模型，用于邮件摘要功能
class ApiKeyConfigPage extends ConsumerStatefulWidget {
  const ApiKeyConfigPage({super.key});

  @override
  ConsumerState<ApiKeyConfigPage> createState() => _ApiKeyConfigPageState();
}

class _ApiKeyConfigPageState extends ConsumerState<ApiKeyConfigPage> {
  final _formKey = GlobalKey<FormState>();
  final _apiKeyController = TextEditingController();
  String _selectedModel = 'glm-4-flash';
  bool _isLoading = false;
  bool _obscureKey = true;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  Future<void> _loadConfig() async {
    final config = await ref.read(apiKeyProvider.notifier).loadConfig();
    if (config.apiKey != null) {
      _apiKeyController.text = config.apiKey!;
    }
    setState(() {
      _selectedModel = config.model;
    });
  }

  Future<void> _saveConfig() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await ref
          .read(apiKeyProvider.notifier)
          .saveApiKey(_apiKeyController.text);
      await ref.read(apiKeyProvider.notifier).saveModel(_selectedModel);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('配置保存成功'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('保存失败: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _clearConfig() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认清除'),
        content: const Text('确定要清除已保存的配置吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('清除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(apiKeyProvider.notifier).clearConfig();
      _apiKeyController.clear();
      setState(() {
        _selectedModel = 'glm-4-flash';
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('配置已清除'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API 配置'),
        centerTitle: true,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
      ),
      body: SingleChildScrollView(
        padding: AppEdgeInsets.page,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 说明卡片
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '智谱 AI 配置',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '用于生成邮件摘要，提供更智能的邮件预览体验。',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '获取方式：',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '1. 访问 open.bigmodel.cn\n2. 注册/登录账号\n3. 在 API Keys 页面创建新密钥',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // API Key 输入框
              Text(
                'API Key',
                style: AppTextStyles.titleSmall.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _apiKeyController,
                obscureText: _obscureKey,
                decoration: InputDecoration(
                  hintText: '请输入智谱 API Key',
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                    borderSide: const BorderSide(color: AppColors.divider),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                    borderSide: const BorderSide(color: AppColors.divider),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureKey ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textTertiary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureKey = !_obscureKey;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入 API Key';
                  }
                  if (value.length < 10) {
                    return 'API Key 格式不正确';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // 模型选择
              Text(
                '模型选择',
                style: AppTextStyles.titleSmall.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                  border: Border.all(color: AppColors.divider),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedModel,
                    isExpanded: true,
                    items: kAvailableModels.map((model) {
                      return DropdownMenuItem<String>(
                        value: model['value'],
                        child: Text(model['label']!),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedModel = value;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 按钮组
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _isLoading ? null : _clearConfig,
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('清除'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusMedium,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: FilledButton.icon(
                      onPressed: _isLoading ? null : _saveConfig,
                      icon: _isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.save),
                      label: Text(_isLoading ? '保存中...' : '保存'),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusMedium,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
