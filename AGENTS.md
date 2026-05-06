# Papyrus — Agent 开发指南

> **项目**: Papyrus Flutter 全平台应用  
> **Flutter SDK**: 3.41.x (当前 3.41.9)  
> **Dart SDK**: 3.11.x (当前 3.11.5)  
> **UI 框架**: fluent_ui v4.15.x  
> **PRD**: `PRD.md` v1.2.2  
> **结构文档**: `STRUCTURE.md` v1.0.0  

---

## 1. 项目背景

Papyrus 是一款以卡片（Flashcard）为知识载体的**间隔重复（Spaced Repetition）学习工具**，内置 AI 学习助手。核心设计哲学为：**极简、键盘驱动、流状态（Flow State）优先**。

**核心定位**:
- **学习引擎**: 基于 SM-2 算法的科学记忆调度系统。
- **知识库**: 用户可手动创建或批量导入卡片，形成个人知识库。
- **AI 副驾驶**: 在学习过程中提供实时提示、解释、扩展和相关练习生成，并可主动操作卡片数据。

**设计原则**（开发时必须遵守）:
1. **无鼠标操作**: 核心学习流程应完全可通过键盘完成。
2. **本地优先**: 用户数据默认存储在本地，不上传云端。
3. **容错与降级**: AI 模块为可选依赖；缺失时主学习功能必须正常运行。
4. **隐私保护**: API 密钥等敏感信息在界面上应脱敏显示，配置中需做合法性校验。

---

## 2. 技术栈与运行环境

### 2.1 已安装依赖

```yaml
dependencies:
  flutter:
    sdk: flutter
  fluent_ui: ^4.15.1        # Windows Fluent Design UI 框架
```

### 2.2 后续需添加的关键依赖

在实现具体模块时，按需在 `pubspec.yaml` 中添加：

```yaml
  provider: ^6.1.0          # 状态管理（ChangeNotifier 包装）
  path_provider: ^2.1.0     # 跨平台应用目录路径获取
  shared_preferences: ^2.3.0 # 轻量 KV 缓存（仅启动配置）
  http: ^1.2.0              # AI API HTTP 请求（含 SSE 流式解析）
  file_picker: ^8.0.0       # 文件选择器（批量导入、附件上传）
  mime: ^1.0.0              # MIME 类型识别
  path: ^1.9.0              # 路径拼接工具
  intl: ^0.20.0             # 国际化、日期格式化
  uuid: ^4.0.0              # UUID 生成（附件、会话隔离目录）
  json_annotation: ^4.9.0   # JSON 序列化注解
```

**添加后必须执行**: `flutter pub get`

### 2.3 本地参考资源

项目根目录下 `参考fluent_ui文档/fluent_ui-4.15.0/` 为 fluent_ui 源码克隆，开发中遇到 UI 组件使用问题时可直接查阅源码：

```
参考fluent_ui文档/fluent_ui-4.15.0/lib/src/
├── controls/
│   ├── buttons/             # Button, FilledButton, OutlinedButton, HyperlinkButton
│   ├── form/                # TextBox, TextFormBox, PasswordBox, ComboBox, NumberBox
│   ├── flyouts/             # Flyout, MenuFlyout, Tooltip
│   ├── inputs/              # Slider, ToggleSwitch, Checkbox
│   ├── layout/              # Expander, Card, CommandBar
│   ├── navigation/          # NavigationView, PaneItem, TabView
│   ├── pickers/             # ColorPicker, DatePicker, TimePicker
│   └── surfaces/            # Acrylic, Mica, Dialog, ContentDialog
└── styles/                  # FluentTheme, ThemeData, 颜色/字体主题
```

---

## 3. 架构约定

### 3.1 目录层级规范

所有新代码文件必须按 `STRUCTURE.md` 的目录结构放置，禁止在根目录随意创建文件。

```
lib/
├── core/          # 纯工具/常量/扩展，无业务逻辑
├── data/          # 模型定义 + 仓库实现（IO 操作）
├── domain/        # 纯 Dart 业务逻辑（算法、服务、用例），无 Flutter 依赖
├── presentation/  # UI + 状态管理（Provider/ChangeNotifier）
├── ai/            # AI 模块（可选，必须支持降级）
├── mcp/           # MCP HTTP 服务器（可选，Isolate 隔离）
└── logging/       # 日志系统（支持依赖注入）
```

**分层依赖规则**（严禁反向依赖）:
```
presentation → domain → data → core
      ↓           ↓        ↓
    ai / logging / mcp 可横向调用 domain / data，但不可被它们依赖
```

### 3.2 状态管理规范

