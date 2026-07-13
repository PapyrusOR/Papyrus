import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/card_model.dart';
import '../../data/repositories/card_repository.dart';
import '../../domain/algorithms/sm2_engine.dart';

enum StudyState { question, answer, noCards, noDueCards }

class StudyProvider extends ChangeNotifier {
  final CardRepository _repository;

  StudyProvider(this._repository);

  List<CardModel> _dueCards = [];
  int _currentIndex = 0;
  StudyState _state = StudyState.noCards;
  int _totalCount = 0;
  bool _canGrade = false;
  Timer? _debounceTimer;
  Timer? _dueCheckTimer;
  bool _isLoading = false;

  StudyState get state => _state;
  bool get canGrade => _canGrade;
  bool get isLoading => _isLoading;

  CardModel? get currentCard =>
      _dueCards.isNotEmpty && _currentIndex < _dueCards.length
      ? _dueCards[_currentIndex]
      : null;

  int get dueCount => _dueCards.length;
  int get totalCount => _totalCount;
  int get currentIndex => _currentIndex;
  int get remainingDueCount =>
      (_dueCards.length - _currentIndex).clamp(0, _dueCards.length);

  Future<void> loadDueCards() async {
    _isLoading = true;
    notifyListeners();

    final results = await Future.wait([
      _repository.getDueCards(),
      _repository.countCards(),
    ]);
    _dueCards = results[0] as List<CardModel>;
    _totalCount = results[1] as int;
    _currentIndex = 0;
    _state = _dueCards.isNotEmpty
        ? StudyState.question
        : _totalCount == 0
        ? StudyState.noCards
        : StudyState.noDueCards;
    _canGrade = false;
    _isLoading = false;
    _startDueCheckTimer();
    notifyListeners();
  }

  void showAnswer() {
    if (_state != StudyState.question) return;
    _state = StudyState.answer;
    _canGrade = false;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(AppConstants.gradeDebounceDuration, () {
      _canGrade = true;
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> grade(int grade) async {
    if (_state != StudyState.answer || !_canGrade) return;
    final card = currentCard;
    if (card == null) return;

    final updated = SM2Engine.review(card, grade);
    await _repository.update(updated);

    _currentIndex++;
    if (_currentIndex >= _dueCards.length) {
      // 重新加载，看看是否还有新到期的
      await loadDueCards();
    } else {
      _state = StudyState.question;
      _canGrade = false;
      notifyListeners();
    }
  }

  void _startDueCheckTimer() {
    _dueCheckTimer?.cancel();
    if (_state == StudyState.noCards || _state == StudyState.noDueCards) {
      _dueCheckTimer = Timer.periodic(AppConstants.dueCheckInterval, (_) {
        loadDueCards();
      });
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _dueCheckTimer?.cancel();
    super.dispose();
  }
}
