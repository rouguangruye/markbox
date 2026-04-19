// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$emailServiceHash() => r'a65b8f50c12f5e084735a159dee55c6ac729cc1c';

/// 邮件服务 Provider
///
/// 提供 EmailService 的单例实例
///
/// Copied from [emailService].
@ProviderFor(emailService)
final emailServiceProvider = AutoDisposeProvider<EmailService>.internal(
  emailService,
  name: r'emailServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$emailServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EmailServiceRef = AutoDisposeProviderRef<EmailService>;
String _$zhipuServiceHash() => r'bcaa748e2b26f815b80fadd2903eab5c71665caa';

/// 智谱服务 Provider
///
/// 提供 ZhipuService 的单例实例
///
/// Copied from [zhipuService].
@ProviderFor(zhipuService)
final zhipuServiceProvider = AutoDisposeProvider<ZhipuService>.internal(
  zhipuService,
  name: r'zhipuServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$zhipuServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ZhipuServiceRef = AutoDisposeProviderRef<ZhipuService>;
String _$emailListHash() => r'fd1bdbb70172de81fe1cd837dfd012f39b50dee8';

/// 邮件列表 Provider
///
/// 管理邮件列表的状态，包括加载、刷新、分页等操作
/// keepAlive: true 保持状态不被自动释放，实现内存缓存
///
/// Copied from [EmailList].
@ProviderFor(EmailList)
final emailListProvider = NotifierProvider<EmailList, EmailListState>.internal(
  EmailList.new,
  name: r'emailListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$emailListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EmailList = Notifier<EmailListState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
