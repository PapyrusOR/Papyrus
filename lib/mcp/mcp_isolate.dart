import 'dart:isolate';
import 'package:flutter/services.dart';
import '../data/local/app_database.dart';
import '../data/repositories/card_repository_impl.dart';
import '../logging/logger.dart';
import 'mcp_server.dart';

/// MCP 服务器 Isolate 包装器
class MCPIsolate {
  static SendPort? _sendPort;
  static Isolate? _isolate;

  static Future<void> start({
    String host = '127.0.0.1',
    int port = 8787,
  }) async {
    if (_isolate != null) return;

    final rootToken = RootIsolateToken.instance;
    if (rootToken == null) {
      throw StateError(
        'MCP server must be started from the Flutter root isolate',
      );
    }

    final receivePort = ReceivePort();
    _isolate = await Isolate.spawn(
      _isolateEntry,
      _IsolateInitMessage(
        sendPort: receivePort.sendPort,
        rootToken: rootToken,
        host: host,
        port: port,
      ),
    );

    final readyMessage = await receivePort.first;
    receivePort.close();
    if (readyMessage is! Map) {
      _isolate?.kill();
      _isolate = null;
      throw StateError('MCP isolate returned an invalid startup response');
    }
    final error = readyMessage['error'];
    if (error != null) {
      _isolate?.kill();
      _isolate = null;
      throw StateError('MCP server failed to start: $error');
    }
    _sendPort = readyMessage['sendPort'] as SendPort;
  }

  static Future<void> stop() async {
    final sendPort = _sendPort;
    if (sendPort != null) {
      final stopped = ReceivePort();
      sendPort.send(['stop', stopped.sendPort]);
      await stopped.first;
      stopped.close();
    }
    _isolate?.kill();
    _isolate = null;
    _sendPort = null;
  }

  static void _isolateEntry(_IsolateInitMessage init) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(init.rootToken);
    final receivePort = ReceivePort();
    AppDatabase? db;
    MCPServer? server;

    try {
      db = AppDatabase.defaults();
      Logger.instance.initialize(db);
      final repo = CardRepositoryImpl(db);
      server = MCPServer(repo);
      await server.start(host: init.host, port: init.port);
      init.sendPort.send({'sendPort': receivePort.sendPort});
    } catch (error) {
      init.sendPort.send({'error': error.toString()});
      receivePort.close();
      await db?.close();
      return;
    }

    await for (final message in receivePort) {
      if (message is List && message.firstOrNull == 'stop') {
        await server.stop();
        await db.close();
        if (message.length > 1 && message[1] is SendPort) {
          (message[1] as SendPort).send('stopped');
        }
        receivePort.close();
        break;
      }
    }
  }
}

class _IsolateInitMessage {
  final SendPort sendPort;
  final RootIsolateToken rootToken;
  final String host;
  final int port;

  _IsolateInitMessage({
    required this.sendPort,
    required this.rootToken,
    required this.host,
    required this.port,
  });
}
