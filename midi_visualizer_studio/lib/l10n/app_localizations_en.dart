// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'MIDI Visualizer Studio';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get systemTheme => 'System';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get general => 'General';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get editorBackground => 'Editor Background';

  @override
  String get version => 'Version';

  @override
  String get licenses => 'Licenses';

  @override
  String get launchInPreviewMode => 'Launch in Preview Mode';

  @override
  String get launchInPreviewModeDescription =>
      'Re-open last project in preview mode on launch';

  @override
  String get midi => 'MIDI';

  @override
  String get streaming => 'Streaming';

  @override
  String get chromaKeyDefaults => 'Chroma Key Defaults';

  @override
  String get chromaKeyDefaultsDescription =>
      'Set the default background color for new projects.';

  @override
  String get defaultColor => 'Default Color';

  @override
  String get windowlessMode => 'Windowless Mode';

  @override
  String get windowlessModeDescription =>
      'Hide window title bar and frame (for OBS capturing).';

  @override
  String get shortcuts => 'Shortcuts';

  @override
  String get resetToDefaults => 'Reset to Defaults';

  @override
  String get noShortcutsConfigured => 'No shortcuts configured';

  @override
  String get pressKeys => 'Press keys...';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get dashboardSubtitle => 'Manage your MIDI visualizer projects';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get recentProjects => 'Recent Projects';

  @override
  String get refreshProjects => 'Refresh Projects';

  @override
  String get newProject => 'New Project';

  @override
  String get importFile => 'Import';

  @override
  String importSuccess(int count) {
    return 'Imported $count project(s) successfully';
  }

  @override
  String importPartialSuccess(int success, int fail) {
    return 'Imported $success project(s), failed to import $fail';
  }

  @override
  String get edit => 'Edit';

  @override
  String get export => 'Export';

  @override
  String get exportProject => 'Export Project';

  @override
  String get exportSuccess => 'Project exported successfully';

  @override
  String exportFail(String error) {
    return 'Failed to export project: $error';
  }

  @override
  String get delete => 'Delete';

  @override
  String get deleteProject => 'Delete Project';

  @override
  String deleteConfirmation(String name) {
    return 'Are you sure you want to delete \"$name\"? This action cannot be undone.';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String edited(String date) {
    return 'Edited $date';
  }

  @override
  String get unknownDate => 'Unknown';

  @override
  String daysAgo(int days) {
    return '${days}d ago';
  }

  @override
  String hoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String minutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String get justNow => 'Just now';

  @override
  String get restoreSession => 'Restore Session?';

  @override
  String get restoreSessionDescription =>
      'An unsaved session was found. Do you want to restore your changes?';

  @override
  String get discard => 'Discard';

  @override
  String get restore => 'Restore';

  @override
  String get untitledProject => 'Untitled Project';

  @override
  String get openProject => 'Open Project';

  @override
  String get saveProject => 'Save Project';

  @override
  String get projectSaved => 'Project saved';

  @override
  String get projectExported => 'Project exported';

  @override
  String get midiSettings => 'MIDI Settings';

  @override
  String get toolSelect => 'Select';

  @override
  String get toolRectangle => 'Rectangle';

  @override
  String get toolCircle => 'Circle';

  @override
  String get toolPath => 'Path';

  @override
  String get toolBucketFill => 'Bucket Fill';

  @override
  String get insertTemplate => 'Insert Template';

  @override
  String get padGrid => 'PAD Grid';

  @override
  String get tolerance => 'Tolerance:';

  @override
  String get toolImage => 'Image';

  @override
  String imageName(String id) {
    return 'Image $id';
  }

  @override
  String get gridSettings => 'Grid Settings';

  @override
  String get showGrid => 'Show Grid';

  @override
  String get snapToGrid => 'Snap to Grid';

  @override
  String get gridSize => 'Grid Size';

  @override
  String get preview => 'Preview';

  @override
  String get renameProject => 'Rename Project';

  @override
  String get noProjectSelected => 'No Project Selected';

  @override
  String get projectSettings => 'Project Settings';

  @override
  String get defaultNoteOnEffect => 'Default Note On Effect';

  @override
  String get defaultNoteOffEffect => 'Default Note Off Effect';

  @override
  String get selectComponentToEdit =>
      'Select a component to edit its properties.';

  @override
  String get properties => 'Properties';

  @override
  String get name => 'Name';

  @override
  String get x => 'X';

  @override
  String get y => 'Y';

  @override
  String get w => 'W';

  @override
  String get h => 'H';

  @override
  String get lockAspectRatio => 'Lock Aspect Ratio';

  @override
  String get typeSpecific => 'Type Specific';

  @override
  String get midiBinding => 'MIDI Binding';

  @override
  String get channel => 'Channel';

  @override
  String get note => 'Note';

  @override
  String get cc => 'CC';

  @override
  String get na => 'N/A';

  @override
  String velocityThreshold(int value) {
    return 'Velocity Threshold: $value';
  }

  @override
  String get stopLearning => 'Stop Learning';

  @override
  String get bound => 'Bound!';

  @override
  String get learnMidi => 'Learn MIDI';

  @override
  String get clearBinding => 'Clear Binding';

  @override
  String get shape => 'Shape';

  @override
  String get cornerRadius => 'Corner Radius';

  @override
  String get smoothing => 'Smoothing';

  @override
  String get onColor => 'On Color';

  @override
  String get offColor => 'Off Color';

  @override
  String get pulseMode => 'Pulse Mode';

  @override
  String get pulseDurationMs => 'Pulse Duration (ms)';

  @override
  String get noteOnEffect => 'Note On Effect';

  @override
  String get noteOffEffect => 'Note Off Effect';

  @override
  String get style => 'Style';

  @override
  String get minAngle => 'Min Angle';

  @override
  String get maxAngle => 'Max Angle';

  @override
  String get type => 'Type';

  @override
  String get durationMs => 'Duration (ms)';

  @override
  String get scaleMultiplier => 'Scale Multiplier';

  @override
  String get multipleSelection => 'Multiple Selection';

  @override
  String get alignment => 'Alignment';

  @override
  String get alignLeft => 'Align Left';

  @override
  String get alignCenter => 'Align Center';

  @override
  String get alignRight => 'Align Right';

  @override
  String get alignTop => 'Align Top';

  @override
  String get alignMiddle => 'Align Middle';

  @override
  String get alignBottom => 'Align Bottom';

  @override
  String get enablePulseMode => 'Enable Pulse Mode';

  @override
  String get colors => 'Colors';

  @override
  String get pathSmoothing => 'Path Smoothing';

  @override
  String get amount => 'Amount';

  @override
  String get layers => 'Layers';

  @override
  String get group => 'Group';

  @override
  String get lock => 'Lock';

  @override
  String get visibility => 'Visibility';

  @override
  String get exitFullscreen => 'Exit Fullscreen';

  @override
  String get closeApp => 'Close App';

  @override
  String get createPadGrid => 'Create PAD Grid';

  @override
  String get rows => 'Rows';

  @override
  String get columns => 'Columns';

  @override
  String get create => 'Create';
}
