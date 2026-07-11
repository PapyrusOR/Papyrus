# Papyrus

基于 Flutter + fluent_ui 的间隔重复（Spaced Repetition）学习工具，内置 AI 学习助手。

详细架构与开发规范见 [AGENTS.md](AGENTS.md)、[STRUCTURE.md](STRUCTURE.md)、[PRD.md](PRD.md)。

## 环境要求

| 组件 | 版本 |
|------|------|
| Flutter | 3.41+（当前 stable 3.44.x 可用） |
| Dart | 3.11+ |
| Windows 桌面构建 | Visual Studio 2022 +「使用 C++ 的桌面开发」工作负载 |
| Android 构建 | Android Studio + Android SDK（可选） |
| Web 调试 | Chrome / Edge |

## 快速开始（Windows）

### 1. 安装 Flutter

若尚未安装，可克隆到 `C:\src\flutter`：

```powershell
git clone https://github.com/flutter/flutter.git -b stable --depth 1 C:\src\flutter
```

将 `C:\src\flutter\bin` 加入用户 PATH，然后**重新打开终端**。

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

## IDE 配置

项目已包含 `.vscode/settings.json` 与 `extensions.json`，在 Cursor / VS Code 中打开项目后：

1. 安装推荐扩展：**Dart**、**Flutter**
2. 若 Flutter SDK 不在默认路径，在设置中调整 `dart.flutterSdkPath`

## 数据库代码生成

修改 `lib/data/local/app_database.dart` 中的 Drift 表定义后：

```powershell
dart run build_runner build
```

## 平台说明

- **Windows / Linux / Android**：使用 `sqlite3` 包内置的原生库（默认）。
- **iOS / macOS**：若 GitHub 下载 sqlite3 预编译库失败，可在 `pubspec.yaml` 中临时添加 `hooks.user_defines.sqlite3.source: system` 使用系统 SQLite（参见 AGENTS.md）。**Windows 上请勿启用此配置。**

## 常用命令

```powershell
flutter analyze          # 静态分析
flutter test             # 单元测试
flutter build windows    # 构建 Windows 发布版
flutter build web        # 构建 Web 版
```

## GitHub Actions 打包与发布

项目包含 `.github/workflows/release.yml`：Pull Request 和 `main` 分支推送会执行分析、测试及全平台构建校验；推送 `v*` Tag 或手动运行 workflow 时，所有平台构建成功后才会创建 GitHub Release。

发布 Tag 必须与 `pubspec.yaml` 中去掉 `+build` 部分的版本一致。例如 `version: 0.1.0+1` 对应：

```powershell
git tag v0.1.0
git push origin v0.1.0
```

也可以在 Actions 中手动运行 `Papyrus Build and Release`，填写 `tag` 并选择是否创建 Draft Release。

Release 会提供 Windows、macOS、Linux、Web、Android APK 和 Android AAB 产物，以及 `SHA256SUMS.txt`。当前 Android Release 仍使用 debug signing，iOS 仅执行 `--no-codesign` 构建校验，macOS 产物未签名/未公证，均不代表商店发布包。
