// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CardsTable extends Cards with TableInfo<$CardsTable, Card> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qMeta = const VerificationMeta('q');
  @override
  late final GeneratedColumn<String> q = GeneratedColumn<String>(
    'q',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aMeta = const VerificationMeta('a');
  @override
  late final GeneratedColumn<String> a = GeneratedColumn<String>(
    'a',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextReviewMeta = const VerificationMeta(
    'nextReview',
  );
  @override
  late final GeneratedColumn<int> nextReview = GeneratedColumn<int>(
    'next_review',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intervalMeta = const VerificationMeta(
    'interval',
  );
  @override
  late final GeneratedColumn<int> interval = GeneratedColumn<int>(
    'interval',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _efMeta = const VerificationMeta('ef');
  @override
  late final GeneratedColumn<double> ef = GeneratedColumn<double>(
    'ef',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(2.5),
  );
  static const VerificationMeta _repetitionsMeta = const VerificationMeta(
    'repetitions',
  );
  @override
  late final GeneratedColumn<int> repetitions = GeneratedColumn<int>(
    'repetitions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    q,
    a,
    nextReview,
    interval,
    ef,
    repetitions,
    tags,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<Card> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('q')) {
      context.handle(_qMeta, q.isAcceptableOrUnknown(data['q']!, _qMeta));
    } else if (isInserting) {
      context.missing(_qMeta);
    }
    if (data.containsKey('a')) {
      context.handle(_aMeta, a.isAcceptableOrUnknown(data['a']!, _aMeta));
    } else if (isInserting) {
      context.missing(_aMeta);
    }
    if (data.containsKey('next_review')) {
      context.handle(
        _nextReviewMeta,
        nextReview.isAcceptableOrUnknown(data['next_review']!, _nextReviewMeta),
      );
    } else if (isInserting) {
      context.missing(_nextReviewMeta);
    }
    if (data.containsKey('interval')) {
      context.handle(
        _intervalMeta,
        interval.isAcceptableOrUnknown(data['interval']!, _intervalMeta),
      );
    } else if (isInserting) {
      context.missing(_intervalMeta);
    }
    if (data.containsKey('ef')) {
      context.handle(_efMeta, ef.isAcceptableOrUnknown(data['ef']!, _efMeta));
    }
    if (data.containsKey('repetitions')) {
      context.handle(
        _repetitionsMeta,
        repetitions.isAcceptableOrUnknown(
          data['repetitions']!,
          _repetitionsMeta,
        ),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Card map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Card(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      q: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}q'],
      )!,
      a: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}a'],
      )!,
      nextReview: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_review'],
      )!,
      interval: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval'],
      )!,
      ef: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ef'],
      )!,
      repetitions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repetitions'],
      )!,
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CardsTable createAlias(String alias) {
    return $CardsTable(attachedDatabase, alias);
  }
}

