import 'package:fluent_ui/fluent_ui.dart';

class ModelListEditor extends StatefulWidget {
  final List<String> models;
  final String? selectedModel;
  final ValueChanged<String>? onModelSelected;
  final ValueChanged<String>? onModelAdded;
  final ValueChanged<String>? onModelRemoved;

  const ModelListEditor({
    super.key,
    required this.models,
    this.selectedModel,
    this.onModelSelected,
    this.onModelAdded,
    this.onModelRemoved,
  });

  @override
  State<ModelListEditor> createState() => _ModelListEditorState();
}

class _ModelListEditorState extends State<ModelListEditor> {
  final _addController = TextEditingController();

  @override
  void dispose() {
    _addController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('模型', style: theme.typography.bodyLarge),
            const SizedBox(height: 12),
            if (widget.models.isNotEmpty)
              ComboBox<String>(
                value: widget.selectedModel,
                placeholder: const Text('选择模型'),
                items: widget.models.map((model) {
                  return ComboBoxItem(
                    value: model,
                    child: Text(model),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) widget.onModelSelected?.call(value);
                },
              )
            else
              const Text('暂无模型，请添加'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextBox(
                    controller: _addController,
                    placeholder: '输入模型名称',
                  ),
                ),
                const SizedBox(width: 8),
                Button(
                  onPressed: () {
                    final text = _addController.text.trim();
                    if (text.isNotEmpty) {
                      widget.onModelAdded?.call(text);
                      _addController.clear();
                    }
                  },
                  child: const Text('添加'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.models.map((model) {
                return Button(
                  onPressed: widget.models.length > 1
                      ? () => widget.onModelRemoved?.call(model)
                      : null,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(model),
                      if (widget.models.length > 1) ...[
                        const SizedBox(width: 4),
                        const WindowsIcon(WindowsIcons.chrome_close, size: 12),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
