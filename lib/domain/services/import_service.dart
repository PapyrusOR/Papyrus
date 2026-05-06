import '../../core/utils/id_generator.dart';
import '../../data/models/card_model.dart';

/// 批量导入服务
/// 文件格式: 以空行分隔的块，每块内使用 === 分割题目和答案
class ImportService {
  ImportService._();

  static List<CardModel> parseText(String text) {
    final cards = <CardModel>[];
    final blocks = text.split(RegExp(r'\n\s*\n'));

    for (final block in blocks) {
      final trimmed = block.trim();
      if (trimmed.isEmpty) continue;

      final parts = trimmed.split('===');
      if (parts.length >= 2) {
        final q = parts[0].trim();
        final a = parts[1].trim();
        if (q.isNotEmpty && a.isNotEmpty) {
          cards.add(CardModel(
            id: '${IdGenerator.timestampId()}_${cards.length}',
            q: q,
            a: a,
          ));
        }
      }
    }

    return cards;
  }
}
