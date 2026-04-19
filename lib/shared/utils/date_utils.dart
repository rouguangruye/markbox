/// 日期时间工具类
///
/// 提供日期时间相关的格式化功能
class DateTimeUtils {
  /// 将日期时间格式化为标准格式
  ///
  /// [dateTime] 要格式化的日期时间
  /// 返回格式：2026-04-18 14:30
  static String formatDateTime(DateTime dateTime) {
    final year = dateTime.year;
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '$year-$month-$day $hour:$minute';
  }

  /// 将日期时间格式化为相对时间字符串
  ///
  /// [dateTime] 要格式化的日期时间
  /// 返回相对时间字符串，例如："刚刚"、"5分钟前"、"2小时前"、"3天前"
  static String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    // 小于1分钟
    if (difference.inSeconds < 60) {
      return '刚刚';
    }

    // 小于1小时
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}分钟前';
    }

    // 小于24小时
    if (difference.inHours < 24) {
      return '${difference.inHours}小时前';
    }

    // 大于等于24小时
    return '${difference.inDays}天前';
  }
}
