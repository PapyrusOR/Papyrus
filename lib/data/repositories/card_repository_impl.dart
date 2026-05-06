import 'package:drift/drift.dart';
import '../../core/constants/app_constants.dart';
import '../local/app_database.dart';
import '../models/card_model.dart';
import 'card_repository.dart';

class CardRepositoryImpl implements CardRepository {
  final AppDatabase _db;

  CardRepositoryImpl(this._db);

  CardModel _toModel(Card c) => CardModel(
        id: c.id,
        q: c.q,
        a: c.a,
        nextReview: c.nextReview,
        interval: c.interval,
        ef: c.ef,
        repetitions: c.repetitions,
        tags: c.tags.isEmpty ? [] : c.tags.split(','),
      );

  CardsCompanion _toCompanion(CardModel card) => CardsCompanion(
        id: Value(card.id),
        q: Value(card.q),
        a: Value(card.a),
        nextReview: Value(card.nextReview),
        interval: Value(card.interval),
        ef: Value(card.ef),
        repetitions: Value(card.repetitions),
        tags: Value(card.tags.join(',')),
        createdAt: Value(card.createdAt),
      );

  @override
  Future<List<CardModel>> loadAll() async {
    final rows = await _db.select(_db.cards).get();
    return rows.map(_toModel).toList();
  }

  @override
  Future<List<CardModel>> getDueCards() async {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final query = _db.select(_db.cards)
      ..where((c) => c.nextReview.isSmallerOrEqualValue(now))
      ..orderBy([(c) => OrderingTerm.asc(c.nextReview)]);
    final rows = await query.get();
    return rows.map(_toModel).toList();
  }

  @override
  Future<void> saveAll(List<CardModel> cards) async {
    await _db.transaction(() async {
      await _db.delete(_db.cards).go();
      for (final card in cards) {
        await _db.into(_db.cards).insert(_toCompanion(card));
      }
    });
  }

  @override
  Future<void> add(CardModel card) async {
    await _db.into(_db.cards).insert(_toCompanion(card));
  }

  @override
  Future<void> update(CardModel card) async {
    await _db.update(_db.cards).replace(_toCompanion(card));
  }

  @override
  Future<void> delete(String id) async {
    await (_db.delete(_db.cards)..where((c) => c.id.equals(id))).go();
  }

  @override
  Future<List<CardModel>> search(String keyword) async {
    final lower = '%${keyword.toLowerCase()}%';
    final query = _db.select(_db.cards)
      ..where((c) =>
          c.q.lower().like(lower) | c.a.lower().like(lower));
    final rows = await query.get();
    return rows.map(_toModel).toList();
  }

  @override
  Future<void> importFromText(String text) async {
    final blocks = text.split(RegExp(r'\n\s*\n'));
    final cards = <CardsCompanion>[];
    for (final block in blocks) {
      final trimmed = block.trim();
      if (trimmed.isEmpty) continue;
      final parts = trimmed.split('===');
      if (parts.length >= 2) {
        final q = parts[0].trim();
        final a = parts[1].trim();
        if (q.isNotEmpty && a.isNotEmpty) {
          cards.add(CardsCompanion(
            id: Value(DateTime.now().millisecondsSinceEpoch.toString() + '_${cards.length}'),
            q: Value(q),
            a: Value(a),
            nextReview: const Value(AppConstants.defaultNextReview),
            interval: const Value(AppConstants.defaultInterval),
            ef: const Value(AppConstants.defaultEasinessFactor),
            repetitions: const Value(AppConstants.defaultRepetitions),
            tags: const Value(''),
            createdAt: Value(DateTime.now().millisecondsSinceEpoch ~/ 1000),
          ));
        }
      }
    }
    if (cards.isNotEmpty) {
      await _db.batch((b) => b.insertAll(_db.cards, cards));
    }
  }
}
