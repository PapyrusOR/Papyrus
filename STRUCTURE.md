# Papyrus Flutter 全平台项目结构文档

> **版本**: v1.0.0  
> **定位**: 基于 PRD v1.2.2 的完整 Flutter/Dart 物理目录映射  
> **目标平台**: Android / iOS / Windows / macOS / Linux / Web  
> **Flutter SDK**: 3.41.x  
> **Dart SDK**: 3.11.x  
> **UI 框架**: fluent_ui (v4.15.x) + 平台自适应降级  

---

## 1. 架构总览

采用 **分层架构 + 模块化隔离**，严格遵循 PRD 的"核心学习引擎与 AI 模块解耦"原则。

```
┌─────────────────────────────────────────────────────────────────┐
│  Presentation Layer (UI)                                        │
│  fluent_ui Widgets | Navigation | Keyboard Shortcuts | Screens  │
├─────────────────────────────────────────────────────────────────┤
│  State Management Layer                                         │
│  ChangeNotifier + Provider (轻量、原生、无代码生成依赖)           │
├─────────────────────────────────────────────────────────────────┤
│  Domain / Use Case Layer                                        │
│  CardService | SM2Engine | AIService | SessionService           │
├─────────────────────────────────────────────────────────────────┤
│  Data Layer                                                     │
│  Repository Pattern | File-based JSON Store | PathProvider      │
├─────────────────────────────────────────────────────────────────┤
│  Platform / Infra Layer                                         │
│  dart:io File IO | dart:io HttpServer (MCP) | path_provider    │
└─────────────────────────────────────────────────────────────────┘
```

**关键设计约束**:
- AI 模块为可选依赖；AI 初始化失败不得影响主学习功能。
- 所有数据写入使用"临时文件 + 原子替换"策略。
- MCP HTTP 服务器使用 `dart:io` 的 `HttpServer`，运行于独立 Isolate。
- 日志系统支持依赖注入，测试时可替换为 Mock。
- 全平台路径统一通过 `path_provider` 解析，禁止硬编码路径。

---

## 2. 物理目录结构

