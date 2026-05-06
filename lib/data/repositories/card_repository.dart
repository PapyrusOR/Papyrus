import '../models/card_model.dart';

abstract class CardRepository {
  Future<List<CardModel>> loadAll();
  Future<List<CardModel>> getDueCards();
  Future<void> saveAll(List<CardModel> cards);
  Future<void> add(CardModel card);
  Future<void> update(CardModel card);
  Future<void> delete(String id);
  Future<List<CardModel>> search(String keyword);
  Future<void> importFromText(String text);
}
