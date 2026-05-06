import '../../data/models/card_model.dart';
import '../../data/repositories/card_repository.dart';
import '../../domain/services/review_scheduler.dart';
import '../services/tool_parser.dart';

/// AI 工具执行器
class ToolExecutor {
  final CardRepository _cardRepository;

  ToolExecutor(this._cardRepository);

  /// 执行工具调用，返回执行结果描述
  Future<String> execute(ToolCall call) async {
    switch (call.tool) {
      case 'create_card':
        return _createCard(call.params);
      case 'update_card':
        return _updateCard(call.params);
      case 'delete_card':
        return _deleteCard(call.params);
      case 'search_cards':
        return _searchCards(call.params);
      case 'get_card_stats':
        return _getStats();
      default:
        return '未知工具: ${call.tool}';
    }
  }

  Future<String> _createCard(Map<String, dynamic> params) async {
    final question = params['question'] as String? ?? '';
    final answer = params['answer'] as String? ?? '';
    final tags = (params['tags'] as List<dynamic>?)?.cast<String>() ?? [];

    if (question.isEmpty || answer.isEmpty) {
      return '创建失败: 题目和答案不能为空';
    }

    final card = CardModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      q: question,
      a: answer,
      tags: tags,
    );
    await _cardRepository.add(card);
    return '成功创建卡片: $question';
  }

  Future<String> _updateCard(Map<String, dynamic> params) async {
    final cardIndex = params['card_index'] as int?;
    if (cardIndex == null) return '更新失败: 缺少 card_index';

    final all = await _cardRepository.loadAll();
    if (cardIndex < 0 || cardIndex >= all.length) {
      return '更新失败: 卡片索引 $cardIndex 超出范围';
    }

    final card = all[cardIndex];
    final updated = card.copyWith(
      q: params['question'] as String? ?? card.q,
      a: params['answer'] as String? ?? card.a,
    );
    await _cardRepository.update(updated);
    return '成功更新卡片 #$cardIndex';
  }

  Future<String> _deleteCard(Map<String, dynamic> params) async {
    final cardIndex = params['card_index'] as int?;
    if (cardIndex == null) return '删除失败: 缺少 card_index';

    final all = await _cardRepository.loadAll();
    if (cardIndex < 0 || cardIndex >= all.length) {
      return '删除失败: 卡片索引 $cardIndex 超出范围';
    }

    final card = all[cardIndex];
    await _cardRepository.delete(card.id);
    return '成功删除卡片 #$cardIndex: ${card.q}';
  }

  Future<String> _searchCards(Map<String, dynamic> params) async {
    final keyword = params['keyword'] as String? ?? '';
    if (keyword.isEmpty) return '搜索失败: 关键词不能为空';

    final results = await _cardRepository.search(keyword);
    if (results.isEmpty) return '未找到包含 "$keyword" 的卡片';

    final buffer = StringBuffer();
    buffer.writeln('找到 ${results.length} 张卡片:');
    for (var i = 0; i < results.length; i++) {
      final card = results[i];
      buffer.writeln('${i + 1}. ${card.q}');
      if (card.a.length > 100) {
        buffer.writeln('   ${card.a.substring(0, 100)}...');
      } else {
        buffer.writeln('   ${card.a}');
      }
    }
    return buffer.toString();
  }

  Future<String> _getStats() async {
    final all = await _cardRepository.loadAll();
    final dueCount = ReviewScheduler.countDue(all);
    final total = all.length;

    return '学习统计:\n'
        '- 总卡片数: $total\n'
        '- 到期卡片数: $dueCount\n'
        '- 待复习比例: ${total > 0 ? (dueCount / total * 100).toStringAsFixed(1) : 0}%';
  }
}
