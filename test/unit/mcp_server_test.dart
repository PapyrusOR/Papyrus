import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:papyrus/data/local/app_database.dart';
import 'package:papyrus/data/repositories/card_repository_impl.dart';
import 'package:papyrus/logging/logger.dart';
import 'package:papyrus/mcp/mcp_server.dart';

void main() {
  test('MCP server serves health, tools, and structured calls', () async {
    final db = AppDatabase(NativeDatabase.memory());
    Logger.instance.initialize(db);
    final server = MCPServer(CardRepositoryImpl(db));
    final client = HttpClient();

    try {
      await server.start(port: 0);
      final port = server.boundPort;
      expect(port, isNotNull);

      final health = await _getJson(client, port!, '/health');
      expect(health['status'], 'ok');
      expect(health['api_version'], '1.1');

      final tools = await _getJson(client, port, '/tools');
      final names = (tools['tools'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((tool) => tool['name'])
          .toSet();
      expect(
        names,
        containsAll(['list_cards', 'get_card', 'get_due_cards', 'review_card']),
      );

      final create = await _postJson(client, port, '/call', {
        'tool': 'create_card',
        'params': {'question': 'Question', 'answer': 'Answer'},
      });
      final result = create['result'] as Map<String, dynamic>;
      expect((result['card'] as Map<String, dynamic>)['q'], 'Question');
    } finally {
      client.close(force: true);
      await server.stop();
      await Future<void>.delayed(const Duration(milliseconds: 50));
      await db.close();
    }
  });
}

Future<Map<String, dynamic>> _getJson(
  HttpClient client,
  int port,
  String path,
) async {
  final request = await client.getUrl(Uri.parse('http://127.0.0.1:$port$path'));
  return _readJson(await request.close());
}

Future<Map<String, dynamic>> _postJson(
  HttpClient client,
  int port,
  String path,
  Map<String, dynamic> body,
) async {
  final request = await client.postUrl(
    Uri.parse('http://127.0.0.1:$port$path'),
  );
  request.headers.contentType = ContentType.json;
  request.write(jsonEncode(body));
  return _readJson(await request.close());
}

Future<Map<String, dynamic>> _readJson(HttpClientResponse response) async {
  expect(response.statusCode, HttpStatus.ok);
  final body = await utf8.decoder.bind(response).join();
  return jsonDecode(body) as Map<String, dynamic>;
}
