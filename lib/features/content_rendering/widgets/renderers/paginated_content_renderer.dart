import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// 分页内容渲染器
///
/// 用于优化长内容的渲染性能，支持：
/// - 虚拟滚动（只渲染可见区域）
/// - 分页加载（按需加载内容块）
/// - 性能监控
/// - 平滑滚动体验
class PaginatedContentRenderer extends StatefulWidget {
  /// 内容块构建器
  ///
  /// [pageIndex] 页面索引
  /// [startIndex] 内容起始索引
  /// [endIndex] 内容结束索引
  /// 返回该页面的 Widget
  final Widget Function(int pageIndex, int startIndex, int endIndex)
  pageBuilder;

  /// 总内容长度（用于计算分页）
  final int totalLength;

  /// 每页内容长度（默认 5000 字符）
  final int pageLength;

  /// 预加载页面数（默认预加载前后各 1 页）
  final int preloadPages;

  /// 页面间距
  final double pageSpacing;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 滚动控制器
  final ScrollController? scrollController;

  /// 创建分页内容渲染器
  const PaginatedContentRenderer({
    super.key,
    required this.pageBuilder,
    required this.totalLength,
    this.pageLength = 5000,
    this.preloadPages = 1,
    this.pageSpacing = 16.0,
    this.padding,
    this.scrollController,
  });

  @override
  State<PaginatedContentRenderer> createState() =>
      _PaginatedContentRendererState();
}

class _PaginatedContentRendererState extends State<PaginatedContentRenderer> {
  /// 当前可见的页面索引范围
  late List<int> _visiblePages;

  /// 滚动控制器
  late ScrollController _scrollController;

  /// 页面缓存
  final Map<int, Widget> _pageCache = {};

  /// 总页数
  late int _totalPages;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _totalPages = (widget.totalLength / widget.pageLength).ceil();
    _visiblePages = [0]; // 初始只显示第一页
    _scrollController.addListener(_onScroll);

