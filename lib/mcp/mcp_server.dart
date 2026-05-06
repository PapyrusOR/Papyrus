import 'dart:convert';
import 'dart:io';
import '../ai/services/tool_parser.dart';
import '../ai/tools/tool_executor.dart';
import '../data/repositories/card_repository.dart';

/// MCP HTTP 服务器
class MCPServer {
  HttpServer? _server;
  final CardRepository _cardRepository;

  MCPServer(this._cardRepository);

  bool get isRunning => _server != null;

  Future<void> start({String host = '127.0.0.1', int port = 8787}) async {
    if (_server != null) return;

    _server = await HttpServer.bind(host, port);
    print('MCP Server running on http://$host:$port');

    await for (final request in _server!) {
      _handleRequest(request);
    }
  }

  Future<void> stop() async {
    await _server?.close();
    _server = null;
    print('MCP Server stopped');
  }

  void _handleRequest(HttpRequest request) {
    // CORS 头
    request.response.headers.add('Access-Control-Allow-Origin', '*');
    request.response.headers.add('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    request.response.headers.add('Access-Control-Allow-Headers', 'Content-Type');

    if (request.method == 'OPTIONS') {
      request.response.statusCode = HttpStatus.noContent;
      request.response.close();
      return;
    }

    final path = request.uri.path;

    switch (path) {
      case '/health':
        _handleHealth(request);
        break;
      case '/tools':
        _handleTools(request);
        break;
      case '/call':
        _handleCall(request);
        break;
      default:
        request.response.statusCode = HttpStatus.notFound;
        request.response.write(jsonEncode({'error': 'Not found'}));
        request.response.close();
    }
  }

  void _handleHealth(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.ok
      ..write(jsonEncode({'status': 'ok'}))
      ..close();
  }

  void _handleTools(HttpRequest request) {
    final tools = [
      {'name': 'create_card', 'description': '创建新卡片'},
      {'name': 'update_card', 'description': '更新卡片'},
      {'name': 'delete_card', 'description': '删除卡片'},
      {'name': 'search_cards', 'description': '搜索卡片'},
      {'name': 'get_card_stats', 'description': '获取统计'},
    ];
    request.response
      ..statusCode = HttpStatus.ok
      ..write(jsonEncode({'tools': tools}))
      ..close();
  }

  Future<void> _handleCall(HttpRequest request) async {
    if (request.method != 'POST') {
      request.response.statusCode = HttpStatus.methodNotAllowed;
      request.response.close();
      return;
    }

    try {
      final body = await utf8.decoder.bind(request).join();
      final json = jsonDecode(body) as Map<String, dynamic>;
      final tool = json['tool'] as String?;
      final params = json['params'] as Map<String, dynamic>? ?? {};

      if (tool == null) {
        request.response.statusCode = HttpStatus.badRequest;
        request.response.write(jsonEncode({'error': 'Missing tool name'}));
        request.response.close();
        return;
      }

      final executor = ToolExecutor(_cardRepository);
      final result = await executor.execute(ToolCall(tool: tool, params: params));

      request.response
        ..statusCode = HttpStatus.ok
        ..write(jsonEncode({'result': result}))
        ..close();
    } catch (e) {
      request.response.statusCode = HttpStatus.internalServerError;
      request.response.write(jsonEncode({'error': e.toString()}));
      request.response.close();
    }
  }
}
