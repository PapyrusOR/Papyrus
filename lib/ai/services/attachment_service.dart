import 'dart:convert';
import 'dart:io';
import 'package:mime/mime.dart' as mime;
import '../../core/constants/app_constants.dart';
import '../../core/utils/id_generator.dart';
import '../../data/models/ai_session_model.dart';

/// 附件处理服务：存储、Base64 转换、类型降级
class AttachmentService {
  AttachmentService._();

  static final Set<String> _imageTypes = {
    'image/png',
    'image/jpeg',
    'image/jpg',
    'image/webp',
    'image/gif',
  };

  static final Set<String> _textTypes = {
    'text/plain',
    'text/markdown',
    'text/x-markdown',
  };

  /// 判断是否为图片
  static bool isImage(String mimeType) => _imageTypes.contains(mimeType);

  /// 判断是否为纯文本文档
  static bool isTextDocument(String mimeType) => _textTypes.contains(mimeType);

  /// 从文件路径创建 AttachmentModel
  static Future<AttachmentModel> createFromFile(
    String filePath,
    String sessionUuid,
  ) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    final mimeType = mime.lookupMimeType(filePath) ?? 'application/octet-stream';
    final fileName = filePath.split(Platform.pathSeparator).last;
    final storedName = '${IdGenerator.uuid()}_$fileName';

    return AttachmentModel(
      id: IdGenerator.uuid(),
      name: fileName,
      storedName: storedName,
      path: filePath,
      type: isImage(mimeType) ? 'image' : 'document',
      mimeType: mimeType,
      size: bytes.length,
      createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );
  }

  /// 将附件转换为 OpenAI 格式的内容块
  static Future<List<Map<String, dynamic>>> toOpenAIContentBlocks(
    AttachmentModel attachment,
  ) async {
    final result = <Map<String, dynamic>>[];

    if (isImage(attachment.mimeType)) {
      final file = File(attachment.path);
      if (await file.exists()) {
        final bytes = await file.readAsBytes();
        final base64 = base64Encode(bytes);
        result.add({
          'type': 'image_url',
          'image_url': {
            'url': 'data:${attachment.mimeType};base64,$base64',
          },
        });
      }
    } else if (isTextDocument(attachment.mimeType)) {
      final file = File(attachment.path);
      if (await file.exists()) {
        final text = await file.readAsString();
        result.add({
          'type': 'text',
          'text': '--- 附件: ${attachment.name} ---\n$text',
        });
      }
    } else {
      // 其他文档类型标记为未解析
      result.add({
        'type': 'text',
        'text': '--- 附件: ${attachment.name} (已上传但未解析) ---',
      });
    }

    return result;
  }

  /// 非 OpenAI 模型降级：纯文本附加说明
  static Future<String> toTextDescription(AttachmentModel attachment) async {
    final buffer = StringBuffer();
    buffer.writeln('--- 附件: ${attachment.name} (${attachment.mimeType}) ---');

    if (isTextDocument(attachment.mimeType)) {
      try {
        final file = File(attachment.path);
        if (await file.exists()) {
          final text = await file.readAsString();
          final preview = text.length > 500 ? '${text.substring(0, 500)}...' : text;
          buffer.writeln('内容摘要:');
          buffer.writeln(preview);
        }
      } catch (_) {
        buffer.writeln('(无法读取内容)');
      }
    } else {
      buffer.writeln('(${isImage(attachment.mimeType) ? '图片' : '文档'} 文件，大小: ${attachment.size} 字节)');
    }

    return buffer.toString();
  }

  /// 验证附件大小和数量
  static String? validate(List<AttachmentModel> attachments, AttachmentModel newAttachment) {
    if (attachments.length >= AppConstants.maxAttachmentsPerMessage) {
      return '单次最多上传 ${AppConstants.maxAttachmentsPerMessage} 个文件';
    }
    if (newAttachment.size > AppConstants.maxAttachmentSizeBytes) {
      return '文件大小超过 ${AppConstants.maxAttachmentSizeBytes ~/ (1024 * 1024)}MB 限制';
    }
    return null;
  }
}
