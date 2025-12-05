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

## ダウンロードとインストール

最新版は [GitHub Releases](https://github.com/check5004/MIDI-Visualizer-Studio/releases) からダウンロードできます。

### Windows

1. Releasesページから `MIDI-Visualizer-Studio-Windows-x.x.x.zip` をダウンロードします。
2. ダウンロードしたZIPファイルを解凍（展開）します。
3. フォルダ内の `midi_visualizer_studio.exe` を実行してください。
   - ※「WindowsによってPCが保護されました」という画面が出た場合は、「詳細情報」をクリックし、「実行」を選択してください。

### macOS

1. Releasesページから `MIDI-Visualizer-Studio-macOS-x.x.x.zip` をダウンロードします。
2. ダウンロードしたZIPファイルを解凍します。
3. `midi_visualizer_studio.app` をアプリケーションフォルダなどに移動します。
4. **初回起動時の注意**:
   - 本アプリはAppleの開発者署名を行っていないため、通常のダブルクリックでは起動できない場合があります（「開発元が未確認のため開けません」や「壊れているため開けません」と表示されることがあります）。
   - その場合は、アプリアイコンを **右クリック（またはControlキーを押しながらクリック）** し、メニューから「開く」を選択してください。確認ダイアログが表示されたら、再度「開く」をクリックすることで起動できます。
   - それでも「壊れている」と表示される場合は、ターミナルで以下のコマンドを実行してください：
     ```bash
     xattr -cr /Applications/midi_visualizer_studio.app
     ```
     （※パスはアプリを置いた場所に合わせて変更してください）

## CI/CD
GitHub Actionsにより以下のワークフローが自動化されています：
- Web版のビルドとGitHub Pagesへのデプロイ。
- Windows版のビルドとGitHub Releasesへの公開。

## ライセンス

このプロジェクトは [MIT License](../LICENSE) の下で公開されています。
