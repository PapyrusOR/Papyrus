# Papyrus

[简体中文](README.md) | [English](README.en.md) | [日本語](README.ja.md)

以卡片（Flashcard）为知识载体的**间隔重复（Spaced Repetition）**学习工具，内置 AI 学习助手。

核心设计哲学：**极简、键盘驱动、流状态（Flow State）优先**。

详细架构与开发规范见 [AGENTS.md](AGENTS.md)、[STRUCTURE.md](STRUCTURE.md)、[PRD.md](PRD.md)。

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
| Flutter SDK | 3.41.x（CI 固定 3.41.9；本地可使用更新的 stable） |
| Dart SDK | 3.11.x |
| UI | fluent_ui 4.15.x |
| 状态管理 | Provider + ChangeNotifier |
| 持久化 | Drift (SQLite)，全平台含 Web WASM |
| 目标平台 | Android / iOS / Windows / macOS / Linux / Web |

## 环境要求

| 组件 | 版本 |
|------|------|
| Flutter | 3.41.9（CI 固定此版本；本地可使用更新的 stable） |
| Dart | 3.11+ |
| Windows 桌面构建 | Visual Studio 2022 +「使用 C++ 的桌面开发」工作负载 |
| Android 构建 | Android Studio + Android SDK（可选） |
| Web 调试 | Chrome / Edge |

## 快速开始（Windows）

### 1. 安装 Flutter

若尚未安装，可克隆到脚本默认的 `C:\src\flutter`：

```powershell
git clone https://github.com/flutter/flutter.git -b stable --depth 1 C:\src\flutter
```

将 Flutter 的 `bin` 目录加入用户 PATH，然后**重新打开终端**。也可以先设置 `FLUTTER_ROOT`，让初始化脚本使用其他安装目录。

### 2. 一键初始化

```powershell
.\scripts\setup.ps1
```

或手动执行：

```powershell
flutter doctor
flutter pub get
dart run build_runner build
flutter test
```

### 3. 运行应用

```powershell
# Web（无需 Visual Studio）
flutter run -d chrome

# Windows 桌面（需安装 Visual Studio）
flutter run -d windows
```

## 快速开始（其他平台）

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

## IDE 配置

项目已包含 `.vscode/settings.json` 与 `extensions.json`，在 Cursor / VS Code 中打开项目后：

1. 安装推荐扩展：**Dart**、**Flutter**
2. 确保 Flutter SDK 的 `bin` 目录已加入 PATH；项目不再把 SDK 路径硬编码到工作区设置中

## 数据库代码生成

修改 `lib/data/local/app_database.dart` 中的 Drift 表定义后：

```bash
dart run build_runner build
```

## 平台说明

- **Windows / Linux / Android**：使用 `sqlite3` 包内置的原生库（默认）。
- **iOS / macOS**：若 GitHub 下载 sqlite3 预编译库失败，可在 `pubspec.yaml` 中临时添加 `hooks.user_defines.sqlite3.source: system` 使用系统 SQLite（参见 AGENTS.md）。**Windows 上请勿启用此配置。**
- **Web**：应用入口路径仍有无条件 `dart:io` 依赖，CI/Release 暂不构建 Web 产物；本地调试前需先完成条件导入改造。

## 常用命令

```bash
flutter analyze          # 静态分析
flutter test             # 单元测试
flutter build windows    # 构建 Windows 发布版
flutter build web        # 构建 Web 版（当前可能因 dart:io 失败）
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

## 批量导入格式

UTF-8 文本，空行分块，块内用 `===` 分隔题目与答案：

```
题目 A === 答案 A

题目 B === 答案 B
```

## GitHub Actions 打包与发布

项目包含 `.github/workflows/release.yml`：Pull Request 会执行分析与测试；`main` 分支推送、`v*` Tag 推送或手动运行 workflow 时，才执行完整的平台构建。推送 `v*` Tag 或手动运行 workflow 时，所有平台构建成功后才会创建 GitHub Release。

发布 Tag 必须与 `pubspec.yaml` 中去掉 `+build` 部分的版本一致。例如 `version: 0.1.0+1` 对应：

```bash
git tag v0.1.0
git push origin v0.1.0
```

也可以在 Actions 中手动运行 `Papyrus Build and Release`，填写 `tag` 并选择是否创建 Draft Release。

Release 会提供 Windows、macOS、Linux、Android APK 和 Android AAB 产物，以及 `SHA256SUMS.txt`。当前 Android Release 仍使用 debug signing，iOS 仅执行 `--no-codesign` 构建校验，macOS 产物未签名/未公证，均不代表商店发布包。Web 产物暂未纳入 Release（见上方平台说明）。

若仓库变量 `AUTO_RELEASE_DRAFT=true`，推送到 `main` 且对应 `v<pubspec>` Tag 尚不存在时，会自动创建 Draft Release。

发布流程会校验远端 Tag 指向的提交必须等于本次 workflow 的目标提交；如果 Tag 已指向其他提交，流程会在上传或更新 Release 前失败，避免旧 Tag 被错误产物覆盖。

## 许可证

[MIT](LICENSE) © 2026 CloverIris
