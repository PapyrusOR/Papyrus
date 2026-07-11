import 'dart:typed_data';

class AttachmentModel {
  final String id;
  final String name;
  final String storedName;
  final String path;
  final String type; // 'image' | 'document'
  final String mimeType;
  final int size;
  final int createdAt;
  final Uint8List? bytes;

  AttachmentModel({
    required this.id,
    required this.name,
    required this.storedName,
    required this.path,
    required this.type,
    required this.mimeType,
    required this.size,
    required this.createdAt,
    this.bytes,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      storedName: json['stored_name'] as String? ?? '',
      path: json['path'] as String? ?? '',
      type: json['type'] as String? ?? 'document',
      mimeType: json['mime_type'] as String? ?? '',
      size: (json['size'] as num?)?.toInt() ?? 0,
      createdAt: (json['created_at'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'stored_name': storedName,
    'path': path,
    'type': type,
    'mime_type': mimeType,
    'size': size,
    'created_at': createdAt,
  };
}

class MessageModel {
  final String role; // 'user' | 'assistant' | 'system'
  final String content;
  final List<AttachmentModel> attachments;

  MessageModel({
    required this.role,
    required this.content,
    this.attachments = const [],
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      role: json['role'] as String? ?? 'user',
      content: json['content'] as String? ?? '',
      attachments:
          (json['attachments'] as List<dynamic>?)
              ?.map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'role': role,
    'content': content,
    'attachments': attachments.map((e) => e.toJson()).toList(),
  };
}

class SessionModel {
  final String id;
  String title;
  final List<MessageModel> messages;
  final int createdAt;
  int updatedAt;

  SessionModel({
    required this.id,
    required this.title,
    this.messages = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '新会话',
      messages:
          (json['messages'] as List<dynamic>?)
              ?.map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: (json['created_at'] as num?)?.toInt() ?? 0,
      updatedAt: (json['updated_at'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'messages': messages.map((e) => e.toJson()).toList(),
    'created_at': createdAt,
    'updated_at': updatedAt,
  };

  int get messageCount => messages.length;
}

class AISessionDataModel {
  String activeSessionId;
  final List<SessionModel> sessions;

  AISessionDataModel({required this.activeSessionId, this.sessions = const []});

  factory AISessionDataModel.fromJson(Map<String, dynamic> json) {
    return AISessionDataModel(
      activeSessionId: json['active_session_id'] as String? ?? '',
      sessions:
          (json['sessions'] as List<dynamic>?)
              ?.map((e) => SessionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'active_session_id': activeSessionId,
    'sessions': sessions.map((e) => e.toJson()).toList(),
  };

  /// 按 updated_at 倒序排列的会话列表
  List<SessionModel> get sortedSessions {
    final list = List<SessionModel>.from(sessions);
    list.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return list;
  }

  SessionModel? get activeSession {
    try {
      return sessions.firstWhere((s) => s.id == activeSessionId);
    } catch (_) {
      return sessions.isNotEmpty ? sessions.first : null;
    }
  }
}
