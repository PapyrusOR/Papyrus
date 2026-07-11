# Papyrus

[简体中文](README.md) | [English](README.en.md) | [日本語](README.ja.md)

以卡片（Flashcard）为知识载体的**间隔重复（Spaced Repetition）**学习工具，内置 AI 学习助手。

核心设计哲学：**极简、键盘驱动、流状态（Flow State）优先**。

---

## 核心定位

| 能力 | 说明 |
|------|------|
| **学习引擎** | 基于 SM-2 算法的科学记忆调度 |
| **知识库** | 手动创建或批量导入卡片，形成个人知识库 |
| **AI 副驾驶** | 学习过程中提供提示、解释、扩展与练习生成，并可主动操作卡片数据 |

## 设计原则

1. **无鼠标操作** — 核心学习流程完全可通过键盘完成
2. **本地优先** — 用户数据默认存储在本地，不上传云端
3. **容错与降级** — AI 为可选依赖；未配置时主学习功能仍可正常使用
4. **隐私保护** — API 密钥等敏感信息脱敏显示，配置需合法性校验

## 功能概览

- **卡片管理**：单张添加、批量导入（`===` 分隔）、搜索、删除
- **SM-2 复习**：到期调度、三档评分（忘记 / 模糊 / 秒杀）、防抖防误触
- **AI 助手**：OpenAI 兼容 / Anthropic / Ollama / 自定义提供商；Agent / Chat 双模式
- **MCP 服务**：本地 HTTP 接口，供外部工具调用卡片能力（可选）
- **备份与日志**：SQLite 数据库备份；分级日志与敏感字段掩码

## 技术栈

| 项目 | 版本 / 选型 |
|------|-------------|
| Flutter SDK | 3.41.x |
| Dart SDK | 3.11.x |
| UI | fluent_ui 4.15.x |
| 状态管理 | Provider + ChangeNotifier |
| 持久化 | Drift (SQLite)，全平台含 Web WASM |
| 目标平台 | Android / iOS / Windows / macOS / Linux / Web |

## 快速开始

```bash
# 安装依赖
flutter pub get

# 桌面端（开发主力）
flutter run -d macos
flutter run -d windows
flutter run -d linux

# 移动端 / Web
flutter run -d ios
flutter run -d android
flutter run -d chrome

# 测试
flutter test
```

数据库表结构变更后需重新生成 Drift 代码：

```bash
dart run build_runner build
```

## 键盘快捷键（学习区）

| 按键 | 动作 |
|------|------|
| `Space` | 显示答案 |
| `1` | 评分：忘记 |
| `2` | 评分：模糊 |
| `3` | 评分：秒杀 |

## 项目结构

```
lib/
├── core/           # 常量、扩展、平台工具
├── data/           # 模型、仓库、Drift 数据库
├── domain/         # SM-2、业务服务、用例（纯 Dart）
├── presentation/   # UI、Provider、屏幕与组件
├── ai/             # AI 模块（可选，支持降级）
├── mcp/            # MCP HTTP 服务器（Isolate 隔离）
└── logging/        # 日志系统
```

详细说明见 [`STRUCTURE.md`](STRUCTURE.md)，产品需求见 [`PRD.md`](PRD.md)，Agent 开发约定见 [`AGENTS.md`](AGENTS.md)。

## 批量导入格式

UTF-8 文本，空行分块，块内用 `===` 分隔题目与答案：

```
题目 A === 答案 A

题目 B === 答案 B
```

## 许可证

[MIT](LICENSE) © 2026 CloverIris
