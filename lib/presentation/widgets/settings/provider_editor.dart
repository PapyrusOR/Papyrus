import 'package:fluent_ui/fluent_ui.dart';
import '../../../data/models/ai_config_model.dart';

class ProviderEditor extends StatelessWidget {
  final Map<String, AIProviderConfig> providers;
  final String? currentProvider;
  final ValueChanged<String>? onProviderChanged;
  final ValueChanged<AIProviderConfig>? onConfigChanged;

  const ProviderEditor({
    super.key,
    required this.providers,
    this.currentProvider,
    this.onProviderChanged,
    this.onConfigChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final providerNames = ['openai', 'anthropic', 'ollama', 'custom'];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('提供商', style: theme.typography.bodyLarge),
            const SizedBox(height: 12),
            ComboBox<String>(
              value: currentProvider,
              placeholder: const Text('选择提供商'),
              items: providerNames.map((name) {
                return ComboBoxItem(
                  value: name,
                  child: Text(name.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) onProviderChanged?.call(value);
              },
            ),
            const SizedBox(height: 16),
            if (currentProvider != null) ...[
              _buildConfigForm(currentProvider!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildConfigForm(String providerName) {
    final config = providers[providerName] ?? AIProviderConfig(baseUrl: '');
    final apiKeyController = TextEditingController(text: config.apiKey ?? '');
    final baseUrlController = TextEditingController(text: config.baseUrl);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (providerName != 'ollama') ...[
          InfoLabel(
            label: 'API Key',
            child: TextBox(
              controller: apiKeyController,
              placeholder: '输入 API Key',
              obscureText: true,
              onChanged: (value) {
                onConfigChanged?.call(config.copyWith(apiKey: value));
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
        InfoLabel(
          label: 'Base URL',
          child: TextBox(
            controller: baseUrlController,
            placeholder: providerName == 'ollama'
                ? 'http://localhost:11434'
                : 'https://api.openai.com/v1',
            onChanged: (value) {
              onConfigChanged?.call(config.copyWith(baseUrl: value));
            },
          ),
        ),
      ],
    );
  }
}
