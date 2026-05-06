extension DateTimeExtensions on DateTime {
  /// 转换为秒级 Unix 时间戳
  int get unixTimestamp => millisecondsSinceEpoch ~/ 1000;

  /// 从秒级 Unix 时间戳创建 DateTime
  static DateTime fromUnixTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }
}

extension IntDateTimeExtensions on int {
  /// 将秒级 Unix 时间戳转为 DateTime
  DateTime get toDateTime => DateTimeExtensions.fromUnixTimestamp(this);
}
