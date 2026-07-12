import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:papyrus/data/local/app_database.dart';
import 'package:papyrus/data/models/card_model.dart';
import 'package:papyrus/data/repositories/card_repository_impl.dart';
import 'package:papyrus/presentation/providers/study_provider.dart';

void main() {
  late AppDatabase db;
  late CardRepositoryImpl repository;
  late StudyProvider provider;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = CardRepositoryImpl(db);
    provider = StudyProvider(repository);
  });

  tearDown(() async {
    provider.dispose();
    await db.close();
  });

  test('distinguishes an empty card library from an empty due queue', () async {
    await provider.loadDueCards();

    expect(provider.state, StudyState.noCards);
    expect(provider.totalCount, 0);
    expect(provider.remainingDueCount, 0);

    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    await repository.add(
      CardModel(
        id: 'future',
        q: 'Future question',
        a: 'Future answer',
        nextReview: now + 3600,
      ),
    );
    await provider.loadDueCards();

    expect(provider.state, StudyState.noDueCards);
    expect(provider.totalCount, 1);
    expect(provider.remainingDueCount, 0);
  });

  test('reports total cards independently from the due queue', () async {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    await repository.add(
      CardModel(
        id: 'due',
        q: 'Due question',
        a: 'Due answer',
        nextReview: now - 1,
      ),
    );
    await repository.add(
      CardModel(
        id: 'future',
        q: 'Future question',
        a: 'Future answer',
        nextReview: now + 3600,
      ),
    );

    await provider.loadDueCards();

    expect(provider.state, StudyState.question);
    expect(provider.totalCount, 2);
    expect(provider.dueCount, 1);
    expect(provider.remainingDueCount, 1);
    expect(provider.currentCard?.id, 'due');
  });
}