class Card extends DataClass implements Insertable<Card> {
  final String id;
  final String q;
  final String a;
  final int nextReview;
  final int interval;
  final double ef;
  final int repetitions;
  final String tags;
  final int createdAt;
  const Card({
    required this.id,
    required this.q,
    required this.a,
    required this.nextReview,
    required this.interval,
    required this.ef,
    required this.repetitions,
    required this.tags,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['q'] = Variable<String>(q);
    map['a'] = Variable<String>(a);
    map['next_review'] = Variable<int>(nextReview);
    map['interval'] = Variable<int>(interval);
    map['ef'] = Variable<double>(ef);
    map['repetitions'] = Variable<int>(repetitions);
    map['tags'] = Variable<String>(tags);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  CardsCompanion toCompanion(bool nullToAbsent) {
    return CardsCompanion(
      id: Value(id),
      q: Value(q),
      a: Value(a),
      nextReview: Value(nextReview),
      interval: Value(interval),
      ef: Value(ef),
      repetitions: Value(repetitions),
      tags: Value(tags),
      createdAt: Value(createdAt),
    );
  }

  factory Card.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Card(
      id: serializer.fromJson<String>(json['id']),
      q: serializer.fromJson<String>(json['q']),
      a: serializer.fromJson<String>(json['a']),
      nextReview: serializer.fromJson<int>(json['nextReview']),
      interval: serializer.fromJson<int>(json['interval']),
      ef: serializer.fromJson<double>(json['ef']),
      repetitions: serializer.fromJson<int>(json['repetitions']),
      tags: serializer.fromJson<String>(json['tags']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'q': serializer.toJson<String>(q),
      'a': serializer.toJson<String>(a),
      'nextReview': serializer.toJson<int>(nextReview),
      'interval': serializer.toJson<int>(interval),
      'ef': serializer.toJson<double>(ef),
      'repetitions': serializer.toJson<int>(repetitions),
      'tags': serializer.toJson<String>(tags),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  Card copyWith({
    String? id,
    String? q,
    String? a,
    int? nextReview,
    int? interval,
    double? ef,
    int? repetitions,
    String? tags,
    int? createdAt,
  }) => Card(
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
  Card copyWithCompanion(CardsCompanion data) {
    return Card(
      id: data.id.present ? data.id.value : this.id,
      q: data.q.present ? data.q.value : this.q,
      a: data.a.present ? data.a.value : this.a,
      nextReview: data.nextReview.present
          ? data.nextReview.value
          : this.nextReview,
      interval: data.interval.present ? data.interval.value : this.interval,
      ef: data.ef.present ? data.ef.value : this.ef,
      repetitions: data.repetitions.present
          ? data.repetitions.value
          : this.repetitions,
      tags: data.tags.present ? data.tags.value : this.tags,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Card(')
          ..write('id: $id, ')
          ..write('q: $q, ')
          ..write('a: $a, ')
          ..write('nextReview: $nextReview, ')
          ..write('interval: $interval, ')
          ..write('ef: $ef, ')
          ..write('repetitions: $repetitions, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    q,
    a,
    nextReview,
    interval,
    ef,
    repetitions,
    tags,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Card &&
          other.id == this.id &&
          other.q == this.q &&
          other.a == this.a &&
          other.nextReview == this.nextReview &&
          other.interval == this.interval &&
          other.ef == this.ef &&
          other.repetitions == this.repetitions &&
          other.tags == this.tags &&
          other.createdAt == this.createdAt);
}

class CardsCompanion extends UpdateCompanion<Card> {
  final Value<String> id;
  final Value<String> q;
  final Value<String> a;
  final Value<int> nextReview;
  final Value<int> interval;
  final Value<double> ef;
  final Value<int> repetitions;
  final Value<String> tags;
  final Value<int> createdAt;
  final Value<int> rowid;
  const CardsCompanion({
    this.id = const Value.absent(),
    this.q = const Value.absent(),
    this.a = const Value.absent(),
    this.nextReview = const Value.absent(),
    this.interval = const Value.absent(),
    this.ef = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.tags = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CardsCompanion.insert({
    required String id,
    required String q,
    required String a,
    required int nextReview,
    required int interval,
    this.ef = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.tags = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       q = Value(q),
       a = Value(a),
       nextReview = Value(nextReview),
       interval = Value(interval);
  static Insertable<Card> custom({
    Expression<String>? id,
    Expression<String>? q,
    Expression<String>? a,
    Expression<int>? nextReview,
    Expression<int>? interval,
    Expression<double>? ef,
    Expression<int>? repetitions,
    Expression<String>? tags,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (q != null) 'q': q,
      if (a != null) 'a': a,
      if (nextReview != null) 'next_review': nextReview,
      if (interval != null) 'interval': interval,
      if (ef != null) 'ef': ef,
      if (repetitions != null) 'repetitions': repetitions,
      if (tags != null) 'tags': tags,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CardsCompanion copyWith({
    Value<String>? id,
    Value<String>? q,
    Value<String>? a,
    Value<int>? nextReview,
    Value<int>? interval,
    Value<double>? ef,
    Value<int>? repetitions,
    Value<String>? tags,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return CardsCompanion(
      id: id ?? this.id,
      q: q ?? this.q,
      a: a ?? this.a,
      nextReview: nextReview ?? this.nextReview,
      interval: interval ?? this.interval,
      ef: ef ?? this.ef,
      repetitions: repetitions ?? this.repetitions,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (q.present) {
      map['q'] = Variable<String>(q.value);
    }
    if (a.present) {
      map['a'] = Variable<String>(a.value);
    }
    if (nextReview.present) {
      map['next_review'] = Variable<int>(nextReview.value);
    }
    if (interval.present) {
      map['interval'] = Variable<int>(interval.value);
    }
    if (ef.present) {
      map['ef'] = Variable<double>(ef.value);
    }
    if (repetitions.present) {
      map['repetitions'] = Variable<int>(repetitions.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardsCompanion(')
          ..write('id: $id, ')
          ..write('q: $q, ')
          ..write('a: $a, ')
          ..write('nextReview: $nextReview, ')
          ..write('interval: $interval, ')
          ..write('ef: $ef, ')
          ..write('repetitions: $repetitions, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiProvidersTable extends AiProviders
    with TableInfo<$AiProvidersTable, AiProvider> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiProvidersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _apiKeyMeta = const VerificationMeta('apiKey');
  @override
  late final GeneratedColumn<String> apiKey = GeneratedColumn<String>(
    'api_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _baseUrlMeta = const VerificationMeta(
    'baseUrl',
  );
  @override
  late final GeneratedColumn<String> baseUrl = GeneratedColumn<String>(
    'base_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, apiKey, baseUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_providers';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiProvider> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('api_key')) {
      context.handle(
        _apiKeyMeta,
        apiKey.isAcceptableOrUnknown(data['api_key']!, _apiKeyMeta),
      );
    }
    if (data.containsKey('base_url')) {
      context.handle(
        _baseUrlMeta,
        baseUrl.isAcceptableOrUnknown(data['base_url']!, _baseUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_baseUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiProvider map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiProvider(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      apiKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}api_key'],
      ),
      baseUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_url'],
      )!,
    );
  }

  @override
  $AiProvidersTable createAlias(String alias) {
    return $AiProvidersTable(attachedDatabase, alias);
  }
}

class AiProvider extends DataClass implements Insertable<AiProvider> {
  final String id;
  final String? apiKey;
  final String baseUrl;
  const AiProvider({required this.id, this.apiKey, required this.baseUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || apiKey != null) {
      map['api_key'] = Variable<String>(apiKey);
    }
    map['base_url'] = Variable<String>(baseUrl);
    return map;
  }

  AiProvidersCompanion toCompanion(bool nullToAbsent) {
    return AiProvidersCompanion(
      id: Value(id),
      apiKey: apiKey == null && nullToAbsent
          ? const Value.absent()
          : Value(apiKey),
      baseUrl: Value(baseUrl),
    );
  }

  factory AiProvider.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiProvider(
      id: serializer.fromJson<String>(json['id']),
      apiKey: serializer.fromJson<String?>(json['apiKey']),
      baseUrl: serializer.fromJson<String>(json['baseUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'apiKey': serializer.toJson<String?>(apiKey),
      'baseUrl': serializer.toJson<String>(baseUrl),
    };
  }

  AiProvider copyWith({
    String? id,
    Value<String?> apiKey = const Value.absent(),
    String? baseUrl,
  }) => AiProvider(
    id: id ?? this.id,
    apiKey: apiKey.present ? apiKey.value : this.apiKey,
    baseUrl: baseUrl ?? this.baseUrl,
  );
  AiProvider copyWithCompanion(AiProvidersCompanion data) {
    return AiProvider(
      id: data.id.present ? data.id.value : this.id,
      apiKey: data.apiKey.present ? data.apiKey.value : this.apiKey,
      baseUrl: data.baseUrl.present ? data.baseUrl.value : this.baseUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiProvider(')
          ..write('id: $id, ')
          ..write('apiKey: $apiKey, ')
          ..write('baseUrl: $baseUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, apiKey, baseUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiProvider &&
          other.id == this.id &&
          other.apiKey == this.apiKey &&
          other.baseUrl == this.baseUrl);
}

class AiProvidersCompanion extends UpdateCompanion<AiProvider> {
  final Value<String> id;
  final Value<String?> apiKey;
  final Value<String> baseUrl;
  final Value<int> rowid;
  const AiProvidersCompanion({
    this.id = const Value.absent(),
    this.apiKey = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AiProvidersCompanion.insert({
    required String id,
    this.apiKey = const Value.absent(),
    required String baseUrl,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       baseUrl = Value(baseUrl);
  static Insertable<AiProvider> custom({
    Expression<String>? id,
    Expression<String>? apiKey,
    Expression<String>? baseUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (apiKey != null) 'api_key': apiKey,
      if (baseUrl != null) 'base_url': baseUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AiProvidersCompanion copyWith({
    Value<String>? id,
    Value<String?>? apiKey,
    Value<String>? baseUrl,
    Value<int>? rowid,
  }) {
    return AiProvidersCompanion(
      id: id ?? this.id,
      apiKey: apiKey ?? this.apiKey,
      baseUrl: baseUrl ?? this.baseUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (apiKey.present) {
      map['api_key'] = Variable<String>(apiKey.value);
    }
    if (baseUrl.present) {
      map['base_url'] = Variable<String>(baseUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiProvidersCompanion(')
          ..write('id: $id, ')
          ..write('apiKey: $apiKey, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiProviderModelsTable extends AiProviderModels
    with TableInfo<$AiProviderModelsTable, AiProviderModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiProviderModelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<String> providerId = GeneratedColumn<String>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelNameMeta = const VerificationMeta(
    'modelName',
  );
  @override
  late final GeneratedColumn<String> modelName = GeneratedColumn<String>(
    'model_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [providerId, modelName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_provider_models';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiProviderModel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('model_name')) {
      context.handle(
        _modelNameMeta,
        modelName.isAcceptableOrUnknown(data['model_name']!, _modelNameMeta),
      );
    } else if (isInserting) {
      context.missing(_modelNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {providerId, modelName};
  @override
  AiProviderModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiProviderModel(
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider_id'],
      )!,
      modelName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_name'],
      )!,
    );
  }

  @override
  $AiProviderModelsTable createAlias(String alias) {
    return $AiProviderModelsTable(attachedDatabase, alias);
  }
}

class AiProviderModel extends DataClass implements Insertable<AiProviderModel> {
  final String providerId;
  final String modelName;
  const AiProviderModel({required this.providerId, required this.modelName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['provider_id'] = Variable<String>(providerId);
    map['model_name'] = Variable<String>(modelName);
    return map;
  }

  AiProviderModelsCompanion toCompanion(bool nullToAbsent) {
    return AiProviderModelsCompanion(
      providerId: Value(providerId),
      modelName: Value(modelName),
    );
  }

  factory AiProviderModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiProviderModel(
      providerId: serializer.fromJson<String>(json['providerId']),
      modelName: serializer.fromJson<String>(json['modelName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'providerId': serializer.toJson<String>(providerId),
      'modelName': serializer.toJson<String>(modelName),
    };
  }

  AiProviderModel copyWith({String? providerId, String? modelName}) =>
      AiProviderModel(
        providerId: providerId ?? this.providerId,
        modelName: modelName ?? this.modelName,
      );
  AiProviderModel copyWithCompanion(AiProviderModelsCompanion data) {
    return AiProviderModel(
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      modelName: data.modelName.present ? data.modelName.value : this.modelName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiProviderModel(')
          ..write('providerId: $providerId, ')
          ..write('modelName: $modelName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(providerId, modelName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiProviderModel &&
          other.providerId == this.providerId &&
          other.modelName == this.modelName);
}

class AiProviderModelsCompanion extends UpdateCompanion<AiProviderModel> {
  final Value<String> providerId;
  final Value<String> modelName;
  final Value<int> rowid;
  const AiProviderModelsCompanion({
    this.providerId = const Value.absent(),
    this.modelName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AiProviderModelsCompanion.insert({
    required String providerId,
    required String modelName,
    this.rowid = const Value.absent(),
  }) : providerId = Value(providerId),
       modelName = Value(modelName);
  static Insertable<AiProviderModel> custom({
    Expression<String>? providerId,
    Expression<String>? modelName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (providerId != null) 'provider_id': providerId,
      if (modelName != null) 'model_name': modelName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AiProviderModelsCompanion copyWith({
    Value<String>? providerId,
    Value<String>? modelName,
    Value<int>? rowid,
  }) {
    return AiProviderModelsCompanion(
      providerId: providerId ?? this.providerId,
      modelName: modelName ?? this.modelName,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (providerId.present) {
      map['provider_id'] = Variable<String>(providerId.value);
    }
    if (modelName.present) {
      map['model_name'] = Variable<String>(modelName.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiProviderModelsCompanion(')
          ..write('providerId: $providerId, ')
          ..write('modelName: $modelName, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiSettingsTable extends AiSettings
    with TableInfo<$AiSettingsTable, AiSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _currentProviderMeta = const VerificationMeta(
    'currentProvider',
  );
  @override
  late final GeneratedColumn<String> currentProvider = GeneratedColumn<String>(
    'current_provider',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentModelMeta = const VerificationMeta(
    'currentModel',
  );
  @override
  late final GeneratedColumn<String> currentModel = GeneratedColumn<String>(
    'current_model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _temperatureMeta = const VerificationMeta(
    'temperature',
  );
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
    'temperature',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.7),
  );
  static const VerificationMeta _topPMeta = const VerificationMeta('topP');
  @override
  late final GeneratedColumn<double> topP = GeneratedColumn<double>(
    'top_p',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.9),
  );
  static const VerificationMeta _maxTokensMeta = const VerificationMeta(
    'maxTokens',
  );
  @override
  late final GeneratedColumn<int> maxTokens = GeneratedColumn<int>(
    'max_tokens',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2000),
  );
  static const VerificationMeta _presencePenaltyMeta = const VerificationMeta(
    'presencePenalty',
  );
  @override
  late final GeneratedColumn<double> presencePenalty = GeneratedColumn<double>(
    'presence_penalty',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _frequencyPenaltyMeta = const VerificationMeta(
    'frequencyPenalty',
  );
  @override
  late final GeneratedColumn<double> frequencyPenalty = GeneratedColumn<double>(
    'frequency_penalty',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _autoHintMeta = const VerificationMeta(
    'autoHint',
  );
  @override
  late final GeneratedColumn<bool> autoHint = GeneratedColumn<bool>(
    'auto_hint',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auto_hint" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _autoExplainMeta = const VerificationMeta(
    'autoExplain',
  );
  @override
  late final GeneratedColumn<bool> autoExplain = GeneratedColumn<bool>(
    'auto_explain',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auto_explain" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _contextLengthMeta = const VerificationMeta(
    'contextLength',
  );
  @override
  late final GeneratedColumn<int> contextLength = GeneratedColumn<int>(
    'context_length',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    currentProvider,
    currentModel,
    temperature,
    topP,
    maxTokens,
    presencePenalty,
    frequencyPenalty,
    autoHint,
    autoExplain,
    contextLength,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('current_provider')) {
      context.handle(
        _currentProviderMeta,
        currentProvider.isAcceptableOrUnknown(
          data['current_provider']!,
          _currentProviderMeta,
        ),
      );
    }
    if (data.containsKey('current_model')) {
      context.handle(
        _currentModelMeta,
        currentModel.isAcceptableOrUnknown(
          data['current_model']!,
          _currentModelMeta,
        ),
      );
    }
    if (data.containsKey('temperature')) {
      context.handle(
        _temperatureMeta,
        temperature.isAcceptableOrUnknown(
          data['temperature']!,
          _temperatureMeta,
        ),
      );
    }
    if (data.containsKey('top_p')) {
      context.handle(
        _topPMeta,
        topP.isAcceptableOrUnknown(data['top_p']!, _topPMeta),
      );
    }
    if (data.containsKey('max_tokens')) {
      context.handle(
        _maxTokensMeta,
        maxTokens.isAcceptableOrUnknown(data['max_tokens']!, _maxTokensMeta),
      );
    }
    if (data.containsKey('presence_penalty')) {
      context.handle(
        _presencePenaltyMeta,
        presencePenalty.isAcceptableOrUnknown(
          data['presence_penalty']!,
          _presencePenaltyMeta,
        ),
      );
    }
    if (data.containsKey('frequency_penalty')) {
      context.handle(
        _frequencyPenaltyMeta,
        frequencyPenalty.isAcceptableOrUnknown(
          data['frequency_penalty']!,
          _frequencyPenaltyMeta,
        ),
      );
    }
    if (data.containsKey('auto_hint')) {
      context.handle(
        _autoHintMeta,
        autoHint.isAcceptableOrUnknown(data['auto_hint']!, _autoHintMeta),
      );
    }
    if (data.containsKey('auto_explain')) {
      context.handle(
        _autoExplainMeta,
        autoExplain.isAcceptableOrUnknown(
          data['auto_explain']!,
          _autoExplainMeta,
        ),
      );
    }
    if (data.containsKey('context_length')) {
      context.handle(
        _contextLengthMeta,
        contextLength.isAcceptableOrUnknown(
          data['context_length']!,
          _contextLengthMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      currentProvider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_provider'],
      ),
      currentModel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_model'],
      ),
      temperature: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature'],
      )!,
      topP: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}top_p'],
      )!,
      maxTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_tokens'],
      )!,
      presencePenalty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}presence_penalty'],
      )!,
      frequencyPenalty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}frequency_penalty'],
      )!,
      autoHint: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_hint'],
      )!,
      autoExplain: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_explain'],
      )!,
      contextLength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}context_length'],
      )!,
    );
  }

  @override
  $AiSettingsTable createAlias(String alias) {
    return $AiSettingsTable(attachedDatabase, alias);
  }
}

class AiSetting extends DataClass implements Insertable<AiSetting> {
  final int id;
  final String? currentProvider;
  final String? currentModel;
  final double temperature;
  final double topP;
  final int maxTokens;
  final double presencePenalty;
  final double frequencyPenalty;
  final bool autoHint;
  final bool autoExplain;
  final int contextLength;
  const AiSetting({
    required this.id,
    this.currentProvider,
    this.currentModel,
    required this.temperature,
    required this.topP,
    required this.maxTokens,
    required this.presencePenalty,
    required this.frequencyPenalty,
    required this.autoHint,
    required this.autoExplain,
    required this.contextLength,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || currentProvider != null) {
      map['current_provider'] = Variable<String>(currentProvider);
    }
    if (!nullToAbsent || currentModel != null) {
      map['current_model'] = Variable<String>(currentModel);
    }
    map['temperature'] = Variable<double>(temperature);
    map['top_p'] = Variable<double>(topP);
    map['max_tokens'] = Variable<int>(maxTokens);
    map['presence_penalty'] = Variable<double>(presencePenalty);
    map['frequency_penalty'] = Variable<double>(frequencyPenalty);
    map['auto_hint'] = Variable<bool>(autoHint);
    map['auto_explain'] = Variable<bool>(autoExplain);
    map['context_length'] = Variable<int>(contextLength);
    return map;
  }

  AiSettingsCompanion toCompanion(bool nullToAbsent) {
    return AiSettingsCompanion(
      id: Value(id),
      currentProvider: currentProvider == null && nullToAbsent
          ? const Value.absent()
          : Value(currentProvider),
      currentModel: currentModel == null && nullToAbsent
          ? const Value.absent()
          : Value(currentModel),
      temperature: Value(temperature),
      topP: Value(topP),
      maxTokens: Value(maxTokens),
      presencePenalty: Value(presencePenalty),
      frequencyPenalty: Value(frequencyPenalty),
      autoHint: Value(autoHint),
      autoExplain: Value(autoExplain),
      contextLength: Value(contextLength),
    );
  }

  factory AiSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiSetting(
      id: serializer.fromJson<int>(json['id']),
      currentProvider: serializer.fromJson<String?>(json['currentProvider']),
      currentModel: serializer.fromJson<String?>(json['currentModel']),
      temperature: serializer.fromJson<double>(json['temperature']),
      topP: serializer.fromJson<double>(json['topP']),
      maxTokens: serializer.fromJson<int>(json['maxTokens']),
      presencePenalty: serializer.fromJson<double>(json['presencePenalty']),
      frequencyPenalty: serializer.fromJson<double>(json['frequencyPenalty']),
      autoHint: serializer.fromJson<bool>(json['autoHint']),
      autoExplain: serializer.fromJson<bool>(json['autoExplain']),
      contextLength: serializer.fromJson<int>(json['contextLength']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currentProvider': serializer.toJson<String?>(currentProvider),
      'currentModel': serializer.toJson<String?>(currentModel),
      'temperature': serializer.toJson<double>(temperature),
      'topP': serializer.toJson<double>(topP),
      'maxTokens': serializer.toJson<int>(maxTokens),
      'presencePenalty': serializer.toJson<double>(presencePenalty),
      'frequencyPenalty': serializer.toJson<double>(frequencyPenalty),
      'autoHint': serializer.toJson<bool>(autoHint),
      'autoExplain': serializer.toJson<bool>(autoExplain),
      'contextLength': serializer.toJson<int>(contextLength),
    };
  }

  AiSetting copyWith({
    int? id,
    Value<String?> currentProvider = const Value.absent(),
    Value<String?> currentModel = const Value.absent(),
    double? temperature,
    double? topP,
    int? maxTokens,
    double? presencePenalty,
    double? frequencyPenalty,
    bool? autoHint,
    bool? autoExplain,
    int? contextLength,
  }) => AiSetting(
    id: id ?? this.id,
    currentProvider: currentProvider.present
        ? currentProvider.value
        : this.currentProvider,
    currentModel: currentModel.present ? currentModel.value : this.currentModel,
    temperature: temperature ?? this.temperature,
    topP: topP ?? this.topP,
    maxTokens: maxTokens ?? this.maxTokens,
    presencePenalty: presencePenalty ?? this.presencePenalty,
    frequencyPenalty: frequencyPenalty ?? this.frequencyPenalty,
    autoHint: autoHint ?? this.autoHint,
    autoExplain: autoExplain ?? this.autoExplain,
    contextLength: contextLength ?? this.contextLength,
  );
  AiSetting copyWithCompanion(AiSettingsCompanion data) {
    return AiSetting(
      id: data.id.present ? data.id.value : this.id,
      currentProvider: data.currentProvider.present
          ? data.currentProvider.value
          : this.currentProvider,
      currentModel: data.currentModel.present
          ? data.currentModel.value
          : this.currentModel,
      temperature: data.temperature.present
          ? data.temperature.value
          : this.temperature,
      topP: data.topP.present ? data.topP.value : this.topP,
      maxTokens: data.maxTokens.present ? data.maxTokens.value : this.maxTokens,
      presencePenalty: data.presencePenalty.present
          ? data.presencePenalty.value
          : this.presencePenalty,
      frequencyPenalty: data.frequencyPenalty.present
          ? data.frequencyPenalty.value
          : this.frequencyPenalty,
      autoHint: data.autoHint.present ? data.autoHint.value : this.autoHint,
      autoExplain: data.autoExplain.present
          ? data.autoExplain.value
          : this.autoExplain,
      contextLength: data.contextLength.present
          ? data.contextLength.value
          : this.contextLength,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiSetting(')
          ..write('id: $id, ')
          ..write('currentProvider: $currentProvider, ')
          ..write('currentModel: $currentModel, ')
          ..write('temperature: $temperature, ')
          ..write('topP: $topP, ')
          ..write('maxTokens: $maxTokens, ')
          ..write('presencePenalty: $presencePenalty, ')
          ..write('frequencyPenalty: $frequencyPenalty, ')
          ..write('autoHint: $autoHint, ')
          ..write('autoExplain: $autoExplain, ')
          ..write('contextLength: $contextLength')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    currentProvider,
    currentModel,
    temperature,
    topP,
    maxTokens,
    presencePenalty,
    frequencyPenalty,
    autoHint,
    autoExplain,
    contextLength,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiSetting &&
          other.id == this.id &&
          other.currentProvider == this.currentProvider &&
          other.currentModel == this.currentModel &&
          other.temperature == this.temperature &&
          other.topP == this.topP &&
          other.maxTokens == this.maxTokens &&
          other.presencePenalty == this.presencePenalty &&
          other.frequencyPenalty == this.frequencyPenalty &&
          other.autoHint == this.autoHint &&
          other.autoExplain == this.autoExplain &&
          other.contextLength == this.contextLength);
}

class AiSettingsCompanion extends UpdateCompanion<AiSetting> {
  final Value<int> id;
  final Value<String?> currentProvider;
  final Value<String?> currentModel;
  final Value<double> temperature;
  final Value<double> topP;
  final Value<int> maxTokens;
  final Value<double> presencePenalty;
  final Value<double> frequencyPenalty;
  final Value<bool> autoHint;
  final Value<bool> autoExplain;
  final Value<int> contextLength;
  const AiSettingsCompanion({
    this.id = const Value.absent(),
    this.currentProvider = const Value.absent(),
    this.currentModel = const Value.absent(),
    this.temperature = const Value.absent(),
    this.topP = const Value.absent(),
    this.maxTokens = const Value.absent(),
    this.presencePenalty = const Value.absent(),
    this.frequencyPenalty = const Value.absent(),
    this.autoHint = const Value.absent(),
    this.autoExplain = const Value.absent(),
    this.contextLength = const Value.absent(),
  });
  AiSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.currentProvider = const Value.absent(),
    this.currentModel = const Value.absent(),
    this.temperature = const Value.absent(),
    this.topP = const Value.absent(),
    this.maxTokens = const Value.absent(),
    this.presencePenalty = const Value.absent(),
    this.frequencyPenalty = const Value.absent(),
    this.autoHint = const Value.absent(),
    this.autoExplain = const Value.absent(),
    this.contextLength = const Value.absent(),
  });
  static Insertable<AiSetting> custom({
    Expression<int>? id,
    Expression<String>? currentProvider,
    Expression<String>? currentModel,
    Expression<double>? temperature,
    Expression<double>? topP,
    Expression<int>? maxTokens,
    Expression<double>? presencePenalty,
    Expression<double>? frequencyPenalty,
    Expression<bool>? autoHint,
    Expression<bool>? autoExplain,
    Expression<int>? contextLength,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currentProvider != null) 'current_provider': currentProvider,
      if (currentModel != null) 'current_model': currentModel,
      if (temperature != null) 'temperature': temperature,
      if (topP != null) 'top_p': topP,
      if (maxTokens != null) 'max_tokens': maxTokens,
      if (presencePenalty != null) 'presence_penalty': presencePenalty,
      if (frequencyPenalty != null) 'frequency_penalty': frequencyPenalty,
      if (autoHint != null) 'auto_hint': autoHint,
      if (autoExplain != null) 'auto_explain': autoExplain,
      if (contextLength != null) 'context_length': contextLength,
    });
  }

  AiSettingsCompanion copyWith({
    Value<int>? id,
    Value<String?>? currentProvider,
    Value<String?>? currentModel,
    Value<double>? temperature,
    Value<double>? topP,
    Value<int>? maxTokens,
    Value<double>? presencePenalty,
    Value<double>? frequencyPenalty,
    Value<bool>? autoHint,
    Value<bool>? autoExplain,
    Value<int>? contextLength,
  }) {
    return AiSettingsCompanion(
      id: id ?? this.id,
      currentProvider: currentProvider ?? this.currentProvider,
      currentModel: currentModel ?? this.currentModel,
      temperature: temperature ?? this.temperature,
      topP: topP ?? this.topP,
      maxTokens: maxTokens ?? this.maxTokens,
      presencePenalty: presencePenalty ?? this.presencePenalty,
      frequencyPenalty: frequencyPenalty ?? this.frequencyPenalty,
      autoHint: autoHint ?? this.autoHint,
      autoExplain: autoExplain ?? this.autoExplain,
      contextLength: contextLength ?? this.contextLength,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currentProvider.present) {
      map['current_provider'] = Variable<String>(currentProvider.value);
    }
    if (currentModel.present) {
      map['current_model'] = Variable<String>(currentModel.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (topP.present) {
      map['top_p'] = Variable<double>(topP.value);
    }
    if (maxTokens.present) {
      map['max_tokens'] = Variable<int>(maxTokens.value);
    }
    if (presencePenalty.present) {
      map['presence_penalty'] = Variable<double>(presencePenalty.value);
    }
    if (frequencyPenalty.present) {
      map['frequency_penalty'] = Variable<double>(frequencyPenalty.value);
    }
    if (autoHint.present) {
      map['auto_hint'] = Variable<bool>(autoHint.value);
    }
    if (autoExplain.present) {
      map['auto_explain'] = Variable<bool>(autoExplain.value);
    }
    if (contextLength.present) {
      map['context_length'] = Variable<int>(contextLength.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiSettingsCompanion(')
          ..write('id: $id, ')
          ..write('currentProvider: $currentProvider, ')
          ..write('currentModel: $currentModel, ')
          ..write('temperature: $temperature, ')
          ..write('topP: $topP, ')
          ..write('maxTokens: $maxTokens, ')
          ..write('presencePenalty: $presencePenalty, ')
          ..write('frequencyPenalty: $frequencyPenalty, ')
          ..write('autoHint: $autoHint, ')
          ..write('autoExplain: $autoExplain, ')
          ..write('contextLength: $contextLength')
          ..write(')'))
        .toString();
  }
}

class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Session> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class Session extends DataClass implements Insertable<Session> {
  final String id;
  final String title;
  final int createdAt;
  final int updatedAt;
  const Session({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      title: Value(title),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Session.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  Session copyWith({
    String? id,
    String? title,
    int? createdAt,
    int? updatedAt,
  }) => Session(
    id: id ?? this.id,
    title: title ?? this.title,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Session copyWithCompanion(SessionsCompanion data) {
    return Session(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.id == this.id &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsCompanion.insert({
    required String id,
    required String title,
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Session> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return SessionsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    role,
    content,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<Message> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  final int id;
  final String sessionId;
  final String role;
  final String content;
  final int createdAt;
  const Message({
    required this.id,
    required this.sessionId,
    required this.role,
    required this.content,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['role'] = Variable<String>(role);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      role: Value(role),
      content: Value(content),
      createdAt: Value(createdAt),
    );
  }

  factory Message.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      role: serializer.fromJson<String>(json['role']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'role': serializer.toJson<String>(role),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  Message copyWith({
    int? id,
    String? sessionId,
    String? role,
    String? content,
    int? createdAt,
  }) => Message(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    role: role ?? this.role,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
  );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      role: data.role.present ? data.role.value : this.role,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, role, content, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.role == this.role &&
          other.content == this.content &&
          other.createdAt == this.createdAt);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<int> id;
  final Value<String> sessionId;
  final Value<String> role;
  final Value<String> content;
  final Value<int> createdAt;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.role = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MessagesCompanion.insert({
    this.id = const Value.absent(),
    required String sessionId,
    required String role,
    required String content,
    required int createdAt,
  }) : sessionId = Value(sessionId),
       role = Value(role),
       content = Value(content),
       createdAt = Value(createdAt);
  static Insertable<Message> custom({
    Expression<int>? id,
    Expression<String>? sessionId,
    Expression<String>? role,
    Expression<String>? content,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (role != null) 'role': role,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MessagesCompanion copyWith({
    Value<int>? id,
    Value<String>? sessionId,
    Value<String>? role,
    Value<String>? content,
    Value<int>? createdAt,
  }) {
    return MessagesCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      role: role ?? this.role,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AttachmentsTable extends Attachments
    with TableInfo<$AttachmentsTable, Attachment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<int> messageId = GeneratedColumn<int>(
    'message_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _storedNameMeta = const VerificationMeta(
    'storedName',
  );
  @override
  late final GeneratedColumn<String> storedName = GeneratedColumn<String>(
    'stored_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
    'path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int> size = GeneratedColumn<int>(
    'size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    messageId,
    name,
    storedName,
    path,
    type,
    mimeType,
    size,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Attachment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('stored_name')) {
      context.handle(
        _storedNameMeta,
        storedName.isAcceptableOrUnknown(data['stored_name']!, _storedNameMeta),
      );
    } else if (isInserting) {
      context.missing(_storedNameMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
        _pathMeta,
        path.isAcceptableOrUnknown(data['path']!, _pathMeta),
      );
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Attachment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Attachment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}message_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      storedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stored_name'],
      )!,
      path: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      )!,
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AttachmentsTable createAlias(String alias) {
    return $AttachmentsTable(attachedDatabase, alias);
  }
}

class Attachment extends DataClass implements Insertable<Attachment> {
  final String id;
  final int messageId;
  final String name;
  final String storedName;
  final String path;
  final String type;
  final String mimeType;
  final int size;
  final int createdAt;
  const Attachment({
    required this.id,
    required this.messageId,
    required this.name,
    required this.storedName,
    required this.path,
    required this.type,
    required this.mimeType,
    required this.size,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['message_id'] = Variable<int>(messageId);
    map['name'] = Variable<String>(name);
    map['stored_name'] = Variable<String>(storedName);
    map['path'] = Variable<String>(path);
    map['type'] = Variable<String>(type);
    map['mime_type'] = Variable<String>(mimeType);
    map['size'] = Variable<int>(size);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  AttachmentsCompanion toCompanion(bool nullToAbsent) {
    return AttachmentsCompanion(
      id: Value(id),
      messageId: Value(messageId),
      name: Value(name),
      storedName: Value(storedName),
      path: Value(path),
      type: Value(type),
      mimeType: Value(mimeType),
      size: Value(size),
      createdAt: Value(createdAt),
    );
  }

  factory Attachment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Attachment(
      id: serializer.fromJson<String>(json['id']),
      messageId: serializer.fromJson<int>(json['messageId']),
      name: serializer.fromJson<String>(json['name']),
      storedName: serializer.fromJson<String>(json['storedName']),
      path: serializer.fromJson<String>(json['path']),
      type: serializer.fromJson<String>(json['type']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      size: serializer.fromJson<int>(json['size']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'messageId': serializer.toJson<int>(messageId),
      'name': serializer.toJson<String>(name),
      'storedName': serializer.toJson<String>(storedName),
      'path': serializer.toJson<String>(path),
      'type': serializer.toJson<String>(type),
      'mimeType': serializer.toJson<String>(mimeType),
      'size': serializer.toJson<int>(size),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  Attachment copyWith({
    String? id,
    int? messageId,
    String? name,
    String? storedName,
    String? path,
    String? type,
    String? mimeType,
    int? size,
    int? createdAt,
  }) => Attachment(
    id: id ?? this.id,
    messageId: messageId ?? this.messageId,
    name: name ?? this.name,
    storedName: storedName ?? this.storedName,
    path: path ?? this.path,
    type: type ?? this.type,
    mimeType: mimeType ?? this.mimeType,
    size: size ?? this.size,
    createdAt: createdAt ?? this.createdAt,
  );
  Attachment copyWithCompanion(AttachmentsCompanion data) {
    return Attachment(
      id: data.id.present ? data.id.value : this.id,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      name: data.name.present ? data.name.value : this.name,
      storedName: data.storedName.present
          ? data.storedName.value
          : this.storedName,
      path: data.path.present ? data.path.value : this.path,
      type: data.type.present ? data.type.value : this.type,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      size: data.size.present ? data.size.value : this.size,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Attachment(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('name: $name, ')
          ..write('storedName: $storedName, ')
          ..write('path: $path, ')
          ..write('type: $type, ')
          ..write('mimeType: $mimeType, ')
          ..write('size: $size, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    messageId,
    name,
    storedName,
    path,
    type,
    mimeType,
    size,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Attachment &&
          other.id == this.id &&
          other.messageId == this.messageId &&
          other.name == this.name &&
          other.storedName == this.storedName &&
          other.path == this.path &&
          other.type == this.type &&
          other.mimeType == this.mimeType &&
          other.size == this.size &&
          other.createdAt == this.createdAt);
}

class AttachmentsCompanion extends UpdateCompanion<Attachment> {
  final Value<String> id;
  final Value<int> messageId;
  final Value<String> name;
  final Value<String> storedName;
  final Value<String> path;
  final Value<String> type;
  final Value<String> mimeType;
  final Value<int> size;
  final Value<int> createdAt;
  final Value<int> rowid;
  const AttachmentsCompanion({
    this.id = const Value.absent(),
    this.messageId = const Value.absent(),
    this.name = const Value.absent(),
    this.storedName = const Value.absent(),
    this.path = const Value.absent(),
    this.type = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.size = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttachmentsCompanion.insert({
    required String id,
    required int messageId,
    required String name,
    required String storedName,
    required String path,
    required String type,
    required String mimeType,
    required int size,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       messageId = Value(messageId),
       name = Value(name),
       storedName = Value(storedName),
       path = Value(path),
       type = Value(type),
       mimeType = Value(mimeType),
       size = Value(size),
       createdAt = Value(createdAt);
  static Insertable<Attachment> custom({
    Expression<String>? id,
    Expression<int>? messageId,
    Expression<String>? name,
    Expression<String>? storedName,
    Expression<String>? path,
    Expression<String>? type,
    Expression<String>? mimeType,
    Expression<int>? size,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageId != null) 'message_id': messageId,
      if (name != null) 'name': name,
      if (storedName != null) 'stored_name': storedName,
      if (path != null) 'path': path,
      if (type != null) 'type': type,
      if (mimeType != null) 'mime_type': mimeType,
      if (size != null) 'size': size,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttachmentsCompanion copyWith({
    Value<String>? id,
    Value<int>? messageId,
    Value<String>? name,
    Value<String>? storedName,
    Value<String>? path,
    Value<String>? type,
    Value<String>? mimeType,
    Value<int>? size,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return AttachmentsCompanion(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      name: name ?? this.name,
      storedName: storedName ?? this.storedName,
      path: path ?? this.path,
      type: type ?? this.type,
      mimeType: mimeType ?? this.mimeType,
      size: size ?? this.size,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<int>(messageId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (storedName.present) {
      map['stored_name'] = Variable<String>(storedName.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentsCompanion(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('name: $name, ')
          ..write('storedName: $storedName, ')
          ..write('path: $path, ')
          ..write('type: $type, ')
          ..write('mimeType: $mimeType, ')
          ..write('size: $size, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActiveSessionTable extends ActiveSession
    with TableInfo<$ActiveSessionTable, ActiveSessionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActiveSessionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, sessionId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'active_session';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActiveSessionData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActiveSessionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActiveSessionData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
    );
  }

  @override
  $ActiveSessionTable createAlias(String alias) {
    return $ActiveSessionTable(attachedDatabase, alias);
  }
}

class ActiveSessionData extends DataClass
    implements Insertable<ActiveSessionData> {
  final int id;
  final String sessionId;
  const ActiveSessionData({required this.id, required this.sessionId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<String>(sessionId);
    return map;
  }

  ActiveSessionCompanion toCompanion(bool nullToAbsent) {
    return ActiveSessionCompanion(id: Value(id), sessionId: Value(sessionId));
  }

  factory ActiveSessionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActiveSessionData(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<String>(sessionId),
    };
  }

  ActiveSessionData copyWith({int? id, String? sessionId}) => ActiveSessionData(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
  );
  ActiveSessionData copyWithCompanion(ActiveSessionCompanion data) {
    return ActiveSessionData(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActiveSessionData(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActiveSessionData &&
          other.id == this.id &&
          other.sessionId == this.sessionId);
}

class ActiveSessionCompanion extends UpdateCompanion<ActiveSessionData> {
  final Value<int> id;
  final Value<String> sessionId;
  const ActiveSessionCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
  });
  ActiveSessionCompanion.insert({
    this.id = const Value.absent(),
    required String sessionId,
  }) : sessionId = Value(sessionId);
  static Insertable<ActiveSessionData> custom({
    Expression<int>? id,
    Expression<String>? sessionId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
    });
  }

  ActiveSessionCompanion copyWith({Value<int>? id, Value<String>? sessionId}) {
    return ActiveSessionCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActiveSessionCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId')
          ..write(')'))
        .toString();
  }
}

class $LogEntriesTable extends LogEntries
    with TableInfo<$LogEntriesTable, LogEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<int> timestamp = GeneratedColumn<int>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timestamp,
    level,
    category,
    message,
    metadata,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'log_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<LogEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LogEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}level'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      ),
    );
  }

  @override
  $LogEntriesTable createAlias(String alias) {
    return $LogEntriesTable(attachedDatabase, alias);
  }
}

class LogEntry extends DataClass implements Insertable<LogEntry> {
  final int id;
  final int timestamp;
  final String level;
  final String category;
  final String message;
  final String? metadata;
  const LogEntry({
    required this.id,
    required this.timestamp,
    required this.level,
    required this.category,
    required this.message,
    this.metadata,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['timestamp'] = Variable<int>(timestamp);
    map['level'] = Variable<String>(level);
    map['category'] = Variable<String>(category);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    return map;
  }

  LogEntriesCompanion toCompanion(bool nullToAbsent) {
    return LogEntriesCompanion(
      id: Value(id),
      timestamp: Value(timestamp),
      level: Value(level),
      category: Value(category),
      message: Value(message),
      metadata: metadata == null && nullToAbsent
          ? const Value.absent()
          : Value(metadata),
    );
  }

  factory LogEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogEntry(
      id: serializer.fromJson<int>(json['id']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      level: serializer.fromJson<String>(json['level']),
      category: serializer.fromJson<String>(json['category']),
      message: serializer.fromJson<String>(json['message']),
      metadata: serializer.fromJson<String?>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'timestamp': serializer.toJson<int>(timestamp),
      'level': serializer.toJson<String>(level),
      'category': serializer.toJson<String>(category),
      'message': serializer.toJson<String>(message),
      'metadata': serializer.toJson<String?>(metadata),
    };
  }

  LogEntry copyWith({
    int? id,
    int? timestamp,
    String? level,
    String? category,
    String? message,
    Value<String?> metadata = const Value.absent(),
  }) => LogEntry(
    id: id ?? this.id,
    timestamp: timestamp ?? this.timestamp,
    level: level ?? this.level,
    category: category ?? this.category,
    message: message ?? this.message,
    metadata: metadata.present ? metadata.value : this.metadata,
  );
  LogEntry copyWithCompanion(LogEntriesCompanion data) {
    return LogEntry(
      id: data.id.present ? data.id.value : this.id,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      level: data.level.present ? data.level.value : this.level,
      category: data.category.present ? data.category.value : this.category,
      message: data.message.present ? data.message.value : this.message,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LogEntry(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('level: $level, ')
          ..write('category: $category, ')
          ..write('message: $message, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, timestamp, level, category, message, metadata);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogEntry &&
          other.id == this.id &&
          other.timestamp == this.timestamp &&
          other.level == this.level &&
          other.category == this.category &&
          other.message == this.message &&
          other.metadata == this.metadata);
}

class LogEntriesCompanion extends UpdateCompanion<LogEntry> {
  final Value<int> id;
  final Value<int> timestamp;
  final Value<String> level;
  final Value<String> category;
  final Value<String> message;
  final Value<String?> metadata;
  const LogEntriesCompanion({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.level = const Value.absent(),
    this.category = const Value.absent(),
    this.message = const Value.absent(),
    this.metadata = const Value.absent(),
  });
  LogEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int timestamp,
    required String level,
    required String category,
    required String message,
    this.metadata = const Value.absent(),
  }) : timestamp = Value(timestamp),
       level = Value(level),
       category = Value(category),
       message = Value(message);
  static Insertable<LogEntry> custom({
    Expression<int>? id,
    Expression<int>? timestamp,
    Expression<String>? level,
    Expression<String>? category,
    Expression<String>? message,
    Expression<String>? metadata,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timestamp != null) 'timestamp': timestamp,
      if (level != null) 'level': level,
      if (category != null) 'category': category,
      if (message != null) 'message': message,
      if (metadata != null) 'metadata': metadata,
    });
  }

  LogEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? timestamp,
    Value<String>? level,
    Value<String>? category,
    Value<String>? message,
    Value<String?>? metadata,
  }) {
    return LogEntriesCompanion(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      level: level ?? this.level,
      category: category ?? this.category,
      message: message ?? this.message,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogEntriesCompanion(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('level: $level, ')
          ..write('category: $category, ')
          ..write('message: $message, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CardsTable cards = $CardsTable(this);
  late final $AiProvidersTable aiProviders = $AiProvidersTable(this);
  late final $AiProviderModelsTable aiProviderModels = $AiProviderModelsTable(
    this,
  );
  late final $AiSettingsTable aiSettings = $AiSettingsTable(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $AttachmentsTable attachments = $AttachmentsTable(this);
  late final $ActiveSessionTable activeSession = $ActiveSessionTable(this);
  late final $LogEntriesTable logEntries = $LogEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cards,
    aiProviders,
    aiProviderModels,
    aiSettings,
    sessions,
    messages,
    attachments,
    activeSession,
    logEntries,
  ];
}

typedef $$CardsTableCreateCompanionBuilder =
    CardsCompanion Function({
      required String id,
      required String q,
      required String a,
      required int nextReview,
      required int interval,
      Value<double> ef,
      Value<int> repetitions,
      Value<String> tags,
      Value<int> createdAt,
      Value<int> rowid,
    });
typedef $$CardsTableUpdateCompanionBuilder =
    CardsCompanion Function({
      Value<String> id,
      Value<String> q,
      Value<String> a,
      Value<int> nextReview,
      Value<int> interval,
      Value<double> ef,
      Value<int> repetitions,
      Value<String> tags,
      Value<int> createdAt,
      Value<int> rowid,
    });

class $$CardsTableFilterComposer extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get q => $composableBuilder(
    column: $table.q,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get a => $composableBuilder(
    column: $table.a,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextReview => $composableBuilder(
    column: $table.nextReview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get interval => $composableBuilder(
    column: $table.interval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ef => $composableBuilder(
    column: $table.ef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CardsTableOrderingComposer
    extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get q => $composableBuilder(
    column: $table.q,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get a => $composableBuilder(
    column: $table.a,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextReview => $composableBuilder(
    column: $table.nextReview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get interval => $composableBuilder(
    column: $table.interval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ef => $composableBuilder(
    column: $table.ef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get q =>
      $composableBuilder(column: $table.q, builder: (column) => column);

  GeneratedColumn<String> get a =>
      $composableBuilder(column: $table.a, builder: (column) => column);

  GeneratedColumn<int> get nextReview => $composableBuilder(
    column: $table.nextReview,
    builder: (column) => column,
  );

  GeneratedColumn<int> get interval =>
      $composableBuilder(column: $table.interval, builder: (column) => column);

  GeneratedColumn<double> get ef =>
      $composableBuilder(column: $table.ef, builder: (column) => column);

  GeneratedColumn<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CardsTable,
          Card,
          $$CardsTableFilterComposer,
          $$CardsTableOrderingComposer,
          $$CardsTableAnnotationComposer,
          $$CardsTableCreateCompanionBuilder,
          $$CardsTableUpdateCompanionBuilder,
          (Card, BaseReferences<_$AppDatabase, $CardsTable, Card>),
          Card,
          PrefetchHooks Function()
        > {
  $$CardsTableTableManager(_$AppDatabase db, $CardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> q = const Value.absent(),
                Value<String> a = const Value.absent(),
                Value<int> nextReview = const Value.absent(),
                Value<int> interval = const Value.absent(),
                Value<double> ef = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CardsCompanion(
                id: id,
                q: q,
                a: a,
                nextReview: nextReview,
                interval: interval,
                ef: ef,
                repetitions: repetitions,
                tags: tags,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String q,
                required String a,
                required int nextReview,
                required int interval,
                Value<double> ef = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CardsCompanion.insert(
                id: id,
                q: q,
                a: a,
                nextReview: nextReview,
                interval: interval,
                ef: ef,
                repetitions: repetitions,
                tags: tags,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CardsTable,
      Card,
      $$CardsTableFilterComposer,
      $$CardsTableOrderingComposer,
      $$CardsTableAnnotationComposer,
      $$CardsTableCreateCompanionBuilder,
      $$CardsTableUpdateCompanionBuilder,
      (Card, BaseReferences<_$AppDatabase, $CardsTable, Card>),
      Card,
      PrefetchHooks Function()
    >;
typedef $$AiProvidersTableCreateCompanionBuilder =
    AiProvidersCompanion Function({
      required String id,
      Value<String?> apiKey,
      required String baseUrl,
      Value<int> rowid,
    });
typedef $$AiProvidersTableUpdateCompanionBuilder =
    AiProvidersCompanion Function({
      Value<String> id,
      Value<String?> apiKey,
      Value<String> baseUrl,
      Value<int> rowid,
    });

class $$AiProvidersTableFilterComposer
    extends Composer<_$AppDatabase, $AiProvidersTable> {
  $$AiProvidersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apiKey => $composableBuilder(
    column: $table.apiKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AiProvidersTableOrderingComposer
    extends Composer<_$AppDatabase, $AiProvidersTable> {
  $$AiProvidersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apiKey => $composableBuilder(
    column: $table.apiKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AiProvidersTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiProvidersTable> {
  $$AiProvidersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get apiKey =>
      $composableBuilder(column: $table.apiKey, builder: (column) => column);

  GeneratedColumn<String> get baseUrl =>
      $composableBuilder(column: $table.baseUrl, builder: (column) => column);
}

class $$AiProvidersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AiProvidersTable,
          AiProvider,
          $$AiProvidersTableFilterComposer,
          $$AiProvidersTableOrderingComposer,
          $$AiProvidersTableAnnotationComposer,
          $$AiProvidersTableCreateCompanionBuilder,
          $$AiProvidersTableUpdateCompanionBuilder,
          (
            AiProvider,
            BaseReferences<_$AppDatabase, $AiProvidersTable, AiProvider>,
          ),
          AiProvider,
          PrefetchHooks Function()
        > {
  $$AiProvidersTableTableManager(_$AppDatabase db, $AiProvidersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiProvidersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiProvidersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiProvidersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> apiKey = const Value.absent(),
                Value<String> baseUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiProvidersCompanion(
                id: id,
                apiKey: apiKey,
                baseUrl: baseUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> apiKey = const Value.absent(),
                required String baseUrl,
                Value<int> rowid = const Value.absent(),
              }) => AiProvidersCompanion.insert(
                id: id,
                apiKey: apiKey,
                baseUrl: baseUrl,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AiProvidersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AiProvidersTable,
      AiProvider,
      $$AiProvidersTableFilterComposer,
      $$AiProvidersTableOrderingComposer,
      $$AiProvidersTableAnnotationComposer,
      $$AiProvidersTableCreateCompanionBuilder,
      $$AiProvidersTableUpdateCompanionBuilder,
      (
        AiProvider,
        BaseReferences<_$AppDatabase, $AiProvidersTable, AiProvider>,
      ),
      AiProvider,
      PrefetchHooks Function()
    >;
typedef $$AiProviderModelsTableCreateCompanionBuilder =
    AiProviderModelsCompanion Function({
      required String providerId,
      required String modelName,
      Value<int> rowid,
    });
typedef $$AiProviderModelsTableUpdateCompanionBuilder =
    AiProviderModelsCompanion Function({
      Value<String> providerId,
      Value<String> modelName,
      Value<int> rowid,
    });

class $$AiProviderModelsTableFilterComposer
    extends Composer<_$AppDatabase, $AiProviderModelsTable> {
  $$AiProviderModelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get providerId => $composableBuilder(
    column: $table.providerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelName => $composableBuilder(
    column: $table.modelName,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AiProviderModelsTableOrderingComposer
    extends Composer<_$AppDatabase, $AiProviderModelsTable> {
  $$AiProviderModelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get providerId => $composableBuilder(
    column: $table.providerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelName => $composableBuilder(
    column: $table.modelName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AiProviderModelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiProviderModelsTable> {
  $$AiProviderModelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get providerId => $composableBuilder(
    column: $table.providerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get modelName =>
      $composableBuilder(column: $table.modelName, builder: (column) => column);
}

class $$AiProviderModelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AiProviderModelsTable,
          AiProviderModel,
          $$AiProviderModelsTableFilterComposer,
          $$AiProviderModelsTableOrderingComposer,
          $$AiProviderModelsTableAnnotationComposer,
          $$AiProviderModelsTableCreateCompanionBuilder,
          $$AiProviderModelsTableUpdateCompanionBuilder,
          (
            AiProviderModel,
            BaseReferences<
              _$AppDatabase,
              $AiProviderModelsTable,
              AiProviderModel
            >,
          ),
          AiProviderModel,
          PrefetchHooks Function()
        > {
  $$AiProviderModelsTableTableManager(
    _$AppDatabase db,
    $AiProviderModelsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiProviderModelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiProviderModelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiProviderModelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> providerId = const Value.absent(),
                Value<String> modelName = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiProviderModelsCompanion(
                providerId: providerId,
                modelName: modelName,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String providerId,
                required String modelName,
                Value<int> rowid = const Value.absent(),
              }) => AiProviderModelsCompanion.insert(
                providerId: providerId,
                modelName: modelName,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AiProviderModelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AiProviderModelsTable,
      AiProviderModel,
      $$AiProviderModelsTableFilterComposer,
      $$AiProviderModelsTableOrderingComposer,
      $$AiProviderModelsTableAnnotationComposer,
      $$AiProviderModelsTableCreateCompanionBuilder,
      $$AiProviderModelsTableUpdateCompanionBuilder,
      (
        AiProviderModel,
        BaseReferences<_$AppDatabase, $AiProviderModelsTable, AiProviderModel>,
      ),
      AiProviderModel,
      PrefetchHooks Function()
    >;
typedef $$AiSettingsTableCreateCompanionBuilder =
    AiSettingsCompanion Function({
      Value<int> id,
      Value<String?> currentProvider,
      Value<String?> currentModel,
      Value<double> temperature,
      Value<double> topP,
      Value<int> maxTokens,
      Value<double> presencePenalty,
      Value<double> frequencyPenalty,
      Value<bool> autoHint,
      Value<bool> autoExplain,
      Value<int> contextLength,
    });
typedef $$AiSettingsTableUpdateCompanionBuilder =
    AiSettingsCompanion Function({
      Value<int> id,
      Value<String?> currentProvider,
      Value<String?> currentModel,
      Value<double> temperature,
      Value<double> topP,
      Value<int> maxTokens,
      Value<double> presencePenalty,
      Value<double> frequencyPenalty,
      Value<bool> autoHint,
      Value<bool> autoExplain,
      Value<int> contextLength,
    });

class $$AiSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AiSettingsTable> {
  $$AiSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentProvider => $composableBuilder(
    column: $table.currentProvider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentModel => $composableBuilder(
    column: $table.currentModel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get topP => $composableBuilder(
    column: $table.topP,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxTokens => $composableBuilder(
    column: $table.maxTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get presencePenalty => $composableBuilder(
    column: $table.presencePenalty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get frequencyPenalty => $composableBuilder(
    column: $table.frequencyPenalty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get autoHint => $composableBuilder(
    column: $table.autoHint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get autoExplain => $composableBuilder(
    column: $table.autoExplain,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get contextLength => $composableBuilder(
    column: $table.contextLength,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AiSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AiSettingsTable> {
  $$AiSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentProvider => $composableBuilder(
    column: $table.currentProvider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentModel => $composableBuilder(
    column: $table.currentModel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get topP => $composableBuilder(
    column: $table.topP,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxTokens => $composableBuilder(
    column: $table.maxTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get presencePenalty => $composableBuilder(
    column: $table.presencePenalty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get frequencyPenalty => $composableBuilder(
    column: $table.frequencyPenalty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autoHint => $composableBuilder(
    column: $table.autoHint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autoExplain => $composableBuilder(
    column: $table.autoExplain,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contextLength => $composableBuilder(
    column: $table.contextLength,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AiSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiSettingsTable> {
  $$AiSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get currentProvider => $composableBuilder(
    column: $table.currentProvider,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentModel => $composableBuilder(
    column: $table.currentModel,
    builder: (column) => column,
  );

  GeneratedColumn<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<double> get topP =>
      $composableBuilder(column: $table.topP, builder: (column) => column);

  GeneratedColumn<int> get maxTokens =>
      $composableBuilder(column: $table.maxTokens, builder: (column) => column);

  GeneratedColumn<double> get presencePenalty => $composableBuilder(
    column: $table.presencePenalty,
    builder: (column) => column,
  );

  GeneratedColumn<double> get frequencyPenalty => $composableBuilder(
    column: $table.frequencyPenalty,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get autoHint =>
      $composableBuilder(column: $table.autoHint, builder: (column) => column);

  GeneratedColumn<bool> get autoExplain => $composableBuilder(
    column: $table.autoExplain,
    builder: (column) => column,
  );

  GeneratedColumn<int> get contextLength => $composableBuilder(
    column: $table.contextLength,
    builder: (column) => column,
  );
}

class $$AiSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AiSettingsTable,
          AiSetting,
          $$AiSettingsTableFilterComposer,
          $$AiSettingsTableOrderingComposer,
          $$AiSettingsTableAnnotationComposer,
          $$AiSettingsTableCreateCompanionBuilder,
          $$AiSettingsTableUpdateCompanionBuilder,
          (
            AiSetting,
            BaseReferences<_$AppDatabase, $AiSettingsTable, AiSetting>,
          ),
          AiSetting,
          PrefetchHooks Function()
        > {
  $$AiSettingsTableTableManager(_$AppDatabase db, $AiSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> currentProvider = const Value.absent(),
                Value<String?> currentModel = const Value.absent(),
                Value<double> temperature = const Value.absent(),
                Value<double> topP = const Value.absent(),
                Value<int> maxTokens = const Value.absent(),
                Value<double> presencePenalty = const Value.absent(),
                Value<double> frequencyPenalty = const Value.absent(),
                Value<bool> autoHint = const Value.absent(),
                Value<bool> autoExplain = const Value.absent(),
                Value<int> contextLength = const Value.absent(),
              }) => AiSettingsCompanion(
                id: id,
                currentProvider: currentProvider,
                currentModel: currentModel,
                temperature: temperature,
                topP: topP,
                maxTokens: maxTokens,
                presencePenalty: presencePenalty,
                frequencyPenalty: frequencyPenalty,
                autoHint: autoHint,
                autoExplain: autoExplain,
                contextLength: contextLength,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> currentProvider = const Value.absent(),
                Value<String?> currentModel = const Value.absent(),
                Value<double> temperature = const Value.absent(),
                Value<double> topP = const Value.absent(),
                Value<int> maxTokens = const Value.absent(),
                Value<double> presencePenalty = const Value.absent(),
                Value<double> frequencyPenalty = const Value.absent(),
                Value<bool> autoHint = const Value.absent(),
                Value<bool> autoExplain = const Value.absent(),
                Value<int> contextLength = const Value.absent(),
              }) => AiSettingsCompanion.insert(
                id: id,
                currentProvider: currentProvider,
                currentModel: currentModel,
                temperature: temperature,
                topP: topP,
                maxTokens: maxTokens,
                presencePenalty: presencePenalty,
                frequencyPenalty: frequencyPenalty,
                autoHint: autoHint,
                autoExplain: autoExplain,
                contextLength: contextLength,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AiSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AiSettingsTable,
      AiSetting,
      $$AiSettingsTableFilterComposer,
      $$AiSettingsTableOrderingComposer,
      $$AiSettingsTableAnnotationComposer,
      $$AiSettingsTableCreateCompanionBuilder,
      $$AiSettingsTableUpdateCompanionBuilder,
      (AiSetting, BaseReferences<_$AppDatabase, $AiSettingsTable, AiSetting>),
      AiSetting,
      PrefetchHooks Function()
    >;
typedef $$SessionsTableCreateCompanionBuilder =
    SessionsCompanion Function({
      required String id,
      required String title,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$SessionsTableUpdateCompanionBuilder =
    SessionsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsTable,
          Session,
          $$SessionsTableFilterComposer,
          $$SessionsTableOrderingComposer,
          $$SessionsTableAnnotationComposer,
          $$SessionsTableCreateCompanionBuilder,
          $$SessionsTableUpdateCompanionBuilder,
          (Session, BaseReferences<_$AppDatabase, $SessionsTable, Session>),
          Session,
          PrefetchHooks Function()
        > {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsCompanion(
                id: id,
                title: title,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SessionsCompanion.insert(
                id: id,
                title: title,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsTable,
      Session,
      $$SessionsTableFilterComposer,
      $$SessionsTableOrderingComposer,
      $$SessionsTableAnnotationComposer,
      $$SessionsTableCreateCompanionBuilder,
      $$SessionsTableUpdateCompanionBuilder,
      (Session, BaseReferences<_$AppDatabase, $SessionsTable, Session>),
      Session,
      PrefetchHooks Function()
    >;
typedef $$MessagesTableCreateCompanionBuilder =
    MessagesCompanion Function({
      Value<int> id,
      required String sessionId,
      required String role,
      required String content,
      required int createdAt,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<int> id,
      Value<String> sessionId,
      Value<String> role,
      Value<String> content,
      Value<int> createdAt,
    });

class $$MessagesTableFilterComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessagesTable,
          Message,
          $$MessagesTableFilterComposer,
          $$MessagesTableOrderingComposer,
          $$MessagesTableAnnotationComposer,
          $$MessagesTableCreateCompanionBuilder,
          $$MessagesTableUpdateCompanionBuilder,
          (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
          Message,
          PrefetchHooks Function()
        > {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => MessagesCompanion(
                id: id,
                sessionId: sessionId,
                role: role,
                content: content,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sessionId,
                required String role,
                required String content,
                required int createdAt,
              }) => MessagesCompanion.insert(
                id: id,
                sessionId: sessionId,
                role: role,
                content: content,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessagesTable,
      Message,
      $$MessagesTableFilterComposer,
      $$MessagesTableOrderingComposer,
      $$MessagesTableAnnotationComposer,
      $$MessagesTableCreateCompanionBuilder,
      $$MessagesTableUpdateCompanionBuilder,
      (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
      Message,
      PrefetchHooks Function()
    >;
typedef $$AttachmentsTableCreateCompanionBuilder =
    AttachmentsCompanion Function({
      required String id,
      required int messageId,
      required String name,
      required String storedName,
      required String path,
      required String type,
      required String mimeType,
      required int size,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$AttachmentsTableUpdateCompanionBuilder =
    AttachmentsCompanion Function({
      Value<String> id,
      Value<int> messageId,
      Value<String> name,
      Value<String> storedName,
      Value<String> path,
      Value<String> type,
      Value<String> mimeType,
      Value<int> size,
      Value<int> createdAt,
      Value<int> rowid,
    });

class $$AttachmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get storedName => $composableBuilder(
    column: $table.storedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttachmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storedName => $composableBuilder(
    column: $table.storedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttachmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get storedName => $composableBuilder(
    column: $table.storedName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AttachmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttachmentsTable,
          Attachment,
          $$AttachmentsTableFilterComposer,
          $$AttachmentsTableOrderingComposer,
          $$AttachmentsTableAnnotationComposer,
          $$AttachmentsTableCreateCompanionBuilder,
          $$AttachmentsTableUpdateCompanionBuilder,
          (
            Attachment,
            BaseReferences<_$AppDatabase, $AttachmentsTable, Attachment>,
          ),
          Attachment,
          PrefetchHooks Function()
        > {
  $$AttachmentsTableTableManager(_$AppDatabase db, $AttachmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttachmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttachmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttachmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> messageId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> storedName = const Value.absent(),
                Value<String> path = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> mimeType = const Value.absent(),
                Value<int> size = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttachmentsCompanion(
                id: id,
                messageId: messageId,
                name: name,
                storedName: storedName,
                path: path,
                type: type,
                mimeType: mimeType,
                size: size,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int messageId,
                required String name,
                required String storedName,
                required String path,
                required String type,
                required String mimeType,
                required int size,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => AttachmentsCompanion.insert(
                id: id,
                messageId: messageId,
                name: name,
                storedName: storedName,
                path: path,
                type: type,
                mimeType: mimeType,
                size: size,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttachmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttachmentsTable,
      Attachment,
      $$AttachmentsTableFilterComposer,
      $$AttachmentsTableOrderingComposer,
      $$AttachmentsTableAnnotationComposer,
      $$AttachmentsTableCreateCompanionBuilder,
      $$AttachmentsTableUpdateCompanionBuilder,
      (
        Attachment,
        BaseReferences<_$AppDatabase, $AttachmentsTable, Attachment>,
      ),
      Attachment,
      PrefetchHooks Function()
    >;
typedef $$ActiveSessionTableCreateCompanionBuilder =
    ActiveSessionCompanion Function({Value<int> id, required String sessionId});
typedef $$ActiveSessionTableUpdateCompanionBuilder =
    ActiveSessionCompanion Function({Value<int> id, Value<String> sessionId});

class $$ActiveSessionTableFilterComposer
    extends Composer<_$AppDatabase, $ActiveSessionTable> {
  $$ActiveSessionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ActiveSessionTableOrderingComposer
    extends Composer<_$AppDatabase, $ActiveSessionTable> {
  $$ActiveSessionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActiveSessionTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActiveSessionTable> {
  $$ActiveSessionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);
}

class $$ActiveSessionTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActiveSessionTable,
          ActiveSessionData,
          $$ActiveSessionTableFilterComposer,
          $$ActiveSessionTableOrderingComposer,
          $$ActiveSessionTableAnnotationComposer,
          $$ActiveSessionTableCreateCompanionBuilder,
          $$ActiveSessionTableUpdateCompanionBuilder,
          (
            ActiveSessionData,
            BaseReferences<
              _$AppDatabase,
              $ActiveSessionTable,
              ActiveSessionData
            >,
          ),
          ActiveSessionData,
          PrefetchHooks Function()
        > {
  $$ActiveSessionTableTableManager(_$AppDatabase db, $ActiveSessionTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActiveSessionTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActiveSessionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActiveSessionTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
              }) => ActiveSessionCompanion(id: id, sessionId: sessionId),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sessionId,
              }) => ActiveSessionCompanion.insert(id: id, sessionId: sessionId),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ActiveSessionTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActiveSessionTable,
      ActiveSessionData,
      $$ActiveSessionTableFilterComposer,
      $$ActiveSessionTableOrderingComposer,
      $$ActiveSessionTableAnnotationComposer,
      $$ActiveSessionTableCreateCompanionBuilder,
      $$ActiveSessionTableUpdateCompanionBuilder,
      (
        ActiveSessionData,
        BaseReferences<_$AppDatabase, $ActiveSessionTable, ActiveSessionData>,
      ),
      ActiveSessionData,
      PrefetchHooks Function()
    >;
typedef $$LogEntriesTableCreateCompanionBuilder =
    LogEntriesCompanion Function({
      Value<int> id,
      required int timestamp,
      required String level,
      required String category,
      required String message,
      Value<String?> metadata,
    });
typedef $$LogEntriesTableUpdateCompanionBuilder =
    LogEntriesCompanion Function({
      Value<int> id,
      Value<int> timestamp,
      Value<String> level,
      Value<String> category,
      Value<String> message,
      Value<String?> metadata,
    });

class $$LogEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $LogEntriesTable> {
  $$LogEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LogEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LogEntriesTable> {
  $$LogEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LogEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LogEntriesTable> {
  $$LogEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);
}

class $$LogEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LogEntriesTable,
          LogEntry,
          $$LogEntriesTableFilterComposer,
          $$LogEntriesTableOrderingComposer,
          $$LogEntriesTableAnnotationComposer,
          $$LogEntriesTableCreateCompanionBuilder,
          $$LogEntriesTableUpdateCompanionBuilder,
          (LogEntry, BaseReferences<_$AppDatabase, $LogEntriesTable, LogEntry>),
          LogEntry,
          PrefetchHooks Function()
        > {
  $$LogEntriesTableTableManager(_$AppDatabase db, $LogEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> timestamp = const Value.absent(),
                Value<String> level = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
              }) => LogEntriesCompanion(
                id: id,
                timestamp: timestamp,
                level: level,
                category: category,
                message: message,
                metadata: metadata,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int timestamp,
                required String level,
                required String category,
                required String message,
                Value<String?> metadata = const Value.absent(),
              }) => LogEntriesCompanion.insert(
                id: id,
                timestamp: timestamp,
                level: level,
                category: category,
                message: message,
                metadata: metadata,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LogEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LogEntriesTable,
      LogEntry,
      $$LogEntriesTableFilterComposer,
      $$LogEntriesTableOrderingComposer,
      $$LogEntriesTableAnnotationComposer,
      $$LogEntriesTableCreateCompanionBuilder,
      $$LogEntriesTableUpdateCompanionBuilder,
      (LogEntry, BaseReferences<_$AppDatabase, $LogEntriesTable, LogEntry>),
      LogEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CardsTableTableManager get cards =>
      $$CardsTableTableManager(_db, _db.cards);
  $$AiProvidersTableTableManager get aiProviders =>
      $$AiProvidersTableTableManager(_db, _db.aiProviders);
  $$AiProviderModelsTableTableManager get aiProviderModels =>
      $$AiProviderModelsTableTableManager(_db, _db.aiProviderModels);
  $$AiSettingsTableTableManager get aiSettings =>
      $$AiSettingsTableTableManager(_db, _db.aiSettings);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$AttachmentsTableTableManager get attachments =>
      $$AttachmentsTableTableManager(_db, _db.attachments);
  $$ActiveSessionTableTableManager get activeSession =>
      $$ActiveSessionTableTableManager(_db, _db.activeSession);
  $$LogEntriesTableTableManager get logEntries =>
      $$LogEntriesTableTableManager(_db, _db.logEntries);
}
