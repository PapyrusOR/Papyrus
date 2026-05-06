import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// 卡片表
class Cards extends Table {
  TextColumn get id => text()();
  TextColumn get q => text()();
  TextColumn get a => text()();
  IntColumn get nextReview => integer().named('next_review')();
  IntColumn get interval => integer()();
  RealColumn get ef => real().withDefault(const Constant(2.5))();
  IntColumn get repetitions => integer().withDefault(const Constant(0))();
  TextColumn get tags => text().withDefault(const Constant(''))();
  IntColumn get createdAt => integer().named('created_at').withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// AI 提供商配置表
class AiProviders extends Table {
  TextColumn get id => text()();
  TextColumn get apiKey => text().named('api_key').nullable()();
  TextColumn get baseUrl => text().named('base_url')();

  @override
  Set<Column> get primaryKey => {id};
}

/// AI 提供商模型列表表
class AiProviderModels extends Table {
  TextColumn get providerId => text().named('provider_id')();
  TextColumn get modelName => text().named('model_name')();

  @override
  Set<Column> get primaryKey => {providerId, modelName};
}

/// AI 全局设置表（单行单例）
class AiSettings extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get currentProvider => text().named('current_provider').nullable()();
  TextColumn get currentModel => text().named('current_model').nullable()();
  RealColumn get temperature => real().withDefault(const Constant(0.7))();
  RealColumn get topP => real().named('top_p').withDefault(const Constant(0.9))();
  IntColumn get maxTokens => integer().named('max_tokens').withDefault(const Constant(2000))();
  RealColumn get presencePenalty => real().named('presence_penalty').withDefault(const Constant(0.0))();
  RealColumn get frequencyPenalty => real().named('frequency_penalty').withDefault(const Constant(0.0))();
  BoolColumn get autoHint => boolean().named('auto_hint').withDefault(const Constant(false))();
  BoolColumn get autoExplain => boolean().named('auto_explain').withDefault(const Constant(false))();
  IntColumn get contextLength => integer().named('context_length').withDefault(const Constant(10))();

  @override
  Set<Column> get primaryKey => {id};
}

/// 会话表
class Sessions extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get createdAt => integer().named('created_at')();
  IntColumn get updatedAt => integer().named('updated_at')();

  @override
  Set<Column> get primaryKey => {id};
}

/// 消息表
class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sessionId => text().named('session_id')();
  TextColumn get role => text()();
  TextColumn get content => text()();
  IntColumn get createdAt => integer().named('created_at')();
}

/// 附件表
class Attachments extends Table {
  TextColumn get id => text()();
  IntColumn get messageId => integer().named('message_id')();
  TextColumn get name => text()();
  TextColumn get storedName => text().named('stored_name')();
  TextColumn get path => text()();
  TextColumn get type => text()();
  TextColumn get mimeType => text().named('mime_type')();
  IntColumn get size => integer()();
  IntColumn get createdAt => integer().named('created_at')();

  @override
  Set<Column> get primaryKey => {id};
}

/// 活跃会话单例表
class ActiveSession extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get sessionId => text().named('session_id')();

  @override
  Set<Column> get primaryKey => {id};
}

/// 日志条目表
class LogEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get timestamp => integer()();
  TextColumn get level => text()();
  TextColumn get category => text()();
  TextColumn get message => text()();
  TextColumn get metadata => text().nullable()();
}

@DriftDatabase(tables: [
  Cards,
  AiProviders,
  AiProviderModels,
  AiSettings,
  Sessions,
  Messages,
  Attachments,
  ActiveSession,
  LogEntries,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  AppDatabase.defaults() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'papyrus_db');
  }
}