```
lib/
├── main.dart                              # 应用入口
├── app.dart                               # 根 Widget: FluentApp + 主题 + Provider 树
├── l10n/                                  # 国际化（flutter_gen/gen_l10n）
│   ├── app_zh.arb
│   └── app_en.arb
│
├── core/                                  # 核心基础设施（全项目共享）
│   ├── constants/
│   │   ├── app_constants.dart             # 应用级常量（名称、版本、默认配置）
│   │   ├── storage_keys.dart              # 本地存储键名枚举
│   │   └── keyboard_shortcuts.dart        # 全局快捷键定义（Shortcuts/Actions）
│   ├── extensions/
│   │   ├── string_extensions.dart         # String 扩展（如掩码处理、截断）
│   │   ├── date_time_extensions.dart      # DateTime ↔ Unix 秒级时间戳转换
│   │   └── file_extensions.dart           # File IO 辅助扩展
│   ├── platform/
│   │   ├── platform_helper.dart           # 平台判断（desktop/mobile/web）
│   │   └── path_resolver.dart             # 数据目录路径解析封装
│   └── utils/
│       ├── validators.dart                # 配置校验（ASCII 合法性等）
│       └── id_generator.dart              # UUID / 时间戳 ID 生成器
│
├── data/                                  # 数据层
│   ├── models/
│   │   ├── card_model.dart                # Card 数据模型（含 fromJson/toJson）
│   │   ├── card_model.g.dart              # (可选) json_serializable 生成
│   │   ├── ai_config_model.dart           # AI 配置模型（多提供商结构）
│   │   ├── ai_session_model.dart          # AI 会话模型（含 Message/Attachment）
│   │   ├── log_entry_model.dart           # 日志条目模型（主日志/错误/活动/事件）
│   │   └── app_settings_model.dart        # 应用全局设置模型
│   ├── repositories/
│   │   ├── card_repository.dart           # 卡片 CRUD、搜索、导入导出接口
│   │   ├── card_repository_impl.dart      # 基于 File JSON 的实现
│   │   ├── ai_config_repository.dart      # AI 配置持久化接口
│   │   ├── ai_config_repository_impl.dart # 基于 File JSON 的实现
│   │   ├── ai_session_repository.dart     # 会话持久化接口
│   │   ├── ai_session_repository_impl.dart# 基于 File JSON 的实现
│   │   ├── log_repository.dart            # 日志追加写接口
│   │   └── log_repository_impl.dart       # 多文件分类追加写实现
│   └── local/
│       ├── file_storage.dart              # 通用文件读写封装（含原子替换）
│       └── backup_manager.dart            # 自动/手动备份与恢复逻辑
│
├── domain/                                # 领域层（纯 Dart，无 Flutter 依赖）
│   ├── algorithms/
│   │   └── sm2_engine.dart                # SM-2 间隔重复算法（纯函数）
│   ├── services/
│   │   ├── card_service.dart              # 卡片业务逻辑（CRUD、搜索、调度）
│   │   ├── review_scheduler.dart          # 到期卡片筛选与排序
│   │   ├── import_service.dart            # 批量导入解析（UTF-8 + === 分割）
│   │   ├── backup_service.dart            # 备份/恢复业务逻辑
│   │   └── card_tool_service.dart         # AI 工具执行器（create/update/delete/search/stats）
│   └── usecases/
│       ├── add_card_usecase.dart
│       ├── delete_card_usecase.dart
│       ├── review_card_usecase.dart       # 评分 + SM-2 计算 + 持久化
│       ├── search_cards_usecase.dart
│       └── import_cards_usecase.dart
│
├── presentation/                          # 表现层（UI + 状态管理）
│   ├── providers/                         # ChangeNotifier-based 状态管理
│   │   ├── app_state_provider.dart        # 全局应用状态（主题、语言、当前路由）
│   │   ├── study_provider.dart            # 学习区状态机（题目/答案/评分防抖）
│   │   ├── card_provider.dart             # 卡片列表、搜索、CRUD 状态
│   │   ├── ai_chat_provider.dart          # AI 对话状态（当前会话、消息流、加载态）
│   │   ├── ai_config_provider.dart        # AI 配置编辑态（提供商、模型、参数）
│   │   ├── session_provider.dart          # 会话列表管理（新建/切换/重命名/删除）
│   │   ├── log_provider.dart              # 日志查看器状态（筛选/搜索/加载限制）
│   │   └── settings_provider.dart         # 设置页表单状态与验证
│   │
│   ├── screens/                           # 全屏页面（NavigationPane 的 Body）
│   │   ├── study_screen.dart              # 主学习区（题目/答案状态机）
│   │   ├── card_manager_screen.dart       # 卡片管理（搜索、添加、删除）
│   │   ├── ai_chat_screen.dart            # AI 助手面板（对话列表 + 输入区）
│   │   ├── settings_screen.dart           # 设置界面（提供商/模型/参数）
│   │   ├── log_viewer_screen.dart         # 日志查看器（筛选/高亮/导出）
│   │   └── backup_screen.dart             # 备份与恢复界面
│   │
│   ├── widgets/                           # 可复用组件
│   │   ├── study/
│   │   │   ├── card_face_widget.dart      # 卷头/卷尾展示组件
│   │   │   ├── grade_buttons.dart         # 三档评分按钮（忘记/模糊/秒杀）
│   │   │   ├── study_status_bar.dart      # 状态栏（到期数/总数）
│   │   │   └── empty_due_widget.dart      # 无到期卡片完成提示
│   │   ├── ai/
│   │   │   ├── chat_message_list.dart     # 消息气泡列表
│   │   │   ├── chat_input_bar.dart        # 输入框 + 附件/发送按钮
│   │   │   ├── session_sidebar.dart       # 会话列表侧边栏
│   │   │   ├── attachment_chip.dart       # 附件展示 Chip
│   │   │   └── model_selector.dart        # 模型下拉选择器
│   │   ├── settings/
│   │   │   ├── provider_editor.dart       # 提供商配置表单
│   │   │   ├── model_list_editor.dart     # 模型列表增删改
│   │   │   └── parameter_slider.dart      # Temperature/MaxTokens 滑块
│   │   ├── log/
│   │   │   ├── log_entry_tile.dart        # 单条日志展示（颜色高亮）
│   │   │   └── log_filter_bar.dart        # 筛选/搜索/加载限制控件
│   │   └── common/
│   │       ├── confirm_dialog.dart        # 二次确认对话框
│   │       ├── loading_overlay.dart       # 全局加载遮罩
│   │       ├── responsive_layout.dart     # 响应式布局（桌面/移动端适配）
│   │       └── platform_scaffold.dart     # 平台自适应 Scaffold
│   │
│   └── navigation/
│       ├── app_navigation.dart            # NavigationPane / NavigationView 配置
│       └── route_definitions.dart         # 路由常量枚举
│
├── ai/                                    # AI 模块（可选、可降级）
│   ├── providers/                         # AI 提供商抽象
│   │   ├── ai_provider_interface.dart     # 统一接口定义（chatComplete, fetchModels）
   │   ├── openai_compatible_provider.dart  # OpenAI 兼容实现
│   │   ├── anthropic_provider.dart        # Anthropic 实现
│   │   ├── ollama_provider.dart           # Ollama 本地实现
│   │   └── custom_provider.dart           # 自定义提供商实现
│   ├── services/
│   │   ├── ai_request_service.dart        # 请求组装、上下文注入、附件序列化
│   │   ├── ai_response_parser.dart        # 流式/非流式响应解析
│   │   ├── tool_parser.dart               # 从 AI 回复中解析 JSON 工具调用
│   │   └── attachment_service.dart        # 附件存储、Base64 转换、类型降级
│   ├── models/
│   │   ├── ai_message.dart                # AI 消息模型（role/content/attachments）
│   │   ├── ai_provider_config.dart        # 单提供商配置子模型
│   │   └── tool_call.dart                 # 工具调用结构化模型
│   └── tools/
│       ├── tool_definitions.dart          # 工具 JSON Schema / Prompt 文本定义
│       └── tool_executor.dart             # 工具路由与执行器
│
├── mcp/                                   # MCP 外部服务接口（可选）
│   ├── mcp_server.dart                    # HttpServer 启动/停止/生命周期管理
│   ├── mcp_router.dart                    # 路由表（/health, /tools, /call）
│   ├── mcp_cors.dart                      # CORS 中间件
│   └── mcp_isolate.dart                   # Isolate.spawn 包装器（后台运行）
│
└── logging/                               # 日志系统
    ├── logger.dart                        # 分级日志主类（DEBUG/INFO/WARNING/ERROR）
    ├── log_writers.dart                   # 多文件追加写实现
    ├── sanitizers.dart                    # 敏感字段掩码处理器
    ├── formatters.dart                    # 纯文本 / JSONL 格式化
    └── log_level_colors.dart              # 日志级别颜色映射（供 UI 高亮）

assets/
├── fonts/                                 # 自定义字体（如使用）
└── icons/                                 # 平台资源图标

test/                                      # 测试目录
├── unit/
│   ├── sm2_engine_test.dart               # SM-2 算法单元测试
│   ├── card_repository_test.dart          # 仓库层测试（Mock File IO）
│   ├── validators_test.dart               # 校验逻辑测试
│   └── tool_parser_test.dart              # 工具解析测试
├── widget/
│   └── study_screen_test.dart             # 主学习区 Widget 测试
└── integration/
    └── full_review_flow_test.dart         # 完整学习流程集成测试
```

