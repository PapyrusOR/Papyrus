import '../data/models/card_model.dart';
import '../data/repositories/card_repository.dart';
import '../domain/algorithms/sm2_engine.dart';

/// Executes structured card operations for the local MCP HTTP server.
class MCPToolHandler {
  final CardRepository _cardRepository;

  MCPToolHandler(this._cardRepository);

  Future<Map<String, dynamic>> execute(
    String tool,
    Map<String, dynamic> params,
  ) async {
    switch (tool) {
      case 'create_card':
        return _createCard(params);
      case 'update_card':
        return _updateCard(params);
      case 'delete_card':
        return _deleteCard(params);
      case 'list_cards':
        return _listCards(params);
      case 'get_card':
        return _getCard(params);
      case 'search_cards':
        return _searchCards(params);
      case 'get_due_cards':
        return _getDueCards();
      case 'review_card':
        return _reviewCard(params);
      case 'get_card_stats':
        return _getCardStats();
      default:
        throw MCPToolException('Unknown tool: $tool');
    }
  }

  Future<Map<String, dynamic>> _createCard(Map<String, dynamic> params) async {
    final card = CardModel(
      id: '${DateTime.now().microsecondsSinceEpoch}',
      q: _requiredString(params, 'question'),
      a: _requiredString(params, 'answer'),
      tags: _tags(params['tags']),
      createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );
    await _cardRepository.add(card);
    return {'card': card.toJson()};
  }

  Future<Map<String, dynamic>> _updateCard(Map<String, dynamic> params) async {
    final card = await _findCard(_requiredString(params, 'id'));
    final updated = card.copyWith(
      q: params['question'] is String ? params['question'] as String : card.q,
      a: params['answer'] is String ? params['answer'] as String : card.a,
      tags: params.containsKey('tags') ? _tags(params['tags']) : card.tags,
    );
    await _cardRepository.update(updated);
    return {'card': updated.toJson()};
  }

  Future<Map<String, dynamic>> _deleteCard(Map<String, dynamic> params) async {
    final card = await _findCard(_requiredString(params, 'id'));
    await _cardRepository.delete(card.id);
    return {'deleted_id': card.id};
  }

  Future<Map<String, dynamic>> _listCards(Map<String, dynamic> params) async {
    final query = params['query'];
    final cards = query is String && query.trim().isNotEmpty
        ? await _cardRepository.search(query.trim())
        : await _cardRepository.loadAll();
    return _cardsResult(cards);
  }

  Future<Map<String, dynamic>> _getCard(Map<String, dynamic> params) async {
    return {'card': (await _findCard(_requiredString(params, 'id'))).toJson()};
  }

  Future<Map<String, dynamic>> _searchCards(Map<String, dynamic> params) async {
    return _cardsResult(
      await _cardRepository.search(_requiredString(params, 'keyword')),
    );
  }

  Future<Map<String, dynamic>> _getDueCards() async {
    final results = await Future.wait([
      _cardRepository.getDueCards(),
      _cardRepository.countCards(),
    ]);
    final cards = results[0] as List<CardModel>;
    return {
      ..._cardsResult(cards),
      'due_count': cards.length,
      'total_cards': results[1] as int,
    };
  }

  Future<Map<String, dynamic>> _reviewCard(Map<String, dynamic> params) async {
    final grade = params['grade'];
    if (grade is! int || grade < 1 || grade > 3) {
      throw MCPToolException('grade must be an integer from 1 to 3');
    }
    final updated = SM2Engine.review(
      await _findCard(_requiredString(params, 'id')),
      grade,
    );
    await _cardRepository.update(updated);
    return {'card': updated.toJson()};
  }

  Future<Map<String, dynamic>> _getCardStats() async {
    final results = await Future.wait([
      _cardRepository.getDueCards(),
      _cardRepository.countCards(),
    ]);
    return {
      'due_count': (results[0] as List<CardModel>).length,
      'total_cards': results[1] as int,
    };
  }

  Map<String, dynamic> _cardsResult(List<CardModel> cards) => {
    'cards': cards.map((card) => card.toJson()).toList(),
    'total_cards': cards.length,
  };

  Future<CardModel> _findCard(String id) async {
    final cards = await _cardRepository.loadAll();
    for (final card in cards) {
      if (card.id == id) return card;
    }
    throw MCPToolException('Card not found: $id');
  }

  String _requiredString(Map<String, dynamic> params, String name) {
    final value = params[name];
    if (value is! String || value.trim().isEmpty) {
      throw MCPToolException('$name must be a non-empty string');
    }
    return value.trim();
  }

  List<String> _tags(Object? value) {
    if (value == null) return const [];
    if (value is! List || value.any((tag) => tag is! String)) {
      throw MCPToolException('tags must be an array of strings');
    }
    return value.cast<String>();
  }
}

class MCPToolException implements Exception {
  final String message;
  MCPToolException(this.message);
  @override
  String toString() => message;
}
