import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../data/models/card_model.dart';
import '../providers/card_provider.dart';
import '../widgets/common/confirm_dialog.dart';

class CardManagerScreen extends StatefulWidget {
  const CardManagerScreen({super.key});

  @override
  State<CardManagerScreen> createState() => _CardManagerScreenState();
}

class _CardManagerScreenState extends State<CardManagerScreen> {
  final _searchController = TextEditingController();
  final _qController = TextEditingController();
  final _aController = TextEditingController();
  bool _isAdding = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CardProvider>().loadCards();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _qController.dispose();
    _aController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < 600;

    return Consumer<CardProvider>(
      builder: (context, provider, _) {
        final searchItems = provider.cards.map((card) => AutoSuggestBoxItem(
          value: card.id,
          label: card.q,
          child: Text(card.q, maxLines: 1, overflow: TextOverflow.ellipsis),
          onSelected: () {
            _searchController.text = card.q;
            provider.search(card.q);
          },
        )).toList();

        return ScaffoldPage(
          header: PageHeader(
            title: const Text('卡片管理'),
            commandBar: CommandBar(
              primaryItems: [
                CommandBarButton(
                  icon: const WindowsIcon(WindowsIcons.add, size: 16),
                  label: const Text('添加卡片'),
                  onPressed: () => setState(() => _isAdding = !_isAdding),
                ),
              ],
            ),
          ),
          content: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(isNarrow ? 12 : 16),
                child: AutoSuggestBox<String>(
                  controller: _searchController,
                  items: searchItems,
                  placeholder: '搜索题目或答案...',
                  leadingIcon: const Icon(WindowsIcons.search),
                  clearButtonEnabled: true,
                  onChanged: (text, reason) {
                    if (text.isEmpty) {
                      provider.loadCards();
                    } else {
                      provider.search(text);
                    }
                  },
                  onSelected: (item) {
                    item.onSelected?.call();
                  },
                ),
              ),
              if (_isAdding) _buildAddForm(provider, isNarrow),
              Expanded(
                child: provider.isLoading
                    ? const Center(child: ProgressRing())
                    : _buildCardList(provider, isNarrow),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddForm(CardProvider provider, bool isNarrow) {
    final padding = isNarrow ? 12.0 : 16.0;
    return Container(
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.symmetric(horizontal: padding),
      decoration: BoxDecoration(
        color: FluentTheme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: FluentTheme.of(context).resources.cardStrokeColorDefault,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBox(
            controller: _qController,
            placeholder: '题目',
            maxLines: 3,
            minLines: 2,
          ),
          const SizedBox(height: 8),
          TextBox(
            controller: _aController,
            placeholder: '答案',
            maxLines: 5,
            minLines: 3,
          ),
          const SizedBox(height: 12),
          isNarrow
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FilledButton(
                      onPressed: () => _saveCard(provider),
                      child: const Text('保存'),
                    ),
                    const SizedBox(height: 8),
                    Button(
                      onPressed: () => setState(() => _isAdding = false),
                      child: const Text('取消'),
                    ),
                  ],
                )
              : Row(
                  children: [
                    FilledButton(
                      onPressed: () => _saveCard(provider),
                      child: const Text('保存'),
                    ),
                    const SizedBox(width: 8),
                    Button(
                      onPressed: () => setState(() => _isAdding = false),
                      child: const Text('取消'),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Future<void> _saveCard(CardProvider provider) async {
    final q = _qController.text.trim();
    final a = _aController.text.trim();
    if (q.isEmpty || a.isEmpty) {
      displayInfoBar(context, builder: (context, close) {
        return InfoBar(
          title: const Text('题目和答案均为必填项'),
          severity: InfoBarSeverity.warning,
          onClose: close,
        );
      });
      return;
    }
    await provider.addCard(q, a);
    _qController.clear();
    _aController.clear();
    setState(() => _isAdding = false);
  }

  Widget _buildCardList(CardProvider provider, bool isNarrow) {
    final cards = provider.cards;
    if (cards.isEmpty) {
      return const Center(
        child: Text('暂无卡片，点击上方按钮添加'),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(isNarrow ? 12 : 16),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return _CardListItem(
          card: card,
          isNarrow: isNarrow,
          onDelete: () => _deleteCard(card),
        );
      },
    );
  }

  Future<void> _deleteCard(CardModel card) async {
    final confirmed = await showConfirmDialog(
      context: context,
      title: '删除卡片',
      content: '确定要删除这张卡片吗？\n\n题目: ${card.q}',
    );
    if (confirmed && mounted) {
      await context.read<CardProvider>().deleteCard(card.id);
    }
  }
}

class _CardListItem extends StatelessWidget {
  final CardModel card;
  final bool isNarrow;
  final VoidCallback onDelete;

  const _CardListItem({
    required this.card,
    required this.isNarrow,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(
          card.q,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.typography.body?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          card.a,
          maxLines: isNarrow ? 1 : 2,
          overflow: TextOverflow.ellipsis,
          style: theme.typography.caption?.copyWith(
            color: theme.resources.textFillColorSecondary,
          ),
        ),
        trailing: IconButton(
          icon: const WindowsIcon(WindowsIcons.delete, size: 18),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
