import 'package:flutter_test/flutter_test.dart';
import 'package:papyrus/data/models/card_model.dart';
import 'package:papyrus/domain/algorithms/sm2_engine.dart';

void main() {
  group('SM2Engine', () {
    late CardModel card;

    setUp(() {
      card = CardModel(
        id: '1',
        q: 'Q',
        a: 'A',
        nextReview: 0,
        interval: 0,
        ef: 2.5,
        repetitions: 0,
      );
    });

    test('grade 1 (forgot) resets repetitions and sets interval to 1 day', () {
      final reviewed = SM2Engine.review(card, 1);
      expect(reviewed.repetitions, 0);
      expect(reviewed.interval, 86400); // 1 day in seconds
      expect(reviewed.ef, lessThan(2.5)); // EF should decrease
      expect(reviewed.ef, greaterThanOrEqualTo(1.3));
      expect(reviewed.nextReview, greaterThan(DateTime.now().millisecondsSinceEpoch ~/ 1000));
    });

    test('grade 2 (vague) on first review sets interval to 1 day and increments repetitions', () {
      final reviewed = SM2Engine.review(card, 2);
      expect(reviewed.repetitions, 1);
      expect(reviewed.interval, 86400);
      expect(reviewed.ef, 2.36); // quality=3, EF = 2.5 + (0.1 - 2*(0.08+2*0.02)) = 2.36
    });

    test('grade 3 (mastered) on first review sets interval to 1 day and increments repetitions', () {
      final reviewed = SM2Engine.review(card, 3);
      expect(reviewed.repetitions, 1);
      expect(reviewed.interval, 86400);
      expect(reviewed.ef, 2.6); // quality=5, EF = 2.5 + 0.1 = 2.6
    });

    test('grade 3 on second review sets interval to 6 days', () {
      final firstReview = SM2Engine.review(card, 3);
      final secondReview = SM2Engine.review(firstReview, 3);
      expect(secondReview.repetitions, 2);
      expect(secondReview.interval, 6 * 86400);
    });

    test('grade 3 on third review multiplies interval by EF', () {
      final first = SM2Engine.review(card, 3);
      final second = SM2Engine.review(first, 3);
      final third = SM2Engine.review(second, 3);
      expect(third.repetitions, 3);
      // interval should be previous interval (6 days) * ef
      final expectedDays = 6 * second.ef;
      expect(third.interval, (expectedDays * 86400).round());
    });

    test('EF is capped at minimum 1.3', () {
      final lowEfCard = card.copyWith(ef: 1.3);
      final reviewed = SM2Engine.review(lowEfCard, 1);
      expect(reviewed.ef, 1.3);
    });

    test('EF is rounded to 2 decimal places', () {
      final reviewed = SM2Engine.review(card, 3);
      final efStr = reviewed.ef.toStringAsFixed(2);
      expect(reviewed.ef, double.parse(efStr));
    });

    test('throws on invalid grade', () {
      expect(() => SM2Engine.review(card, 0), throwsArgumentError);
      expect(() => SM2Engine.review(card, 4), throwsArgumentError);
    });
  });
}
