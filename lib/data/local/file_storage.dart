import 'dart:convert';
import 'dart:io';

/// 通用文件读写封装，强制使用原子替换策略
class FileStorage {
  FileStorage._();

  /// 原子写入：先写 .tmp 文件，再 rename 覆盖目标文件
  static Future<void> writeAtomic(String path, String content) async {
    final tempPath = '$path.tmp';
    final tempFile = File(tempPath);
    await tempFile.writeAsString(content, flush: true);
    await tempFile.rename(path);
  }

  /// 读取文本文件，文件不存在时返回 null
  static Future<String?> readString(String path) async {
    final file = File(path);
    if (!await file.exists()) return null;
    return file.readAsString();
  }

  /// 写入 JSON 对象（带 UTF-8 和缩进格式化）
  static Future<void> writeJson(String path, Map<String, dynamic> json) async {
    final content = const JsonEncoder.withIndent('  ').convert(json);
    await writeAtomic(path, content);
  }

  /// 写入 JSON 数组
  static Future<void> writeJsonList(String path, List<Map<String, dynamic>> list) async {
    final content = const JsonEncoder.withIndent('  ').convert(list);
    await writeAtomic(path, content);
  }

  /// 读取 JSON 对象
  static Future<Map<String, dynamic>?> readJson(String path) async {
    final content = await readString(path);
    if (content == null || content.isEmpty) return null;
    try {
      return jsonDecode(content) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  /// 读取 JSON 数组
  static Future<List<dynamic>?> readJsonList(String path) async {
    final content = await readString(path);
    if (content == null || content.isEmpty) return null;
    try {
      return jsonDecode(content) as List<dynamic>;
    } catch (_) {
      return null;
    }
  }

  /// 追加写入文本（用于日志）
  static Future<void> appendString(String path, String content) async {
    final file = File(path);
    await file.writeAsString('$content\n', mode: FileMode.append, flush: true);
  }

  /// 确保目录存在
  static Future<void> ensureDirectory(String dirPath) async {
    final dir = Directory(dirPath);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
  }
}
