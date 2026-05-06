import 'package:uuid/uuid.dart';

class IdGenerator {
  IdGenerator._();

  static const Uuid _uuid = Uuid();

  /// 生成 v4 UUID
  static String uuid() => _uuid.v4();

  /// 生成基于时间戳的 ID（毫秒级）
  static String timestampId() => DateTime.now().millisecondsSinceEpoch.toString();
}
