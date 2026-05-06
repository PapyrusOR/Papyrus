extension StringExtensions on String {
  /// 检查字符串是否只包含 ASCII 字符
  bool get isAscii {
    for (final codeUnit in codeUnits) {
      if (codeUnit > 127) return false;
    }
    return true;
  }

  /// 掩码处理：前3字符 + *** + 后2字符
  /// 长度不足时返回全掩码
  String get masked {
    if (length <= 5) return '*' * length;
    return '${substring(0, 3)}***${substring(length - 2)}';
  }

  /// 截断字符串，超过长度时添加省略号并标注原始长度
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}... [原始长度: $length]';
  }

  /// 检查键名是否为敏感字段
  bool get isSensitiveKey {
    final lower = toLowerCase();
    return lower.contains('api_key') ||
        lower.contains('authorization') ||
        lower.contains('token') ||
        lower.contains('secret') ||
        lower.contains('password') ||
        lower.contains('key');
  }
}
