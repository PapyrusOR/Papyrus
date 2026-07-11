# Papyrus

[简体中文](README.md) | [English](README.en.md) | [日本語](README.ja.md)

フラッシュカードを知識の単位とする**間隔反復（Spaced Repetition）**学習ツール。AI 学習アシスタントを内蔵しています。

設計思想：**ミニマル、キーボード駆動、フロー状態（Flow State）優先**。

---

## 位置づけ

| 機能 | 説明 |
|------|------|
| **学習エンジン** | SM-2 アルゴリズムによる科学的な復習スケジューリング |
| **ナレッジベース** | 手動作成または一括インポートで個人のカード庫を構築 |
| **AI コパイロット** | 学習中のヒント・解説・拡張・練習生成。カードデータの操作も可能 |

## 設計原則

1. **マウス不要** — コア学習フローはキーボードだけで完結
2. **ローカル優先** — ユーザーデータはデフォルトで端末内に保存し、クラウドへは上げない
3. **フォールバック** — AI は任意依存。未設定でも学習機能は動作する
4. **プライバシー** — API キーなどは UI 上でマスク表示。設定は保存前に検証

## 機能概要

- **カード管理**：単枚追加、一括インポート（`===` 区切り）、検索、削除
- **SM-2 復習**：期限到来カードの配信、3 段階評価（忘れた / 曖昧 / 即答）、誤操作防止のデバウンス
- **AI アシスタント**：OpenAI 互換 / Anthropic / Ollama / カスタム。Agent / Chat の 2 モード
- **MCP サーバー**：外部ツール向けローカル HTTP API（任意）
- **バックアップとログ**：SQLite データベースのバックアップ。レベル付きログと機密フィールドのマスク

## 技術スタック

| 項目 | 選定 |
|------|------|
| Flutter SDK | 3.41.x |
| Dart SDK | 3.11.x |
| UI | fluent_ui 4.15.x |
| 状態管理 | Provider + ChangeNotifier |
| 永続化 | Drift (SQLite)、Web は WASM 対応 |
| 対象プラットフォーム | Android / iOS / Windows / macOS / Linux / Web |

## クイックスタート

```bash
# 依存関係のインストール
flutter pub get

# デスクトップ（開発の主戦場）
flutter run -d macos
flutter run -d windows
flutter run -d linux

# モバイル / Web
flutter run -d ios
flutter run -d android
flutter run -d chrome

# テスト
flutter test
```

データベーススキーマ変更後は Drift コードを再生成してください：

```bash
dart run build_runner build
```

## キーボードショートカット（学習画面）

| キー | 動作 |
|------|------|
| `Space` | 答えを表示 |
| `1` | 評価：忘れた |
| `2` | 評価：曖昧 |
| `3` | 評価：即答 |

## プロジェクト構成

```
lib/
├── core/           # 定数、拡張、プラットフォーム補助
├── data/           # モデル、リポジトリ、Drift データベース
├── domain/         # SM-2、サービス、ユースケース（純 Dart）
├── presentation/   # UI、Provider、画面とウィジェット
├── ai/             # AI モジュール（任意、フォールバック対応）
├── mcp/            # MCP HTTP サーバー（Isolate 分離）
└── logging/        # ログシステム
```

詳細は [`STRUCTURE.md`](STRUCTURE.md)、製品要件は [`PRD.md`](PRD.md)、Agent 向け規約は [`AGENTS.md`](AGENTS.md) を参照してください。

## 一括インポート形式

UTF-8 テキスト。空行でブロックを区切り、ブロック内は `===` で問題と答えを分割：

```
問題 A === 答え A

問題 B === 答え B
```

## ライセンス

[MIT](LICENSE) © 2026 CloverIris
