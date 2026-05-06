import 'dart:isolate';
import '../data/local/app_database.dart';
import '../data/repositories/card_repository_impl.dart';
import 'mcp_server.dart';

/// MCP 服务器 Isolate 包装器
class MCPIsolate {
  static SendPort? _sendPort;
  static Isolate? _isolate;

  static Future<void> start({String host = '127.0.0.1', int port = 8787}) async {
    if (_isolate != null) return;

    final receivePort = ReceivePort();
    _isolate = await Isolate.spawn(
      _isolateEntry,
      _IsolateInitMessage(
        sendPort: receivePort.sendPort,
        host: host,
        port: port,
      ),
    );

    _sendPort = await receivePort.first as SendPort;
  }

  static Future<void> stop() async {
    _sendPort?.send('stop');
    _isolate?.kill();
    _isolate = null;
    _sendPort = null;
  }

  static void _isolateEntry(_IsolateInitMessage init) async {
    final receivePort = ReceivePort();
    init.sendPort.send(receivePort.sendPort);

    final db = AppDatabase.defaults();
    final repo = CardRepositoryImpl(db);
    final server = MCPServer(repo);
    await server.start(host: init.host, port: init.port);

    await for (final message in receivePort) {
      if (message == 'stop') {
        await server.stop();
        await db.close();
        break;
      }
    }
  }
}

class _IsolateInitMessage {
  final SendPort sendPort;
  final String host;
  final int port;

  _IsolateInitMessage({
    required this.sendPort,
    required this.host,
    required this.port,
  });
}
