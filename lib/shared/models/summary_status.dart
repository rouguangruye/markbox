/// 摘要生成状态
///
/// 用于标记邮件摘要的生成状态
enum SummaryStatus {
  /// 未生成
  notGenerated,

  /// 生成中
  generating,

  /// 已生成
  generated,

  /// 生成失败
  failed,
}