- **统一使用 `ChangeNotifier` + `Provider`**，禁止引入 Riverpod / Bloc / GetX 等其他方案。
- Provider 类统一放在 `lib/presentation/providers/`。
- 每个 Provider 只管理一个业务域的状态（如 `StudyProvider` 只管学习区状态）。
- Provider 中禁止直接调用 `dart:io` 或 UI 相关 API；所有 IO 通过 Repository 接口。

```dart
// ✅ 正确: Provider 依赖 Repository 接口
class StudyProvider extends ChangeNotifier {
  final CardRepository _cardRepo;
  StudyProvider(this._cardRepo);
}

// ❌ 错误: Provider 直接操作文件
class StudyProvider extends ChangeNotifier {
  Future<void> load() async {
    final file = File('/some/path/cards.json'); // 禁止！
  }
}
```

### 3.3 数据持久化规范

- 所有文件路径通过 `path_provider` 获取，禁止硬编码任何绝对路径。
- JSON 文件写入必须使用**原子替换策略**（先写 `.tmp` 再 `rename`）。
- 数据目录结构见 `STRUCTURE.md` 第 3.2 节。
- Web 平台 `dart:io` 不可用，所有数据操作必须通过条件编译或 Repository 接口降级。

```dart
import 'dart:io';

Future<void> writeAtomic(String path, String content) async {
  final temp = File('$path.tmp');
  await temp.writeAsString(content, flush: true);
  await temp.rename(path);
}
```

### 3.4 AI 模块降级规范

AI 模块是**可选依赖**。任何依赖 AI 的功能必须提供无 AI 的降级路径：

```dart
class AIChatProvider extends ChangeNotifier {
  bool _isAvailable = false;
  bool get isAvailable => _isAvailable;

  Future<void> initialize() async {
    try {
      final config = await _configRepo.load();
      _isAvailable = config.currentProvider != null && config.isValid;
    } catch (_) {
      _isAvailable = false;
    }
    notifyListeners();
  }
}
```

UI 中：
```dart
if (!aiChatProvider.isAvailable)
  const InfoBar(title: Text('AI 助手未配置'), content: Text('前往设置配置 API 密钥'));
```

---

## 4. 编码规范

### 4.1 Dart 风格

- 遵循 `flutter_lints` 规则（已配置在 `analysis_options.yaml`）。
- 命名：类用 `PascalCase`，文件用 `snake_case`，私有成员用 `_camelCase`。
- 异步方法返回 `Future<void>` 时显式标注，不使用裸 `void` 省略。

### 4.2 JSON 序列化

**推荐手写 `fromJson`/`toJson`**，减少代码生成依赖，便于向后兼容处理：

```dart
class CardModel {
  final String q;
  final String a;
  final int nextReview;
  final int interval;
  final double ef;
  final int repetitions;
  final List<String> tags;

  CardModel({
    required this.q,
    required this.a,
    this.nextReview = 0,
    this.interval = 0,
    this.ef = 2.5,
    this.repetitions = 0,
    this.tags = const [],
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      q: json['q'] as String,
      a: json['a'] as String,
      nextReview: (json['next_review'] as num?)?.toInt() ?? 0,
      interval: (json['interval'] as num?)?.toInt() ?? 0,
      ef: (json['ef'] as num?)?.toDouble() ?? 2.5,
      repetitions: (json['repetitions'] as num?)?.toInt() ?? 0,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'q': q,
    'a': a,
    'next_review': nextReview,
    'interval': interval,
    'ef': ef,
    'repetitions': repetitions,
    'tags': tags,
  };
}
```

**向后兼容必须显式处理缺失字段**（如 PRD 3.1 要求的 `ef`/`repetitions` 默认补齐）。

### 4.3 日志规范

- 所有关键操作（评分、添加/删除卡片、导入、AI 请求、工具调用、MCP 请求）必须记录日志。
- 敏感字段（键名含 `api_key`, `token`, `secret`, `password`）必须掩码处理。
- 使用 `logging/` 模块的 `Logger` 类，禁止直接 `print`。

```dart
// ✅ 正确
logger.info('User graded card', {'cardIndex': index, 'grade': grade});

// ❌ 错误
print('User graded card $index with $grade');
```

### 4.4 键盘快捷键

核心学习流程必须实现键盘驱动，使用 Flutter `Shortcuts` + `Actions`：

```dart
Shortcuts(
  shortcuts: <LogicalKeySet, Intent>{
    LogicalKeySet(LogicalKeyboardKey.space): ShowAnswerIntent(),
    LogicalKeySet(LogicalKeyboardKey.digit1): GradeCardIntent(1),
    LogicalKeySet(LogicalKeyboardKey.digit2): GradeCardIntent(2),
    LogicalKeySet(LogicalKeyboardKey.digit3): GradeCardIntent(3),
  },
  child: Actions(
    actions: <Type, Action<Intent>>{
      ShowAnswerIntent: CallbackAction(onInvoke: (_) => _showAnswer()),
      GradeCardIntent: CallbackAction(onInvoke: (i) => _grade((i as GradeCardIntent).grade)),
    },
    child: Focus(
      autofocus: true,
      child: ...,
    ),
  ),
)
```