---

## 3. 核心模块详细映射

### 3.1 数据模型层（Data Models）

PRD 第 3 章定义的所有 JSON 结构，在 Flutter 中映射为 **immutable/freezed 风格的 Dart 类**，使用 `json_serializable` 或手写 `fromJson`/`toJson`。

| PRD 模型 | Dart 文件 | 关键字段 |
|---------|----------|---------|
| Card (3.1) | `data/models/card_model.dart` | `q`, `a`, `nextReview`, `interval`, `ef`, `repetitions`, `tags` |
| AI Config (3.2) | `data/models/ai_config_model.dart` | `providers`, `currentProvider`, `currentModel`, `parameters`, `features` |
| Session (3.3) | `data/models/ai_session_model.dart` | `activeSessionId`, `sessions[]` |
| 日志条目 (3.4) | `data/models/log_entry_model.dart` | `timestamp`, `level`, `category`, `message`, `metadata` |

**向后兼容**: `CardModel.fromJson` 中若缺失 `ef`/`repetitions`，自动以 `2.5`/`0` 补齐。

### 3.2 持久化策略（Data Layer）

PRD 4.6.1 要求 JSON 文件 + UTF-8 + 缩进格式化。

```
数据目录（path_provider 获取）
├── cards.json          # 卡片数组
├── ai_config.json      # AI 配置
├── sessions.json       # AI 会话
├── backups/            # 自动/手动备份
│   ├── auto_20250506_120000/
│   │   ├── cards.json
│   │   ├── ai_config.json
│   │   └── sessions.json
│   └── manual_20250506_120000/
├── attachments/        # 附件隔离存储
│   └── {session_uuid}/
│       └── {file_uuid}.ext
└── logs/
    ├── main.log
    ├── error.log
    ├── activity.jsonl
    └── events.jsonl
```

