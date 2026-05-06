import 'package:flutter_test/flutter_test.dart';
import 'package:papyrus/core/constants/app_constants.dart';
import 'package:papyrus/data/models/card_model.dart';

void main() {
  group('CardModel', () {
    test('fromJson with all fields', () {
      final json = {
        'id': '1',
        'q': 'What is Flutter?',
        'a': 'A UI toolkit',
        'next_review': 1000,
        'interval': 86400,
        'ef': 2.6,
        'repetitions': 3,
        'tags': ['dev', 'mobile'],
      };
      final card = CardModel.fromJson(json);
      expect(card.id, '1');
      expect(card.q, 'What is Flutter?');
      expect(card.a, 'A UI toolkit');
      expect(card.nextReview, 1000);
      expect(card.interval, 86400);
      expect(card.ef, 2.6);
      expect(card.repetitions, 3);
      expect(card.tags, ['dev', 'mobile']);
    });

    test('fromJson with missing ef and repetitions defaults correctly', () {
      final json = {
        'id': '2',
        'q': 'Question',
        'a': 'Answer',
      };
      final card = CardModel.fromJson(json);
      expect(card.ef, AppConstants.defaultEasinessFactor);
      expect(card.repetitions, AppConstants.defaultRepetitions);
      expect(card.nextReview, AppConstants.defaultNextReview);
      expect(card.interval, AppConstants.defaultInterval);
    });

    test('toJson roundtrip', () {
      final card = CardModel(
        id: '3',
        q: 'Q',
        a: 'A',
        nextReview: 2000,
        interval: 43200,
        ef: 1.8,
        repetitions: 5,
        tags: ['a', 'b'],
      );
      final json = card.toJson();
      final restored = CardModel.fromJson(json);
      expect(restored.id, card.id);
      expect(restored.q, card.q);
      expect(restored.a, card.a);
      expect(restored.nextReview, card.nextReview);
      expect(restored.interval, card.interval);
      expect(restored.ef, card.ef);
      expect(restored.repetitions, card.repetitions);
      expect(restored.tags, card.tags);
    });

    test('isDue works correctly', () {
      final pastCard = CardModel(
        id: '4',
        q: 'Q',
        a: 'A',
        nextReview: 0,
      );
      expect(pastCard.isDue, true);

      final futureCard = CardModel(
        id: '5',
        q: 'Q',
        a: 'A',
        nextReview: DateTime.now().millisecondsSinceEpoch ~/ 1000 + 100000,
      );
      expect(futureCard.isDue, false);
    });
  });
}