---

## 5. fluent_ui 使用指南

### 5.1 根应用配置

替换默认的 `MaterialApp` 为 `FluentApp`，配置主题和本地化：

```dart
import 'package:fluent_ui/fluent_ui.dart';

class PapyrusApp extends StatelessWidget {
  const PapyrusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Papyrus',
      theme: FluentThemeData(
        accentColor: Colors.blue.toAccentColor(),
        visualDensity: VisualDensity.standard,
      ),
      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.blue.toAccentColor(),
      ),
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        ...FluentLocalizations.localizationsDelegates,
      ],
      supportedLocales: const [Locale('zh'), Locale('en')],
      home: const MainNavigationScreen(),
    );
  }
}
```

### 5.2 主导航结构

使用 `NavigationView` 作为应用骨架，`Pane` 配置左侧导航栏：

```dart
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<NavigationPaneItem> _items = [
    PaneItem(
      icon: const Icon(FluentIcons.book_answers),
      title: const Text('学习'),
      body: const StudyScreen(),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.chat),
      title: const Text('AI 助手'),
      body: const AIChatScreen(),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.settings),
      title: const Text('设置'),
      body: const SettingsScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
        title: Text('Papyrus'),
      ),
      pane: NavigationPane(
        selected: _selectedIndex,
        onChanged: (i) => setState(() => _selectedIndex = i),
        displayMode: PaneDisplayMode.auto, // 自动折叠（窄屏时自动变为 compact）
        items: _items,
      ),
    );
  }
}
```

### 5.3 常用组件速查

| 需求 | fluent_ui 组件 | 文件参考 |
|------|---------------|---------|
| 主按钮 | `Button` / `FilledButton` | `controls/buttons/` |
| 输入框 | `TextBox` / `TextFormBox` | `controls/form/text_box.dart` |
| 密码输入 | `PasswordBox` | `controls/form/password_box.dart` |
| 下拉选择 | `ComboBox<T>` | `controls/form/combo_box.dart` |
| 数字输入 | `NumberBox` | `controls/form/number_box.dart` |
| 开关 | `ToggleSwitch` | `controls/inputs/` |
| 滑块 | `Slider` | `controls/inputs/` |
| 对话框 | `ContentDialog` | `controls/surfaces/dialog.dart` |
| 提示条 | `InfoBar` | `controls/surfaces/info_bar.dart` |
| 悬浮菜单 | `Flyout` | `controls/flyouts/flyout.dart` |
| 列表 | `ListView` + `ListTile`（Flutter 原生，fluent 兼容） | — |
| 主题色 | `FluentTheme.of(context).accentColor` | `styles/` |

### 5.4 主题与颜色

- 使用 `FluentTheme.of(context)` 获取当前主题数据。
- 强调色通过 `Colors.blue.toAccentColor()` 等创建，支持 light/dark 自动切换。
- 高对比度模式通过 `MediaQuery.highContrastOf(context)` 检测，按需调整颜色。

---

## 6. 关键设计决策

### 6.1 为什么选择 ChangeNotifier + Provider？

- **原生集成**: Flutter SDK 内置，无需额外代码生成，Hot Reload 友好。
- **学习成本低**: PRD 要求快速迭代，减少团队成员认知负担。
- **调试友好**: DevTools 直接支持 Provider 树 inspection。
- **测试简单**: ChangeNotifier 可直接单元测试，无需 Widget 树。

### 6.2 为什么用 dart:io HttpServer 而非 shelf？

- **减少依赖**: MCP 是可选模块，引入 `shelf` 增加包体积。
- **足够简单**: MCP 只有 3 个端点（/health, /tools, /call），`HttpServer` 原生支持。
- **Isolate 友好**: `HttpServer` 与 Isolate 配合直接、无额外上下文。

### 6.3 为什么手写 fromJson？

- **向后兼容**: PRD 明确要求旧数据缺失字段自动补齐，手写更容易控制默认值逻辑。
- **减少构建步骤**: 不依赖 `build_runner`，新成员克隆即可运行。
- **错误信息清晰**: 手写解析的错误堆栈更直观。

### 6.4 平台兼容性策略

- **桌面优先**: fluent_ui 的设计语言偏向桌面，Windows/macOS/Linux 获得最佳体验。
- **移动端兼容**: `NavigationPane` 的 `displayMode: auto` 在窄屏自动折叠；字体/间距通过 `MediaQuery` 适配。
- **Web 降级**: Web 平台禁用 MCP 服务器、禁用文件系统直接写入（改用内存缓存或 `localStorage`），附件上传使用 HTML File API。

---

## 7. 开发工作流