    // 延迟计算初始可见页面
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _updateVisiblePages();
    });
  }

  @override
  void didUpdateWidget(PaginatedContentRenderer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 如果内容长度变化，重新计算分页
    if (oldWidget.totalLength != widget.totalLength ||
        oldWidget.pageLength != widget.pageLength) {
      _totalPages = (widget.totalLength / widget.pageLength).ceil();
      _pageCache.clear();
      _updateVisiblePages();
    }

    // 如果滚动控制器变化，更新监听器
    if (oldWidget.scrollController != widget.scrollController) {
      _scrollController.removeListener(_onScroll);
      _scrollController = widget.scrollController ?? ScrollController();
      _scrollController.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    // 只有当控制器是内部创建时才释放
    if (widget.scrollController == null) {
      _scrollController.dispose();
    } else {
      _scrollController.removeListener(_onScroll);
    }
    _pageCache.clear();
    super.dispose();
  }

  /// 滚动监听器
  void _onScroll() {
    _updateVisiblePages();
  }

  /// 更新可见页面范围
  void _updateVisiblePages() {
    if (!mounted) return;

    final scrollOffset = _scrollController.offset;
    final viewportHeight = _scrollController.position.viewportDimension;

    // 计算当前可见的页面范围
    final firstVisiblePage = (scrollOffset / _estimatePageHeight()).floor();
    final lastVisiblePage =
        ((scrollOffset + viewportHeight) / _estimatePageHeight()).floor();

    // 添加预加载页面
    final startPage = (firstVisiblePage - widget.preloadPages).clamp(
      0,
      _totalPages - 1,
    );
    final endPage = (lastVisiblePage + widget.preloadPages).clamp(
      0,
      _totalPages - 1,
    );

    // 更新可见页面列表
    final newVisiblePages = List.generate(
      endPage - startPage + 1,
      (index) => startPage + index,
    );

    // 如果可见页面发生变化，更新状态
    if (!_listsEqual(_visiblePages, newVisiblePages)) {
      setState(() {
        _visiblePages = newVisiblePages;
      });

      // 清理不可见的页面缓存
      _cleanupCache();
    }
  }

  /// 估算页面高度
  double _estimatePageHeight() {
    // 假设每个字符平均高度为 20（考虑字体大小和行高）
    // 这是一个粗略估算，实际高度会根据内容类型变化
    return widget.pageLength * 0.02 + widget.pageSpacing;
  }

  /// 清理不可见的页面缓存
  void _cleanupCache() {
    final keysToRemove = <int>[];
    for (final key in _pageCache.keys) {
      if (!_visiblePages.contains(key)) {
        keysToRemove.add(key);
      }
    }

    for (final key in keysToRemove) {
      _pageCache.remove(key);
    }
  }

  /// 比较两个列表是否相等
  bool _listsEqual(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  /// 构建页面内容
  Widget _buildPage(int pageIndex) {
    // 检查缓存
    if (_pageCache.containsKey(pageIndex)) {
      return _pageCache[pageIndex]!;
    }

    // 计算内容范围
    final startIndex = pageIndex * widget.pageLength;
    final endIndex = (startIndex + widget.pageLength).clamp(
      0,
      widget.totalLength,
    );

    // 构建页面
    final pageWidget = widget.pageBuilder(pageIndex, startIndex, endIndex);

    // 缓存页面
    _pageCache[pageIndex] = pageWidget;

    return pageWidget;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      padding: widget.padding,
      itemCount: _totalPages,
      itemBuilder: (context, index) {
        // 只渲染可见的页面
        if (!_visiblePages.contains(index)) {
          // 返回占位符，保持滚动位置准确
          return SizedBox(
            height: _estimatePageHeight(),
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.only(
            bottom: index < _totalPages - 1 ? widget.pageSpacing : 0,
          ),
          child: _buildPage(index),
        );
      },
    );
  }
}

/// 分页内容助手
///
/// 提供内容分割和页面管理的辅助方法
class PaginatedContentHelper {
  /// 将内容分割成页面
  ///
  /// [content] 原始内容
  /// [pageLength] 每页长度
  /// 返回页面内容列表
  static List<String> splitContent(String content, {int pageLength = 5000}) {
    final pages = <String>[];
    var currentIndex = 0;

    while (currentIndex < content.length) {
      var endIndex = currentIndex + pageLength;

      // 如果不是最后一页，尝试在合适的断点处分割
      if (endIndex < content.length) {
        // 优先在段落结束处分割
        var paragraphBreak = content.lastIndexOf('\n\n', endIndex);
        if (paragraphBreak > currentIndex && paragraphBreak > endIndex - 500) {
          endIndex = paragraphBreak + 2;
        } else {
          // 其次在换行处分割
          var lineBreak = content.lastIndexOf('\n', endIndex);
          if (lineBreak > currentIndex && lineBreak > endIndex - 200) {
            endIndex = lineBreak + 1;
          }
        }
      } else {
        endIndex = content.length;
      }

      pages.add(content.substring(currentIndex, endIndex));
      currentIndex = endIndex;
    }

    return pages;
  }

  /// 计算内容应该显示的页面索引
  ///
  /// [content] 原始内容
  /// [characterIndex] 字符索引
  /// [pageLength] 每页长度
  /// 返回页面索引
  static int calculatePageIndex(
    String content,
    int characterIndex, {
    int pageLength = 5000,
  }) {
    var currentIndex = 0;
    var pageIndex = 0;

    while (currentIndex < content.length && currentIndex <= characterIndex) {
      var endIndex = currentIndex + pageLength;

      if (endIndex < content.length) {
        var paragraphBreak = content.lastIndexOf('\n\n', endIndex);
        if (paragraphBreak > currentIndex && paragraphBreak > endIndex - 500) {
          endIndex = paragraphBreak + 2;
        } else {
          var lineBreak = content.lastIndexOf('\n', endIndex);
          if (lineBreak > currentIndex && lineBreak > endIndex - 200) {
            endIndex = lineBreak + 1;
          }
        }
      } else {
        endIndex = content.length;
      }

      if (characterIndex >= currentIndex && characterIndex < endIndex) {
        return pageIndex;
      }

      currentIndex = endIndex;
      pageIndex++;
    }

    return pageIndex;
  }
}
