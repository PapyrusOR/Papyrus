import 'package:flutter_test/flutter_test.dart';
import 'package:papyrus/data/models/log_entry_model.dart';
import 'package:papyrus/presentation/providers/log_provider.dart';

void main() {
  test('formats exported logs as newline-delimited plain text', () {
    final entries = [
      LogEntryModel(
        timestamp: 0,
        level: LogLevel.info,
        category: LogCategory.activity,
        message: 'reviewed card',
      ),
    ];

    final result = LogProvider.formatLogEntries(entries);

    expect(result, contains('reviewed card'));
    expect(result, endsWith('\n'));
  });
}
