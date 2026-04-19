// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$emailDetailHash() => r'937890d81af26276308dd8dafaeea61134313534';

/// 邮件详情 Provider
///
/// 管理邮件详情的加载状态，支持根据邮件 ID 加载详情
///
/// Copied from [EmailDetail].
@ProviderFor(EmailDetail)
final emailDetailProvider =
    AutoDisposeNotifierProvider<EmailDetail, EmailDetailState>.internal(
      EmailDetail.new,
      name: r'emailDetailProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$emailDetailHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$EmailDetail = AutoDisposeNotifier<EmailDetailState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