### 7.1 添加新功能的标准步骤

1. **读 PRD**: 确认需求对应的 PRD 章节和数据模型。
2. **写 Domain**: 在 `domain/` 中实现纯 Dart 业务逻辑（算法、服务）。
3. **写 Data**: 在 `data/` 中定义模型和仓库接口/实现。
4. **写 Provider**: 在 `presentation/providers/` 中创建 ChangeNotifier，连接 Domain 和 Data。
5. **写 UI**: 在 `presentation/screens/` 和 `widgets/` 中构建界面，使用 fluent_ui 组件。
6. **写测试**: 在 `test/` 中补充单元测试和 Widget 测试。
7. **记录日志**: 在关键操作点添加日志记录。

### 7.2 运行与调试

```bash
# 安装依赖
flutter pub get

# 运行桌面端（开发主力平台）
flutter run -d macos
flutter run -d windows
flutter run -d linux

# 运行移动端
flutter run -d ios
flutter run -d android

# 运行 Web
flutter run -d chrome

# 单元测试
flutter test

# 构建发布版
flutter build macos
flutter build windows
```

### 7.3 Git 提交规范

提交信息前缀：
- `feat:` 新功能
- `fix:` 修复
- `refactor:` 重构
- `test:` 测试
- `docs:` 文档
- `chore:` 构建/工具

---

## 8. 常见陷阱

| 陷阱 | 说明 | 避免方法 |
|------|------|---------|
| **Web 平台导入 dart:io** | Web 不支持 `dart:io`，编译失败。 | 使用条件导入 `import 'dart:io' if (dart.library.html) '...'` 或 Repository 接口隔离。 |
| **UI 线程阻塞** | AI 请求或大量 JSON 解析阻塞 UI。 | AI 请求用 `async/await` + `FutureBuilder`；大量 JSON 用 `Isolate.run()`。 |
| **路径硬编码** | 不同平台数据目录不同。 | 统一使用 `path_provider` 的 `getApplicationDocumentsDirectory()`。 |
| **Provider 未 notify** | 修改状态后忘记 `notifyListeners()`。 | 状态修改封装为 Provider 的方法，方法末尾统一调用 `notifyListeners()`。 |
| **忘记防抖** | 答案状态评分按钮未做防抖。 | `StudyProvider` 中进入答案状态时启动 `Timer`，0.5 秒内禁用评分按钮。 |
| **附件路径冲突** | 同名附件覆盖。 | 使用 `uuid` 重命名存储，原文件名仅作为显示。 |
| **日志敏感信息泄露** | API Key 写入日志。 | 所有日志输出经过 `sanitizers.dart` 的 `maskSensitiveFields()` 处理。 |
| **MCP 未隔离** | HttpServer 运行在主 Isolate 阻塞 UI。 | 必须通过 `Isolate.spawn()` 启动 MCP 服务器。 |

---

## 9. 外部文档参考

| 主题 | 链接 |
|------|------|
| Flutter 官方文档 | https://docs.flutter.dev |
| Dart 语言文档 | https://dart.dev/language |
| Dart Isolates | https://dart.dev/language/isolates |
| fluent_ui 文档 | https://bdlukaa.github.io/fluent_ui |
| fluent_ui 源码（本地）| `参考fluent_ui文档/fluent_ui-4.15.0/lib/src/` |
| path_provider | https://pub.dev/packages/path_provider |
| provider | https://pub.dev/packages/provider |
| http | https://pub.dev/packages/http |
| file_picker | https://pub.dev/packages/file_picker |

---

## 10. 快速决策表

> 当遇到以下场景时，直接查表：

| 场景 | 决策 |
|------|------|
| 需要全局状态共享 | 创建 `ChangeNotifier` + 在 `main.dart` 用 `ChangeNotifierProvider` 包裹 |
| 需要存储用户配置 | 先写 `Repository` 接口，再用 `File` JSON 实现 |
| 需要调用 AI API | 实现 `AIProvider` 接口，用 `http` 包发送请求 |
| 需要文件上传 | 用 `file_picker`，附件存到 `{dataDir}/attachments/{session_uuid}/` |
| 需要后台 HTTP 服务 | 用 `dart:io` 的 `HttpServer`，包装在 `Isolate` 中 |
| 需要键盘快捷键 | 用 `Shortcuts` + `Actions` + `Focus`，定义在 `core/constants/keyboard_shortcuts.dart` |
| 需要对话框 | 用 `ContentDialog`（fluent_ui）而非 `AlertDialog`（Material） |
| 需要提示消息 | 用 `InfoBar`（fluent_ui） |
| 不确定颜色/主题 | 查 `FluentTheme.of(context)` |
| 需要新依赖包 | 先检查是否已有等效功能，避免包膨胀；添加后更新本文件第 2.2 节 |

---

**文档结束**
