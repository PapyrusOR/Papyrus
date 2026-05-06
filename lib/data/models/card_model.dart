import '../../core/constants/app_constants.dart';

class CardModel {
  final String id;
  final String q;
  final String a;
  final int nextReview;
  final int interval;
  final double ef;
  final int repetitions;
  final List<String> tags;
  final int createdAt;

  CardModel({
    required this.id,
    required this.q,
    required this.a,
    this.nextReview = AppConstants.defaultNextReview,
    this.interval = AppConstants.defaultInterval,
    this.ef = AppConstants.defaultEasinessFactor,
    this.repetitions = AppConstants.defaultRepetitions,
    this.tags = const [],
    this.createdAt = 0,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] as String? ?? '',
      q: json['q'] as String? ?? '',
      a: json['a'] as String? ?? '',
      nextReview: (json['next_review'] as num?)?.toInt() ?? AppConstants.defaultNextReview,
      interval: (json['interval'] as num?)?.toInt() ?? AppConstants.defaultInterval,
      ef: (json['ef'] as num?)?.toDouble() ?? AppConstants.defaultEasinessFactor,
      repetitions: (json['repetitions'] as num?)?.toInt() ?? AppConstants.defaultRepetitions,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: (json['created_at'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'q': q,
    'a': a,
    'next_review': nextReview,
    'interval': interval,
    'ef': ef,
    'repetitions': repetitions,
    'tags': tags,
    'created_at': createdAt,
  };

  CardModel copyWith({
    String? id,
    String? q,
    String? a,
    int? nextReview,
    int? interval,
    double? ef,
    int? repetitions,
    List<String>? tags,
    int? createdAt,
  }) {
    return CardModel(
      id: id ?? this.id,
      q: q ?? this.q,
      a: a ?? this.a,
      nextReview: nextReview ?? this.nextReview,
      interval: interval ?? this.interval,
      ef: ef ?? this.ef,
      repetitions: repetitions ?? this.repetitions,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get isDue => nextReview <= DateTime.now().millisecondsSinceEpoch ~/ 1000;
}
