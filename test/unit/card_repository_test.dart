import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:papyrus/data/local/app_database.dart';
import 'package:papyrus/data/models/card_model.dart';
import 'package:papyrus/data/repositories/card_repository_impl.dart';

void main() {
  late AppDatabase db;
  late CardRepositoryImpl repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = CardRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('CardRepositoryImpl', () {
    test('loadAll returns empty list when no cards', () async {
      final cards = await repo.loadAll();
      expect(cards, isEmpty);
    });

    test('add and loadAll returns added card', () async {
      final card = CardModel(id: '1', q: 'Q1', a: 'A1');
      await repo.add(card);

      final cards = await repo.loadAll();
      expect(cards.length, 1);
      expect(cards.first.id, '1');
      expect(cards.first.q, 'Q1');
      expect(cards.first.a, 'A1');
    });

    test('update modifies existing card', () async {
      final card = CardModel(id: '1', q: 'Q1', a: 'A1');
      await repo.add(card);

      final updated = card.copyWith(q: 'Updated Q', a: 'Updated A');
      await repo.update(updated);

      final cards = await repo.loadAll();
      expect(cards.first.q, 'Updated Q');
      expect(cards.first.a, 'Updated A');
    });

    test('delete removes card', () async {
      await repo.add(CardModel(id: '1', q: 'Q1', a: 'A1'));
      await repo.add(CardModel(id: '2', q: 'Q2', a: 'A2'));

      await repo.delete('1');

      final cards = await repo.loadAll();
      expect(cards.length, 1);
      expect(cards.first.id, '2');
    });

    test('search filters by question and answer', () async {
      await repo.add(CardModel(id: '1', q: 'Flutter basics', a: 'UI toolkit'));
      await repo.add(CardModel(id: '2', q: 'Dart language', a: 'Programming language'));
      await repo.add(CardModel(id: '3', q: 'React native', a: 'Mobile framework'));

      final results = await repo.search('flutter');
      expect(results.length, 1);
      expect(results.first.id, '1');

      final results2 = await repo.search('language');
      expect(results2.length, 1);
      expect(results2.first.id, '2');
    });

    test('getDueCards returns only due cards sorted by nextReview', () async {
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      await repo.add(CardModel(id: '1', q: 'Past', a: 'A', nextReview: now - 100));
      await repo.add(CardModel(id: '2', q: 'Future', a: 'A', nextReview: now + 1000));
      await repo.add(CardModel(id: '3', q: 'Past2', a: 'A', nextReview: now - 50));

      final due = await repo.getDueCards();
      expect(due.length, 2);
      expect(due[0].id, '1'); // earlier nextReview first
      expect(due[1].id, '3');
    });

    test('getDueCards returns empty when no due cards', () async {
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      await repo.add(CardModel(id: '1', q: 'Future', a: 'A', nextReview: now + 1000));

      final due = await repo.getDueCards();
      expect(due, isEmpty);
    });

    test('saveAll replaces all cards', () async {
      await repo.add(CardModel(id: '1', q: 'Old', a: 'A'));
      await repo.saveAll([
        CardModel(id: '2', q: 'New1', a: 'A'),
        CardModel(id: '3', q: 'New2', a: 'A'),
      ]);

      final cards = await repo.loadAll();
      expect(cards.length, 2);
      expect(cards.map((c) => c.id).toList(), ['2', '3']);
    });

    test('importFromText parses Q===A format', () async {
      const text = 'Question 1 === Answer 1\n\nQuestion 2 === Answer 2';
      await repo.importFromText(text);

      final cards = await repo.loadAll();
      expect(cards.length, 2);
      expect(cards[0].q, 'Question 1');
      expect(cards[0].a, 'Answer 1');
      expect(cards[1].q, 'Question 2');
      expect(cards[1].a, 'Answer 2');
    });

    test('tags are stored and retrieved correctly', () async {
      final card = CardModel(id: '1', q: 'Q', a: 'A', tags: ['dart', 'flutter']);
      await repo.add(card);

      final cards = await repo.loadAll();
      expect(cards.first.tags, ['dart', 'flutter']);
    });
  });
}
