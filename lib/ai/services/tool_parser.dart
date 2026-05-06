import 'dart:convert';

/// 从 AI 回复中解析工具调用 JSON 代码块
class ToolParser {
  ToolParser._();

  static final RegExp _jsonBlockPattern = RegExp(
    r'```json\s*\n(.*?)\n\s*```',
    dotAll: true,
  );

  /// 从文本中提取工具调用
  /// 返回 null 如果没有找到有效的工具调用
  static ToolCall? parse(String text) {
    final match = _jsonBlockPattern.firstMatch(text);
    if (match == null) return null;

    final jsonStr = match.group(1);
    if (jsonStr == null) return null;

    try {
      final json = jsonDecode(jsonStr.trim()) as Map<String, dynamic>;
      final tool = json['tool'] as String?;
      final params = json['params'] as Map<String, dynamic>?;

      if (tool == null || params == null) return null;

      return ToolCall(tool: tool, params: params);
    } catch (_) {
      return null;
    }
  }

  /// 检查文本中是否包含工具调用
  static bool hasToolCall(String text) {
    return _jsonBlockPattern.hasMatch(text);
  }
}

class ToolCall {
  final String tool;
  final Map<String, dynamic> params;

  ToolCall({
    required this.tool,
    required this.params,
  });
}
