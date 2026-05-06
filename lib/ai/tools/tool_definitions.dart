/// AI 工具定义
class ToolDefinitions {
  ToolDefinitions._();

  static const List<Map<String, dynamic>> definitions = [
    {
      'name': 'create_card',
      'description': '创建一张新的学习卡片',
      'parameters': {
        'type': 'object',
        'properties': {
          'question': {'type': 'string', 'description': '题目'},
          'answer': {'type': 'string', 'description': '答案'},
          'tags': {'type': 'array', 'items': {'type': 'string'}, 'description': '标签列表'},
        },
        'required': ['question', 'answer'],
      },
    },
    {
      'name': 'update_card',
      'description': '更新指定卡片的内容',
      'parameters': {
        'type': 'object',
        'properties': {
          'card_index': {'type': 'integer', 'description': '卡片索引'},
          'question': {'type': 'string', 'description': '新题目'},
          'answer': {'type': 'string', 'description': '新答案'},
        },
        'required': ['card_index'],
      },
    },
    {
      'name': 'delete_card',
      'description': '删除指定卡片',
      'parameters': {
        'type': 'object',
        'properties': {
          'card_index': {'type': 'integer', 'description': '卡片索引'},
        },
        'required': ['card_index'],
      },
    },
    {
      'name': 'search_cards',
      'description': '按关键词搜索卡片',
      'parameters': {
        'type': 'object',
        'properties': {
          'keyword': {'type': 'string', 'description': '搜索关键词'},
        },
        'required': ['keyword'],
      },
    },
    {
      'name': 'get_card_stats',
      'description': '获取学习统计信息',
      'parameters': {
        'type': 'object',
        'properties': {},
      },
    },
  ];

  static String get toolPrompt {
    final buffer = StringBuffer();
    buffer.writeln('你可以使用以下工具来操作卡片数据。当你需要执行操作时，请回复如下格式的 JSON 代码块:');
    buffer.writeln();
    buffer.writeln('```json');
    buffer.writeln('{');
    buffer.writeln('  "tool": "工具名",');
    buffer.writeln('  "params": { ...参数... }');
    buffer.writeln('}');
    buffer.writeln('```');
    buffer.writeln();
    buffer.writeln('可用工具:');
    for (final def in definitions) {
      buffer.writeln('- ${def['name']}: ${def['description']}');
    }
    return buffer.toString();
  }
}
