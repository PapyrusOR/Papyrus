import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Intents
class ShowAnswerIntent extends Intent {
  const ShowAnswerIntent();
}

class GradeCardIntent extends Intent {
  final int grade;
  const GradeCardIntent(this.grade);
}

class SearchCardsIntent extends Intent {
  const SearchCardsIntent();
}

/// 学习界面快捷键配置
class StudyShortcuts {
  StudyShortcuts._();

  static final Map<ShortcutActivator, Intent> shortcuts = {
    const SingleActivator(LogicalKeyboardKey.space): const ShowAnswerIntent(),
    const SingleActivator(LogicalKeyboardKey.digit1): const GradeCardIntent(1),
    const SingleActivator(LogicalKeyboardKey.digit2): const GradeCardIntent(2),
    const SingleActivator(LogicalKeyboardKey.digit3): const GradeCardIntent(3),
    const SingleActivator(LogicalKeyboardKey.numpad1): const GradeCardIntent(1),
    const SingleActivator(LogicalKeyboardKey.numpad2): const GradeCardIntent(2),
    const SingleActivator(LogicalKeyboardKey.numpad3): const GradeCardIntent(3),
  };
}
