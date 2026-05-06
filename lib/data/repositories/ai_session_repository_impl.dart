import 'package:drift/drift.dart';
import '../local/app_database.dart';
import '../models/ai_session_model.dart';
import 'ai_session_repository.dart';

class AISessionRepositoryImpl implements AISessionRepository {
  final AppDatabase _db;

  AISessionRepositoryImpl(this._db);

  @override
  Future<AISessionDataModel?> load() async {
    final sessionRows = await _db.select(_db.sessions).get();
    if (sessionRows.isEmpty) return null;

    final sessions = <SessionModel>[];
    for (final s in sessionRows) {
      final messageRows = await (_db.select(_db.messages)
            ..where((m) => m.sessionId.equals(s.id)))
          .get();
      final messages = <MessageModel>[];
      for (final m in messageRows) {
        final attachmentRows = await (_db.select(_db.attachments)
              ..where((a) => a.messageId.equals(m.id)))
            .get();
        messages.add(MessageModel(
          role: m.role,
          content: m.content,
          attachments: attachmentRows
              .map((a) => AttachmentModel(
                    id: a.id,
                    name: a.name,
                    storedName: a.storedName,
                    path: a.path,
                    type: a.type,
                    mimeType: a.mimeType,
                    size: a.size,
                    createdAt: a.createdAt,
                  ))
              .toList(),
        ));
      }
      sessions.add(SessionModel(
        id: s.id,
        title: s.title,
        messages: messages,
        createdAt: s.createdAt,
        updatedAt: s.updatedAt,
      ));
    }

    final active = await _db.select(_db.activeSession).getSingleOrNull();
    return AISessionDataModel(
      activeSessionId: active?.sessionId ?? sessions.first.id,
      sessions: sessions,
    );
  }

  @override
  Future<void> save(AISessionDataModel data) async {
    await _db.transaction(() async {
      // 删除旧数据
      await _db.delete(_db.attachments).go();
      await _db.delete(_db.messages).go();
      await _db.delete(_db.sessions).go();

      // 插入会话
      for (final s in data.sessions) {
        await _db.into(_db.sessions).insert(SessionsCompanion(
              id: Value(s.id),
              title: Value(s.title),
              createdAt: Value(s.createdAt),
              updatedAt: Value(s.updatedAt),
            ));

        for (final m in s.messages) {
          final msgId = await _db.into(_db.messages).insert(MessagesCompanion(
                sessionId: Value(s.id),
                role: Value(m.role),
                content: Value(m.content),
                createdAt: Value(DateTime.now().millisecondsSinceEpoch ~/ 1000),
              ));

          for (final a in m.attachments) {
            await _db.into(_db.attachments).insert(AttachmentsCompanion(
                  id: Value(a.id),
                  messageId: Value(msgId),
                  name: Value(a.name),
                  storedName: Value(a.storedName),
                  path: Value(a.path),
                  type: Value(a.type),
                  mimeType: Value(a.mimeType),
                  size: Value(a.size),
                  createdAt: Value(a.createdAt),
                ));
          }
        }
      }

      // 更新活跃会话
      await _db.into(_db.activeSession).insertOnConflictUpdate(
            ActiveSessionCompanion(
              id: const Value(1),
              sessionId: Value(data.activeSessionId),
            ),
          );
    });
  }
}