**原子写入封装** (`data/local/file_storage.dart`):
```dart
Future<void> writeAtomic(String path, String content) async {
  final temp = File('$path.tmp');
  await temp.writeAsString(content, flush: true);
  await temp.rename(path);
}
```

### 3.3 SM-2 算法（Domain Layer）

`domain/algorithms/sm2_engine.dart` — 纯函数，无 Flutter 依赖，可独立测试。

输入: `(Card card, int grade)`  
输出: `Card` (更新后的 nextReview, interval, ef, repetitions)

映射规则: 忘记(1)→Quality=1, 模糊(2)→Quality=3, 秒杀(3)→Quality=5

### 3.4 AI 提供商抽象（AI Module）

```dart
// ai/providers/ai_provider_interface.dart
abstract class AIProvider {
  String get name;
  Future<List<String>> fetchModels(AIProviderConfig config);
  Future<Stream<String>> chatComplete(AIRequest request);
}
```

- `OpenAICompatibleProvider`: 标准 Chat Completions API，支持流式 SSE 解析。
- `AnthropicProvider`: 兼容 OpenAI 格式（若使用第三方代理）或原生 Messages API。
- `OllamaProvider`: `/api/tags` 获取模型，`/api/chat` 发送请求，超时 120s。
- `CustomProvider`: OpenAI 兼容格式的通用实现。

**附件序列化策略**:
- OpenAI 兼容: 图片 → Base64 Data URL (`image_url`)；TXT/MD → 文本块；其他 → 标记未解析。
- 非 OpenAI: 纯文本附加说明（文件名 + TXT/MD 内容摘要）。

### 3.5 MCP 服务器（MCP Module）

使用 `dart:io` 的 `HttpServer` 直接实现（不引入 shelf 以减少依赖）。

```dart
// mcp/mcp_server.dart
class MCPServer {
  HttpServer? _server;
  
  Future<void> start({String host = '127.0.0.1', int port = 8787}) async {
    _server = await HttpServer.bind(host, port);
    _server!.listen(_handleRequest);
  }
  
  void _handleRequest(HttpRequest request) async {
    // CORS 头注入
    // 路由分发: /health, /tools, /call
  }
}
```

**Isolate 隔离** (`mcp/mcp_isolate.dart`):
- 主 Isolate 通过 `SendPort` 向 MCP Isolate 发送启动/停止指令。
- MCP Isolate 内部独立运行 `HttpServer`，不阻塞 UI 线程。

### 3.6 键盘驱动与快捷键（Presentation Layer）

Flutter 内置 `Shortcuts` + `Actions` + `Focus` 实现全局键盘驱动。

`core/constants/keyboard_shortcuts.dart`:
```dart
class ShowAnswerIntent extends Intent {}
class GradeCardIntent extends Intent { final int grade; GradeCardIntent(this.grade); }

// 在 StudyScreen 中包裹:
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
      GradeCardIntent: CallbackAction(onInvoke: (intent) => _grade(intent.grade)),
    },
    child: ...,
  ),
)
```

### 3.7 状态管理策略

采用 **ChangeNotifier + Provider**（Flutter 团队原生推荐，零代码生成，无额外依赖）。

| 状态范围 | Provider 类 | 职责 |
|---------|------------|------|
| 全局 | `AppStateProvider` | 主题、语言、当前页面索引 |
| 学习区 | `StudyProvider` | 当前卡片、题目/答案状态、评分防抖计时器 |
| 卡片数据 | `CardProvider` | 卡片列表、搜索结果、导入状态 |
| AI 对话 | `AIChatProvider` | 当前会话消息流、加载态、附件队列 |
| AI 配置 | `AIConfigProvider` | 表单编辑态、校验错误、模型列表 |
| 会话 | `SessionProvider` | 会话列表排序、活跃会话切换 |
| 日志 | `LogProvider` | 日志类型筛选、关键词过滤、加载行数 |

**降级处理**: `AIChatProvider` 初始化时若检测到 AI 配置无效，自动设置 `isAvailable = false`，UI 展示友好提示。

### 3.8 响应式布局与平台适配

fluent_ui 的 `NavigationView` 在桌面端提供 Pane 导航，在窄屏（移动端/Web 窄窗口）自动折叠为 BottomNavigationBar 或 Drawer。

`presentation/widgets/common/responsive_layout.dart`:
```dart
bool get isDesktop => Platform.isWindows || Platform.isMacOS || Platform.isLinux;
bool get isMobile => Platform.isAndroid || Platform.isIOS;
```

