import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../data/models/ai_config_model.dart';
import '../providers/ai_config_provider.dart';
import '../widgets/settings/model_list_editor.dart';
import '../widgets/settings/parameter_slider.dart';
import '../widgets/settings/provider_editor.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < 600;

    return Consumer<AIConfigProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const ScaffoldPage(
            content: Center(child: ProgressRing()),
          );
        }

        final config = provider.config;
        final errors = provider.validationErrors;

        return ScaffoldPage.scrollable(
          header: const PageHeader(title: Text('设置')),
          children: [
            // 提供商配置
            ProviderEditor(
              providers: config.providers,
              currentProvider: config.currentProvider,
              onProviderChanged: (name) {
                provider.setProvider(name);
                final existing = config.providers[name];
                if (existing == null) {
                  final defaultUrls = {
                    'openai': 'https://api.openai.com/v1',
                    'anthropic': 'https://api.anthropic.com/v1',
                    'ollama': 'http://localhost:11434',
                    'custom': '',
                  };
                  provider.updateProviderConfig(
                    name,
                    AIProviderConfig(
                      baseUrl: defaultUrls[name] ?? '',
                      models: [],
                    ),
                  );
                }
              },
              onConfigChanged: (newConfig) {
                final current = config.currentProvider;
                if (current != null) {
                  provider.updateProviderConfig(current, newConfig);
                }
              },
            ),
            const SizedBox(height: 16),

            // 模型列表
            if (config.currentProvider != null)
              ModelListEditor(
                models: config.providers[config.currentProvider]?.models ?? [],
                selectedModel: config.currentModel,
                onModelSelected: (model) => provider.setModel(model),
                onModelAdded: (model) => provider.addModel(config.currentProvider!, model),
                onModelRemoved: (model) => provider.removeModel(config.currentProvider!, model),
              ),
            const SizedBox(height: 16),

            // 生成参数
            Card(
              child: Padding(
                padding: EdgeInsets.all(isNarrow ? 12 : 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('生成参数', style: FluentTheme.of(context).typography.bodyLarge),
                    const SizedBox(height: 12),
                    ParameterSlider(
                      label: 'Temperature',
                      value: config.parameters.temperature,
                      min: 0,
                      max: 2,
                      step: 0.1,
                      onChanged: (value) {
                        provider.updateParameters(config.parameters.copyWith(temperature: value));
                      },
                    ),
                    const SizedBox(height: 8),
                    ParameterSlider(
                      label: 'Max Tokens',
                      value: config.parameters.maxTokens.toDouble(),
                      min: 100,
                      max: 4000,
                      step: 100,
                      onChanged: (value) {
                        provider.updateParameters(
                          config.parameters.copyWith(maxTokens: value.round()),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    ParameterSlider(
                      label: 'Top P',
                      value: config.parameters.topP,
                      min: 0,
                      max: 1,
                      step: 0.1,
                      onChanged: (value) {
                        provider.updateParameters(config.parameters.copyWith(topP: value));
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 验证错误
            if (errors.isNotEmpty)
              InfoBar(
                title: const Text('配置有误'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: errors.entries
                      .where((e) => e.value != null)
                      .map((e) => Text('${e.key}: ${e.value}'))
                      .toList(),
                ),
                severity: InfoBarSeverity.warning,
              ),
            const SizedBox(height: 16),

            // 保存按钮
            isNarrow
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FilledButton(
                        onPressed: provider.hasChanges
                            ? () async {
                                final success = await provider.save();
                                if (success && context.mounted) {
                                  displayInfoBar(context, builder: (context, close) {
                                    return InfoBar(
                                      title: const Text('配置已保存'),
                                      severity: InfoBarSeverity.success,
                                      onClose: close,
                                    );
                                  });
                                }
                              }
                            : null,
                        child: const Text('保存配置'),
                      ),
                      if (provider.hasChanges) ...[
                        const SizedBox(height: 8),
                        const Center(
                          child: Text('有未保存的更改', style: TextStyle(color: Colors.warningPrimaryColor)),
                        ),
                      ],
                    ],
                  )
                : Row(
                    children: [
                      FilledButton(
                        onPressed: provider.hasChanges
                            ? () async {
                                final success = await provider.save();
                                if (success && context.mounted) {
                                  displayInfoBar(context, builder: (context, close) {
                                    return InfoBar(
                                      title: const Text('配置已保存'),
                                      severity: InfoBarSeverity.success,
                                      onClose: close,
                                    );
                                  });
                                }
                              }
                            : null,
                        child: const Text('保存配置'),
                      ),
                      if (provider.hasChanges) ...[
                        const SizedBox(width: 8),
                        const Text('有未保存的更改', style: TextStyle(color: Colors.warningPrimaryColor)),
                      ],
                    ],
                  ),
          ],
        );
      },
    );
  }
}
