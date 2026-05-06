import 'package:flutter/material.dart';
import '../../core/utils/id_generator.dart';
import '../../data/models/ai_session_model.dart';
import '../../data/repositories/ai_session_repository.dart';

class SessionProvider extends ChangeNotifier {
  final AISessionRepository _repository;

  SessionProvider(this._repository) {
    _loadSessions();
  }

  AISessionDataModel _data = AISessionDataModel(activeSessionId: '');
  bool _isLoading = false;

  List<SessionModel> get sessions => _data.sortedSessions;
  SessionModel? get activeSession => _data.activeSession;
  bool get isLoading => _isLoading;

  Future<void> _loadSessions() async {
    _isLoading = true;
    notifyListeners();

    final loaded = await _repository.load();
    if (loaded != null && loaded.sessions.isNotEmpty) {
      _data = loaded;
    } else {
      // 始终保留至少一个会话
      final defaultSession = _createDefaultSession();
      _data = AISessionDataModel(
        activeSessionId: defaultSession.id,
        sessions: [defaultSession],
      );
      await _repository.save(_data);
    }

    _isLoading = false;
    notifyListeners();
  }

  SessionModel _createDefaultSession() {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return SessionModel(
      id: IdGenerator.uuid(),
      title: '新会话',
      createdAt: now,
      updatedAt: now,
    );
  }

  Future<void> createSession() async {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final session = SessionModel(
      id: IdGenerator.uuid(),
      title: '新会话',
      createdAt: now,
      updatedAt: now,
    );
    _data.sessions.add(session);
    _data.activeSessionId = session.id;
    await _repository.save(_data);
    notifyListeners();
  }

  Future<void> switchSession(String sessionId) async {
    _data.activeSessionId = sessionId;
    await _repository.save(_data);
    notifyListeners();
  }

  Future<void> renameSession(String sessionId, String newTitle) async {
    if (newTitle.trim().isEmpty) return;
    final session = _data.sessions.firstWhere((s) => s.id == sessionId);
    session.title = newTitle.trim();
    session.updatedAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    await _repository.save(_data);
    notifyListeners();
  }

  Future<void> deleteSession(String sessionId) async {
    if (_data.sessions.length <= 1) return; // 至少保留一个

    _data.sessions.removeWhere((s) => s.id == sessionId);

    // 如果删除的是当前活跃会话，切换到剩余会话中的第一个
    if (_data.activeSessionId == sessionId) {
      _data.activeSessionId = _data.sessions.first.id;
    }

    await _repository.save(_data);
    notifyListeners();
  }

  Future<void> addMessageToActiveSession(String role, String content) async {
    final session = activeSession;
    if (session == null) return;

    session.messages.add(MessageModel(role: role, content: content));
    session.updatedAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    await _repository.save(_data);
    notifyListeners();
  }

  Future<void> clearActiveSessionMessages() async {
    final session = activeSession;
    if (session == null) return;

    // "清空对话" = 新建会话（保留旧会话历史，开启新上下文）
    await createSession();
  }
}
