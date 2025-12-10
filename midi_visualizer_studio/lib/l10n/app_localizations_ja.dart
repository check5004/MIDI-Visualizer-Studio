// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'MIDI Visualizer Studio';

  @override
  String get settingsTitle => '設定';

  @override
  String get language => '言語';

  @override
  String get themeMode => 'テーマ設定';

  @override
  String get systemTheme => 'システム';

  @override
  String get lightTheme => 'ライト';

  @override
  String get darkTheme => 'ダーク';

  @override
  String get general => '一般';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get editorBackground => 'エディタ背景';

  @override
  String get version => 'バージョン';

  @override
  String get licenses => 'ライセンス';

  @override
  String get launchInPreviewMode => 'プレビューモードで起動';

  @override
  String get launchInPreviewModeDescription => '起動時に最後に開いたプロジェクトをプレビューモードで開く';

  @override
  String get midi => 'MIDI';

  @override
  String get streaming => '配信設定';

  @override
  String get chromaKeyDefaults => 'クロマキー初期設定';

  @override
  String get chromaKeyDefaultsDescription => '新規プロジェクトのデフォルト背景色を設定します。';

  @override
  String get defaultColor => 'デフォルト色';

  @override
  String get windowlessMode => 'ウィンドウレスモード';

  @override
  String get windowlessModeDescription => 'ウィンドウのタイトルバーと枠を隠す（OBSキャプチャ用）。';

  @override
  String get shortcuts => 'ショートカット';

  @override
  String get resetToDefaults => 'デフォルトに戻す';

  @override
  String get noShortcutsConfigured => 'ショートカットが設定されていません';

  @override
  String get pressKeys => 'キーを押してください...';

  @override
  String get dashboard => 'ダッシュボード';

  @override
  String get dashboardSubtitle => 'MIDIビジュアライザープロジェクトの管理';

  @override
  String get tutorial => 'チュートリアル';

  @override
  String get recentProjects => '最近のプロジェクト';

  @override
  String get refreshProjects => 'プロジェクトを更新';

  @override
  String get newProject => '新規プロジェクト';

  @override
  String get importFile => 'インポート';

  @override
  String importSuccess(int count) {
    return '$count件のプロジェクトをインポートしました';
  }

  @override
  String importPartialSuccess(int success, int fail) {
    return '$success件インポート成功、$fail件失敗しました';
  }

  @override
  String get edit => '編集';

  @override
  String get export => 'エクスポート';

  @override
  String get exportProject => 'プロジェクトのエクスポート';

  @override
  String get exportSuccess => 'プロジェクトをエクスポートしました';

  @override
  String exportFail(String error) {
    return 'エクスポート失敗: $error';
  }

  @override
  String get delete => '削除';

  @override
  String get deleteProject => 'プロジェクトの削除';

  @override
  String deleteConfirmation(String name) {
    return '本当に \"$name\" を削除しますか？この操作は取り消せません。';
  }

  @override
  String get cancel => 'キャンセル';

  @override
  String edited(String date) {
    return '編集: $date';
  }

  @override
  String get unknownDate => '不明';

  @override
  String daysAgo(int days) {
    return '$days日前';
  }

  @override
  String hoursAgo(int hours) {
    return '$hours時間前';
  }

  @override
  String minutesAgo(int minutes) {
    return '$minutes分前';
  }

  @override
  String get justNow => 'たった今';

  @override
  String get restoreSession => 'セッションの復元';

  @override
  String get restoreSessionDescription => '保存されていないセッションが見つかりました。変更を復元しますか？';

  @override
  String get discard => '破棄';

  @override
  String get restore => '復元';

  @override
  String get untitledProject => '名称未設定プロジェクト';

  @override
  String get openProject => '開く';

  @override
  String get saveProject => '保存';

  @override
  String get projectSaved => 'プロジェクトを保存しました';

  @override
  String get projectExported => 'プロジェクトをエクスポートしました';

  @override
  String get midiSettings => 'MIDI設定';

  @override
  String get toolSelect => '選択';

  @override
  String get toolRectangle => '長方形';

  @override
  String get toolCircle => '円';

  @override
  String get toolPath => 'パス';

  @override
  String get toolBucketFill => '塗りつぶし';

  @override
  String get insertTemplate => 'テンプレート挿入';

  @override
  String get padGrid => 'パッドグリッド';

  @override
  String get tolerance => '許容値:';

  @override
  String get toolImage => '画像';

  @override
  String imageName(String id) {
    return '画像 $id';
  }

  @override
  String get gridSettings => 'グリッド設定';

  @override
  String get showGrid => 'グリッドを表示';

  @override
  String get snapToGrid => 'グリッドにスナップ';

  @override
  String get gridSize => 'グリッドサイズ';

  @override
  String get preview => 'プレビュー';

  @override
  String get renameProject => 'プロジェクト名の変更';

  @override
  String get noProjectSelected => 'プロジェクトが選択されていません';

  @override
  String get projectSettings => 'プロジェクト設定';

  @override
  String get defaultNoteOnEffect => 'デフォルト Note On エフェクト';

  @override
  String get defaultNoteOffEffect => 'デフォルト Note Off エフェクト';

  @override
  String get selectComponentToEdit => 'コンポーネントを選択してプロパティを編集します。';

  @override
  String get properties => 'プロパティ';

  @override
  String get name => '名前';

  @override
  String get x => 'X';

  @override
  String get y => 'Y';

  @override
  String get w => 'W';

  @override
  String get h => 'H';

  @override
  String get lockAspectRatio => '縦横比を固定';

  @override
  String get typeSpecific => '固有設定';

  @override
  String get midiBinding => 'MIDIバインディング';

  @override
  String get channel => 'チャンネル';

  @override
  String get note => 'ノート';

  @override
  String get cc => 'CC';

  @override
  String get na => 'N/A';

  @override
  String velocityThreshold(int value) {
    return 'ベロシティしきい値: $value';
  }

  @override
  String get stopLearning => '学習停止';

  @override
  String get bound => '紐付け完了!';

  @override
  String get learnMidi => 'MIDI学習';

  @override
  String get clearBinding => '紐付け解除';

  @override
  String get shape => '形状';

  @override
  String get cornerRadius => '角丸半径';

  @override
  String get smoothing => 'スムージング';

  @override
  String get onColor => 'On カラー';

  @override
  String get offColor => 'Off カラー';

  @override
  String get pulseMode => 'パルスモード';

  @override
  String get pulseDurationMs => 'パルス時間 (ms)';

  @override
  String get noteOnEffect => 'Note On エフェクト';

  @override
  String get noteOffEffect => 'Note Off エフェクト';

  @override
  String get style => 'スタイル';

  @override
  String get minAngle => '最小角度';

  @override
  String get maxAngle => '最大角度';

  @override
  String get type => 'タイプ';

  @override
  String get durationMs => '時間 (ms)';

  @override
  String get scaleMultiplier => '拡大倍率';

  @override
  String get multipleSelection => '複数選択';

  @override
  String get alignment => '整列';

  @override
  String get alignLeft => '左揃え';

  @override
  String get alignCenter => '左右中央揃え';

  @override
  String get alignRight => '右揃え';

  @override
  String get alignTop => '上揃え';

  @override
  String get alignMiddle => '上下中央揃え';

  @override
  String get alignBottom => '下揃え';

  @override
  String get enablePulseMode => 'パルスモードを有効化';

  @override
  String get colors => 'カラー';

  @override
  String get pathSmoothing => 'パススムージング';

  @override
  String get amount => '量';

  @override
  String get layers => 'レイヤー';

  @override
  String get group => 'グループ化';

  @override
  String get lock => 'ロック';

  @override
  String get visibility => '表示/非表示';

  @override
  String get exitFullscreen => '全画面終了';

  @override
  String get closeApp => 'アプリを終了';

  @override
  String get createPadGrid => 'PADグリッドを作成';

  @override
  String get rows => '行数';

  @override
  String get columns => '列数';

  @override
  String get create => '作成';
}
