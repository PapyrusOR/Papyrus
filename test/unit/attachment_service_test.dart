import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:papyrus/ai/services/attachment_service.dart';

void main() {
  group('AttachmentService', () {
    test('creates an image attachment from bytes', () {
      final bytes = Uint8List.fromList([1, 2, 3]);
      final attachment = AttachmentService.createFromBytes(
        fileName: 'diagram.png',
        bytes: bytes,
      );

      expect(attachment.name, 'diagram.png');
      expect(attachment.mimeType, 'image/png');
      expect(attachment.type, 'image');
      expect(attachment.size, 3);
      expect(attachment.bytes, same(bytes));
    });

    test('falls back to an opaque document MIME type', () {
      final attachment = AttachmentService.createFromBytes(
        fileName: 'data.unknown-extension',
        bytes: Uint8List(0),
      );

      expect(attachment.mimeType, 'application/octet-stream');
      expect(attachment.type, 'document');
    });

    test('uses in-memory text bytes for AI content', () async {
      final attachment = AttachmentService.createFromBytes(
        fileName: 'notes.txt',
        bytes: Uint8List.fromList(utf8.encode('hello web')),
      );

      final blocks = await AttachmentService.toOpenAIContentBlocks(attachment);

      expect(blocks.single['type'], 'text');
      expect(blocks.single['text'], contains('hello web'));
    });
  });
}
