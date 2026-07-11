import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

Future<String> exportLogText(String fileName, String contents) async {
  await FilePicker.platform.saveFile(
    dialogTitle: 'Export Papyrus logs',
    fileName: fileName,
    bytes: Uint8List.fromList(utf8.encode(contents)),
  );
  return fileName;
}
