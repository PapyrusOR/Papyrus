import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/constants/keyboard_shortcuts.dart';
import '../providers/study_provider.dart';
import '../widgets/study/card_face_widget.dart';
import '../widgets/study/empty_due_widget.dart';
import '../widgets/study/grade_buttons.dart';
import '../widgets/study/study_status_bar.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StudyProvider>().loadDueCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < 600;
    final padding = isNarrow
        ? const EdgeInsets.symmetric(horizontal: 16, vertical: 16)
        : const EdgeInsets.all(32);

    return Consumer<StudyProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: ProgressRing());
        }

        return Shortcuts(
          shortcuts: StudyShortcuts.shortcuts,
          child: Actions(
            actions: <Type, Action<Intent>>{
              ShowAnswerIntent: CallbackAction<ShowAnswerIntent>(
                onInvoke: (_) => provider.showAnswer(),
              ),
              GradeCardIntent: CallbackAction<GradeCardIntent>(
                onInvoke: (intent) => provider.grade(intent.grade),
              ),
            },
            child: Focus(
              autofocus: true,
              child: Column(
                children: [
                  Expanded(child: _buildBody(provider, padding, isNarrow)),
                  StudyStatusBar(
                    dueCount: provider.remainingDueCount,
                    totalCount: provider.totalCount,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(StudyProvider provider, EdgeInsets padding, bool isNarrow) {
    switch (provider.state) {
      case StudyState.noCards:
        return EmptyDueWidget(
          hasCards: false,
          onRefresh: () => provider.loadDueCards(),
        );
      case StudyState.noDueCards:
        return EmptyDueWidget(onRefresh: () => provider.loadDueCards());
      case StudyState.question:
        return _buildQuestionView(provider, padding, isNarrow);
      case StudyState.answer:
        return _buildAnswerView(provider, padding, isNarrow);
    }
  }

  Widget _buildQuestionView(
    StudyProvider provider,
    EdgeInsets padding,
    bool isNarrow,
  ) {
    final card = provider.currentCard;
    if (card == null) return const EmptyDueWidget();

    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardFaceWidget(title: '题目', content: card.q),
            SizedBox(height: padding.horizontal > 32 ? 32 : 20),
            FilledButton(
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(
                    horizontal: isNarrow ? 24 : 32,
                    vertical: isNarrow ? 12 : 16,
                  ),
                ),
              ),
              onPressed: provider.showAnswer,
              child: const Text('显示答案 (Space)'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerView(
    StudyProvider provider,
    EdgeInsets padding,
    bool isNarrow,
  ) {
    final card = provider.currentCard;
    if (card == null) return const EmptyDueWidget();

    return Center(
      child: SingleChildScrollView(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardFaceWidget(title: '题目', content: card.q),
            SizedBox(height: padding.horizontal > 32 ? 24 : 16),
            CardFaceWidget(title: '答案', content: card.a, isAnswer: true),
            SizedBox(height: padding.horizontal > 32 ? 32 : 20),
            GradeButtons(
              enabled: provider.canGrade,
              onForgot: () => provider.grade(1),
              onVague: () => provider.grade(2),
              onMastered: () => provider.grade(3),
            ),
            if (!provider.canGrade)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  '请稍候...',
                  style: FluentTheme.of(context).typography.caption?.copyWith(
                    color: FluentTheme.of(
                      context,
                    ).resources.textFillColorSecondary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
