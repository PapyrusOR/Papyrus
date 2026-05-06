import '../../data/models/card_model.dart';

/// 到期卡片调度器
class ReviewScheduler {
  ReviewScheduler._();

  /// 从卡片列表中筛选出到期卡片，并按 next_review 升序排列
  static List<CardModel> getDueCards(List<CardModel> cards) {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final due = cards.where((c) => c.nextReview <= now).toList();
    due.sort((a, b) => a.nextReview.compareTo(b.nextReview));
    return due;
  }

  /// 获取下一张到期卡片
  static CardModel? getNextDueCard(List<CardModel> cards) {
    final due = getDueCards(cards);
    return due.isNotEmpty ? due.first : null;
  }

  /// 统计到期卡片数量
  static int countDue(List<CardModel> cards) {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return cards.where((c) => c.nextReview <= now).length;
  }
}