---

## 4. 依赖包清单

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  # UI 框架
  fluent_ui: ^4.15.0

  # 状态管理
  provider: ^6.1.0

  # 本地存储与路径
  path_provider: ^2.1.0
  shared_preferences: ^2.3.0   # 仅用于轻量启动配置缓存

  # 网络与 AI
  http: ^1.2.0                 # AI API 请求

  # 文件与附件
  file_picker: ^8.0.0          # 文件选择 + 拖拽上传
  mime: ^1.0.0                 # MIME 类型识别
  path: ^1.9.0                 # 路径拼接

  # 工具
  intl: ^0.20.0                # 国际化、日期格式化
  uuid: ^4.0.0                 # 附件/会话 UUID
  crypto: ^3.0.0               # 敏感字段哈希（如需要）

  # JSON 序列化（可选，减少手写 fromJson 错误）
  json_annotation: ^4.9.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  build_runner: ^2.4.0
  json_serializable: ^6.8.0
```

---

## 5. 构建与运行配置

### 5.1 支持的平台

```bash
# Android
flutter build apk
flutter build appbundle

# iOS
flutter build ios

# 桌面端
flutter build windows
flutter build macos
flutter build linux

# Web
flutter build web
```

### 5.2 平台特殊处理

| 平台 | 特殊处理 |
|------|---------|
| **Web** | `dart:io` 不可用；MCP 服务器禁用；文件存储改用 `localStorage`/`IndexedDB` 降级；附件上传仅限浏览器 File API。 |
| **Android/iOS** | `path_provider` 获取应用私有目录；支持文件选择器；MCP 服务器绑定 `127.0.0.1`。 |
| **Windows/macOS/Linux** | 完整功能；`path_provider` 获取 Documents/Support 目录；支持全局快捷键注册（flutter 的 Shortcuts 已覆盖）。 |

---

## 6. 测试策略

| 层级 | 范围 | 工具 |
|------|------|------|
| 单元测试 | SM-2 算法、ToolParser、Validators、Model fromJson | `flutter_test` |
| Widget 测试 | StudyScreen 状态机、AIChat 消息列表、Settings 表单验证 | `WidgetTester` |
| 集成测试 | 完整学习流程（添加→学习→评分→查看日志） | `integration_test` |

**Mock 策略**: 日志系统的 `LogWriter` 接口在测试中注入 `MemoryLogWriter`。

---

## 7. 与 PRD 功能矩阵对照

| PRD 章节 | 实现位置 | 关键文件 |
|---------|---------|---------|
| 4.1 卡片管理 | `domain/services/card_service.dart` + `presentation/screens/card_manager_screen.dart` | `card_repository_impl.dart`, `import_service.dart` |
| 4.2 SM-2 学习引擎 | `domain/algorithms/sm2_engine.dart` + `presentation/providers/study_provider.dart` | `study_screen.dart`, `grade_buttons.dart` |
| 4.3 AI 助手 | `ai/` 模块 + `presentation/providers/ai_chat_provider.dart` | `openai_compatible_provider.dart`, `tool_parser.dart` |
| 4.4 会话管理 | `presentation/providers/session_provider.dart` | `ai_session_model.dart`, `session_sidebar.dart` |
| 4.5 设置与配置 | `presentation/screens/settings_screen.dart` + `presentation/providers/ai_config_provider.dart` | `validators.dart`, `provider_editor.dart` |
| 4.6 数据持久化与备份 | `data/local/file_storage.dart` + `domain/services/backup_service.dart` | `backup_manager.dart`, `backup_screen.dart` |
| 4.7 日志与诊断 | `logging/` + `presentation/screens/log_viewer_screen.dart` | `logger.dart`, `log_repository_impl.dart` |
| 4.8 MCP 服务接口 | `mcp/` 模块 | `mcp_server.dart`, `mcp_isolate.dart` |
| 5.1 键盘驱动 | `core/constants/keyboard_shortcuts.dart` + `presentation/screens/study_screen.dart` | `Shortcuts` / `Actions` Widget |
| 6.1 性能 | 全模块异步设计 | `Isolate.run` (JSON 解析), `FutureBuilder` |
| 6.2 可靠性 | 原子写入 + 降级处理 | `file_storage.dart`, `ai_chat_provider.dart` |
| 6.3 安全性 | 掩码 + 路径校验 | `sanitizers.dart`, `path_resolver.dart` |

---

**文档结束**
