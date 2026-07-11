import 'dart:io';

import 'path_resolver.dart';

Future<String> exportLogText(String fileName, String contents) async {
  final dataDirectory = await PathResolver.dataDir;
  final file = File('${dataDirectory.path}${Platform.pathSeparator}$fileName');
  await file.writeAsString(contents);
  return file.path;
}
