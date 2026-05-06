import 'package:flutter/material.dart';
import '../../data/models/card_model.dart';
import '../../data/repositories/card_repository.dart';

class CardProvider extends ChangeNotifier {
  final CardRepository _repository;

  CardProvider(this._repository);

  List<CardModel> _cards = [];
  bool _isLoading = false;
  String? _error;

  List<CardModel> get cards => List.unmodifiable(_cards);
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<CardModel> get dueCards {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return _cards.where((c) => c.nextReview <= now).toList();
  }

  int get totalCount => _cards.length;
  int get dueCount => dueCards.length;

  Future<void> loadCards() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _cards = await _repository.loadAll();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addCard(String question, String answer, {List<String> tags = const []}) async {
    final card = CardModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      q: question,
      a: answer,
      tags: tags,
    );
    await _repository.add(card);
    _cards.add(card);
    notifyListeners();
  }

  Future<void> updateCard(CardModel card) async {
    await _repository.update(card);
    final index = _cards.indexWhere((c) => c.id == card.id);
    if (index >= 0) {
      _cards[index] = card;
      notifyListeners();
    }
  }

  Future<void> deleteCard(String id) async {
    await _repository.delete(id);
    _cards.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  Future<void> search(String keyword) async {
    if (keyword.isEmpty) {
      await loadCards();
      return;
    }
    _cards = await _repository.search(keyword);
    notifyListeners();
  }

  Future<void> importFromText(String text) async {
    await _repository.importFromText(text);
    await loadCards();
  }
}
