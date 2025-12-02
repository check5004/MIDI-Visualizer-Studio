# MIDI Visualizer Studio

Flutter製のMIDIビジュアライザー作成・再生アプリケーションです。
レイヤーベースのエディターでビジュアルを作成し、MIDI入力に反応するアニメーションを構築できます。

## 主な機能

### エディター (Editor)
- **レイヤー管理**: コンポーネントをレイヤーとして配置・管理。
- **編集機能**:
  - ドラッグ＆ドロップによる移動・リサイズ。
  - 複数選択、範囲選択。
  - コピー、ペースト、カット、削除、複製。
  - アンドゥ (Undo) / リドゥ (Redo)。
  - アスペクト比固定リサイズ。
  - グリッド表示・スナップ。
- **ツール**:
  - 塗りつぶしツール (Flood Fill)。
  - パスコンポーネント作成。

### プレビュー (Preview)
- **ウィンドウ制御**:
  - 背景透過ウィンドウ (Windows/macOS)。
  - 常に最前面に表示 (Always on Top)。
  - ウィンドウ枠・影の非表示 (Frameless/No Shadow)。
  - コンテンツに合わせた自動リサイズ。
- **再生**: エディターで作成したプロジェクトのリアルタイムプレビュー。

### ダッシュボード (Home)
- プロジェクト管理 (作成、開く、削除)。
- プロジェクトプレビュー表示。
- グリッドレイアウトによる一覧表示。

### MIDI連携
- MIDIデバイスの接続・入力検知。
- MIDIイベントに基づくビジュアル制御。

### 設定 (Settings)
- **テーマ**: ライト/ダークモード切り替え。
- **ショートカット**: キーボードショートカットのカスタマイズ。

## 技術スタック
- **フレームワーク**: Flutter
- **状態管理**: flutter_bloc
- **ルーティング**: go_router
- **ウィンドウ制御**: window_manager, flutter_acrylic
- **MIDI**: flutter_midi_command
- **その他**: freezed, json_serializable, shared_preferences

## プラットフォーム
- **Windows**: 透明ウィンドウ対応。
- **Web**: GitHub Actionsによる自動デプロイ対応。
- **macOS**: 対応。

## CI/CD
GitHub Actionsにより以下のワークフローが自動化されています：
- Web版のビルドとGitHub Pagesへのデプロイ。
- Windows版のビルドとGitHub Releasesへの公開。

## ライセンス

このプロジェクトは [MIT License](../LICENSE) の下で公開されています。
