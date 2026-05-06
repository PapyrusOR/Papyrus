import '../../core/constants/app_constants.dart';
import '../../data/models/card_model.dart';

/// SM-2 间隔重复算法实现
/// 
/// 输入: 当前卡片和用户评分 (1=忘记, 2=模糊, 3=秒杀)
/// 输出: 更新后的卡片
class SM2Engine {
  SM2Engine._();

  /// 将三档评分映射为 SM-2 质量分 (0-5)
  static int _mapGradeToQuality(int grade) {
    switch (grade) {
      case AppConstants.gradeForgot:
        return 1;
      case AppConstants.gradeVague:
        return 3;
      case AppConstants.gradeMastered:
        return 5;
      default:
        throw ArgumentError('Invalid grade: $grade. Must be 1, 2, or 3.');
    }
  }

  /// 计算新的间隔天数
  static double _calculateInterval(int quality, int repetitions, double previousIntervalDays, double ef) {
    if (quality < 3) {
      // 忘记: 间隔重置为 1 天
      return 1.0;
    }

    // 模糊/秒杀视为正确
    switch (repetitions) {
      case 0:
        return 1.0;
      case 1:
        return 6.0;
      default:
        return previousIntervalDays * ef;
    }
  }

  /// 更新 Easiness Factor
  /// 公式: ef = ef + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
  /// 下限: ef >= 1.3
  static double _updateEF(double ef, int quality) {
    final q = 5 - quality;
    final newEf = ef + (0.1 - q * (0.08 + q * 0.02));
    return newEf < 1.3 ? 1.3 : newEf;
  }

  /// 对卡片进行评分并返回更新后的卡片
  /// 
  /// [grade]: 1=忘记, 2=模糊, 3=秒杀
  static CardModel review(CardModel card, int grade) {
    final quality = _mapGradeToQuality(grade);
    
    // 计算新的 repetitions
    int newRepetitions;
    double previousIntervalDays;
    
    if (quality >= 3) {
      newRepetitions = card.repetitions + 1;
      previousIntervalDays = card.interval / 86400.0;
      if (previousIntervalDays < 1) previousIntervalDays = 1.0;
    } else {
      newRepetitions = 0;
      previousIntervalDays = card.interval / 86400.0;
      if (previousIntervalDays < 1) previousIntervalDays = 1.0;
    }

    // 计算新的间隔天数
    final intervalDays = _calculateInterval(
      quality,
      quality >= 3 ? card.repetitions : 0,
      previousIntervalDays,
      card.ef,
    );

    // 更新 EF
    final newEf = _updateEF(card.ef, quality);

    // 转换为秒
    final intervalSeconds = (intervalDays * 86400).round();
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    return card.copyWith(
      interval: intervalSeconds,
      nextReview: now + intervalSeconds,
      ef: double.parse(newEf.toStringAsFixed(2)),
      repetitions: newRepetitions,
    );
  }
}
