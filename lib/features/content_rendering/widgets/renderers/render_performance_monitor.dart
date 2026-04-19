import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 渲染性能监控器
///
/// 用于监控和记录渲染性能指标
class RenderPerformanceMonitor {
  /// 单例实例
  static final RenderPerformanceMonitor _instance =
      RenderPerformanceMonitor._internal();

  /// 获取单例实例
  factory RenderPerformanceMonitor() => _instance;

  /// 私有构造函数
  RenderPerformanceMonitor._internal();

  /// 性能记录
  final Map<String, List<_PerformanceRecord>> _records = {};

  /// 开始计时
  ///
  /// [tag] 性能标签
  /// 返回记录 ID
  String startTiming(String tag) {
    final recordId = '$tag-${DateTime.now().millisecondsSinceEpoch}';
    final record = _PerformanceRecord(tag: tag, startTime: DateTime.now());

    _records.putIfAbsent(tag, () => []);
    _records[tag]!.add(record);

    return recordId;
  }

  /// 结束计时
  ///
  /// [tag] 性能标签
  /// [recordId] 记录 ID
  /// 返回耗时（毫秒）
  int? endTiming(String tag, String recordId) {
    final records = _records[tag];
    if (records == null) return null;

    final record = records.firstWhere(
      (r) => '${r.tag}-${r.startTime.millisecondsSinceEpoch}' == recordId,
      orElse: () => throw StateError('Record not found: $recordId'),
    );

    record.endTime = DateTime.now();
    return record.durationMs;
  }

  /// 获取平均耗时
  ///
  /// [tag] 性能标签
  /// 返回平均耗时（毫秒）
  double getAverageDuration(String tag) {
    final records = _records[tag];
    if (records == null || records.isEmpty) return 0;

    final completedRecords = records.where((r) => r.endTime != null).toList();
    if (completedRecords.isEmpty) return 0;

    final totalDuration = completedRecords.fold<int>(
      0,
      (sum, record) => sum + (record.durationMs ?? 0),
    );

    return totalDuration / completedRecords.length;
  }

  /// 获取最大耗时
  ///
  /// [tag] 性能标签
  /// 返回最大耗时（毫秒）
  int getMaxDuration(String tag) {
    final records = _records[tag];
    if (records == null || records.isEmpty) return 0;

    final completedRecords = records.where((r) => r.endTime != null).toList();
    if (completedRecords.isEmpty) return 0;

    return completedRecords
        .map((r) => r.durationMs ?? 0)
        .reduce((a, b) => a > b ? a : b);
  }

  /// 获取最小耗时
  ///
  /// [tag] 性能标签
  /// 返回最小耗时（毫秒）
  int getMinDuration(String tag) {
    final records = _records[tag];
    if (records == null || records.isEmpty) return 0;

    final completedRecords = records.where((r) => r.endTime != null).toList();
    if (completedRecords.isEmpty) return 0;

    return completedRecords
        .map((r) => r.durationMs ?? 0)
        .reduce((a, b) => a < b ? a : b);
  }

  /// 清除性能记录
  ///
  /// [tag] 性能标签（可选，不提供则清除所有）
  void clearRecords({String? tag}) {
    if (tag != null) {
      _records.remove(tag);
    } else {
      _records.clear();
    }
  }

  /// 打印性能报告
  ///
  /// [tag] 性能标签（可选，不提供则打印所有）
  void printReport({String? tag}) {
    if (kDebugMode) {
      final tags = tag != null ? [tag] : _records.keys.toList();

      for (final currentTag in tags) {
        final avgDuration = getAverageDuration(currentTag);
        final maxDuration = getMaxDuration(currentTag);
        final minDuration = getMinDuration(currentTag);
        final recordCount = _records[currentTag]?.length ?? 0;

        debugPrint('========== 性能报告: $currentTag ==========');
        debugPrint('记录数量: $recordCount');
        debugPrint('平均耗时: ${avgDuration.toStringAsFixed(2)} ms');
        debugPrint('最大耗时: $maxDuration ms');
        debugPrint('最小耗时: $minDuration ms');
        debugPrint('========================================');
      }
    }
  }
}

/// 性能记录
class _PerformanceRecord {
  /// 性能标签
  final String tag;

  /// 开始时间
  final DateTime startTime;

  /// 结束时间
  DateTime? endTime;

  /// 创建性能记录
  _PerformanceRecord({required this.tag, required this.startTime});

  /// 获取耗时（毫秒）
  int? get durationMs {
    if (endTime == null) return null;
    return endTime!.difference(startTime).inMilliseconds;
  }
}

/// 性能监控辅助扩展
extension PerformanceMonitorExtension on Widget {
  /// 添加性能监控
  ///
  /// [tag] 性能标签
  /// 返回带性能监控的 Widget
  Widget withPerformanceMonitor(String tag) {
    return _PerformanceMonitorWidget(tag: tag, child: this);
  }
}

/// 性能监控 Widget
class _PerformanceMonitorWidget extends StatefulWidget {
  /// 性能标签
  final String tag;

  /// 子组件
  final Widget child;

  /// 创建性能监控 Widget
  const _PerformanceMonitorWidget({required this.tag, required this.child});

  @override
  State<_PerformanceMonitorWidget> createState() =>
      _PerformanceMonitorWidgetState();
}

class _PerformanceMonitorWidgetState extends State<_PerformanceMonitorWidget> {
  late String _recordId;
  final _monitor = RenderPerformanceMonitor();

  @override
  void initState() {
    super.initState();
    _recordId = _monitor.startTiming(widget.tag);
  }

  @override
  void dispose() {
    final duration = _monitor.endTiming(widget.tag, _recordId);
    if (duration != null && kDebugMode) {
      debugPrint('${widget.tag} 渲染耗时: $duration ms');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
