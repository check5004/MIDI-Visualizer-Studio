import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'MIDI Visualizer Studio'**
  String get appTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemTheme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @editorBackground.
  ///
  /// In en, this message translates to:
  /// **'Editor Background'**
  String get editorBackground;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @licenses.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get licenses;

  /// No description provided for @launchInPreviewMode.
  ///
  /// In en, this message translates to:
  /// **'Launch in Preview Mode'**
  String get launchInPreviewMode;

  /// No description provided for @launchInPreviewModeDescription.
  ///
  /// In en, this message translates to:
  /// **'Re-open last project in preview mode on launch'**
  String get launchInPreviewModeDescription;

  /// No description provided for @midi.
  ///
  /// In en, this message translates to:
  /// **'MIDI'**
  String get midi;

  /// No description provided for @streaming.
  ///
  /// In en, this message translates to:
  /// **'Streaming'**
  String get streaming;

  /// No description provided for @chromaKeyDefaults.
  ///
  /// In en, this message translates to:
  /// **'Chroma Key Defaults'**
  String get chromaKeyDefaults;

  /// No description provided for @chromaKeyDefaultsDescription.
  ///
  /// In en, this message translates to:
  /// **'Set the default background color for new projects.'**
  String get chromaKeyDefaultsDescription;

  /// No description provided for @defaultColor.
  ///
  /// In en, this message translates to:
  /// **'Default Color'**
  String get defaultColor;

  /// No description provided for @windowlessMode.
  ///
  /// In en, this message translates to:
  /// **'Windowless Mode'**
  String get windowlessMode;

  /// No description provided for @windowlessModeDescription.
  ///
  /// In en, this message translates to:
  /// **'Hide window title bar and frame (for OBS capturing).'**
  String get windowlessModeDescription;

  /// No description provided for @shortcuts.
  ///
  /// In en, this message translates to:
  /// **'Shortcuts'**
  String get shortcuts;

  /// No description provided for @resetToDefaults.
  ///
  /// In en, this message translates to:
  /// **'Reset to Defaults'**
  String get resetToDefaults;

  /// No description provided for @noShortcutsConfigured.
  ///
  /// In en, this message translates to:
  /// **'No shortcuts configured'**
  String get noShortcutsConfigured;

  /// No description provided for @pressKeys.
  ///
  /// In en, this message translates to:
  /// **'Press keys...'**
  String get pressKeys;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @dashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your MIDI visualizer projects'**
  String get dashboardSubtitle;

  /// No description provided for @tutorial.
  ///
  /// In en, this message translates to:
  /// **'Tutorial'**
  String get tutorial;

  /// No description provided for @recentProjects.
  ///
  /// In en, this message translates to:
  /// **'Recent Projects'**
  String get recentProjects;

  /// No description provided for @refreshProjects.
  ///
  /// In en, this message translates to:
  /// **'Refresh Projects'**
  String get refreshProjects;

  /// No description provided for @newProject.
  ///
  /// In en, this message translates to:
  /// **'New Project'**
  String get newProject;

  /// No description provided for @importFile.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importFile;

  /// No description provided for @importSuccess.
  ///
  /// In en, this message translates to:
  /// **'Imported {count} project(s) successfully'**
  String importSuccess(int count);

  /// No description provided for @importPartialSuccess.
  ///
  /// In en, this message translates to:
  /// **'Imported {success} project(s), failed to import {fail}'**
  String importPartialSuccess(int success, int fail);

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @exportProject.
  ///
  /// In en, this message translates to:
  /// **'Export Project'**
  String get exportProject;

  /// No description provided for @exportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Project exported successfully'**
  String get exportSuccess;

  /// No description provided for @exportFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to export project: {error}'**
  String exportFail(String error);

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteProject.
  ///
  /// In en, this message translates to:
  /// **'Delete Project'**
  String get deleteProject;

  /// No description provided for @deleteConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"? This action cannot be undone.'**
  String deleteConfirmation(String name);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @edited.
  ///
  /// In en, this message translates to:
  /// **'Edited {date}'**
  String edited(String date);

  /// No description provided for @unknownDate.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknownDate;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String daysAgo(int days);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String hoursAgo(int hours);

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String minutesAgo(int minutes);

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @restoreSession.
  ///
  /// In en, this message translates to:
  /// **'Restore Session?'**
  String get restoreSession;

  /// No description provided for @restoreSessionDescription.
  ///
  /// In en, this message translates to:
  /// **'An unsaved session was found. Do you want to restore your changes?'**
  String get restoreSessionDescription;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No description provided for @untitledProject.
  ///
  /// In en, this message translates to:
  /// **'Untitled Project'**
  String get untitledProject;

  /// No description provided for @openProject.
  ///
  /// In en, this message translates to:
  /// **'Open Project'**
  String get openProject;

  /// No description provided for @saveProject.
  ///
  /// In en, this message translates to:
  /// **'Save Project'**
  String get saveProject;

  /// No description provided for @projectSaved.
  ///
  /// In en, this message translates to:
  /// **'Project saved'**
  String get projectSaved;

  /// No description provided for @projectExported.
  ///
  /// In en, this message translates to:
  /// **'Project exported'**
  String get projectExported;

  /// No description provided for @midiSettings.
  ///
  /// In en, this message translates to:
  /// **'MIDI Settings'**
  String get midiSettings;

  /// No description provided for @toolSelect.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get toolSelect;

  /// No description provided for @toolRectangle.
  ///
  /// In en, this message translates to:
  /// **'Rectangle'**
  String get toolRectangle;

  /// No description provided for @toolCircle.
  ///
  /// In en, this message translates to:
  /// **'Circle'**
  String get toolCircle;

  /// No description provided for @toolPath.
  ///
  /// In en, this message translates to:
  /// **'Path'**
  String get toolPath;

  /// No description provided for @toolBucketFill.
  ///
  /// In en, this message translates to:
  /// **'Bucket Fill'**
  String get toolBucketFill;

  /// No description provided for @insertTemplate.
  ///
  /// In en, this message translates to:
  /// **'Insert Template'**
  String get insertTemplate;

  /// No description provided for @padGrid.
  ///
  /// In en, this message translates to:
  /// **'PAD Grid'**
  String get padGrid;

  /// No description provided for @tolerance.
  ///
  /// In en, this message translates to:
  /// **'Tolerance:'**
  String get tolerance;

  /// No description provided for @toolImage.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get toolImage;

  /// No description provided for @imageName.
  ///
  /// In en, this message translates to:
  /// **'Image {id}'**
  String imageName(String id);

  /// No description provided for @gridSettings.
  ///
  /// In en, this message translates to:
  /// **'Grid Settings'**
  String get gridSettings;

  /// No description provided for @showGrid.
  ///
  /// In en, this message translates to:
  /// **'Show Grid'**
  String get showGrid;

  /// No description provided for @snapToGrid.
  ///
  /// In en, this message translates to:
  /// **'Snap to Grid'**
  String get snapToGrid;

  /// No description provided for @gridSize.
  ///
  /// In en, this message translates to:
  /// **'Grid Size'**
  String get gridSize;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @renameProject.
  ///
  /// In en, this message translates to:
  /// **'Rename Project'**
  String get renameProject;

  /// No description provided for @noProjectSelected.
  ///
  /// In en, this message translates to:
  /// **'No Project Selected'**
  String get noProjectSelected;

  /// No description provided for @projectSettings.
  ///
  /// In en, this message translates to:
  /// **'Project Settings'**
  String get projectSettings;

  /// No description provided for @defaultNoteOnEffect.
  ///
  /// In en, this message translates to:
  /// **'Default Note On Effect'**
  String get defaultNoteOnEffect;

  /// No description provided for @defaultNoteOffEffect.
  ///
  /// In en, this message translates to:
  /// **'Default Note Off Effect'**
  String get defaultNoteOffEffect;

  /// No description provided for @selectComponentToEdit.
  ///
  /// In en, this message translates to:
  /// **'Select a component to edit its properties.'**
  String get selectComponentToEdit;

  /// No description provided for @properties.
  ///
  /// In en, this message translates to:
  /// **'Properties'**
  String get properties;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @x.
  ///
  /// In en, this message translates to:
  /// **'X'**
  String get x;

  /// No description provided for @y.
  ///
  /// In en, this message translates to:
  /// **'Y'**
  String get y;

  /// No description provided for @w.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get w;

  /// No description provided for @h.
  ///
  /// In en, this message translates to:
  /// **'H'**
  String get h;

  /// No description provided for @lockAspectRatio.
  ///
  /// In en, this message translates to:
  /// **'Lock Aspect Ratio'**
  String get lockAspectRatio;

  /// No description provided for @typeSpecific.
  ///
  /// In en, this message translates to:
  /// **'Type Specific'**
  String get typeSpecific;

  /// No description provided for @midiBinding.
  ///
  /// In en, this message translates to:
  /// **'MIDI Binding'**
  String get midiBinding;

  /// No description provided for @channel.
  ///
  /// In en, this message translates to:
  /// **'Channel'**
  String get channel;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @cc.
  ///
  /// In en, this message translates to:
  /// **'CC'**
  String get cc;

  /// No description provided for @na.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get na;

  /// No description provided for @velocityThreshold.
  ///
  /// In en, this message translates to:
  /// **'Velocity Threshold: {value}'**
  String velocityThreshold(int value);

  /// No description provided for @stopLearning.
  ///
  /// In en, this message translates to:
  /// **'Stop Learning'**
  String get stopLearning;

  /// No description provided for @bound.
  ///
  /// In en, this message translates to:
  /// **'Bound!'**
  String get bound;

  /// No description provided for @learnMidi.
  ///
  /// In en, this message translates to:
  /// **'Learn MIDI'**
  String get learnMidi;

  /// No description provided for @clearBinding.
  ///
  /// In en, this message translates to:
  /// **'Clear Binding'**
  String get clearBinding;

  /// No description provided for @shape.
  ///
  /// In en, this message translates to:
  /// **'Shape'**
  String get shape;

  /// No description provided for @cornerRadius.
  ///
  /// In en, this message translates to:
  /// **'Corner Radius'**
  String get cornerRadius;

  /// No description provided for @smoothing.
  ///
  /// In en, this message translates to:
  /// **'Smoothing'**
  String get smoothing;

  /// No description provided for @onColor.
  ///
  /// In en, this message translates to:
  /// **'On Color'**
  String get onColor;

  /// No description provided for @offColor.
  ///
  /// In en, this message translates to:
  /// **'Off Color'**
  String get offColor;

  /// No description provided for @pulseMode.
  ///
  /// In en, this message translates to:
  /// **'Pulse Mode'**
  String get pulseMode;

  /// No description provided for @pulseDurationMs.
  ///
  /// In en, this message translates to:
  /// **'Pulse Duration (ms)'**
  String get pulseDurationMs;

  /// No description provided for @noteOnEffect.
  ///
  /// In en, this message translates to:
  /// **'Note On Effect'**
  String get noteOnEffect;

  /// No description provided for @noteOffEffect.
  ///
  /// In en, this message translates to:
  /// **'Note Off Effect'**
  String get noteOffEffect;

  /// No description provided for @style.
  ///
  /// In en, this message translates to:
  /// **'Style'**
  String get style;

  /// No description provided for @minAngle.
  ///
  /// In en, this message translates to:
  /// **'Min Angle'**
  String get minAngle;

  /// No description provided for @maxAngle.
  ///
  /// In en, this message translates to:
  /// **'Max Angle'**
  String get maxAngle;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @durationMs.
  ///
  /// In en, this message translates to:
  /// **'Duration (ms)'**
  String get durationMs;

  /// No description provided for @scaleMultiplier.
  ///
  /// In en, this message translates to:
  /// **'Scale Multiplier'**
  String get scaleMultiplier;

  /// No description provided for @multipleSelection.
  ///
  /// In en, this message translates to:
  /// **'Multiple Selection'**
  String get multipleSelection;

  /// No description provided for @alignment.
  ///
  /// In en, this message translates to:
  /// **'Alignment'**
  String get alignment;

  /// No description provided for @alignLeft.
  ///
  /// In en, this message translates to:
  /// **'Align Left'**
  String get alignLeft;

  /// No description provided for @alignCenter.
  ///
  /// In en, this message translates to:
  /// **'Align Center'**
  String get alignCenter;

  /// No description provided for @alignRight.
  ///
  /// In en, this message translates to:
  /// **'Align Right'**
  String get alignRight;

  /// No description provided for @alignTop.
  ///
  /// In en, this message translates to:
  /// **'Align Top'**
  String get alignTop;

  /// No description provided for @alignMiddle.
  ///
  /// In en, this message translates to:
  /// **'Align Middle'**
  String get alignMiddle;

  /// No description provided for @alignBottom.
  ///
  /// In en, this message translates to:
  /// **'Align Bottom'**
  String get alignBottom;

  /// No description provided for @enablePulseMode.
  ///
  /// In en, this message translates to:
  /// **'Enable Pulse Mode'**
  String get enablePulseMode;

  /// No description provided for @colors.
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get colors;

  /// No description provided for @pathSmoothing.
  ///
  /// In en, this message translates to:
  /// **'Path Smoothing'**
  String get pathSmoothing;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @layers.
  ///
  /// In en, this message translates to:
  /// **'Layers'**
  String get layers;

  /// No description provided for @group.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get group;

  /// No description provided for @lock.
  ///
  /// In en, this message translates to:
  /// **'Lock'**
  String get lock;

  /// No description provided for @visibility.
  ///
  /// In en, this message translates to:
  /// **'Visibility'**
  String get visibility;

  /// No description provided for @exitFullscreen.
  ///
  /// In en, this message translates to:
  /// **'Exit Fullscreen'**
  String get exitFullscreen;

  /// No description provided for @closeApp.
  ///
  /// In en, this message translates to:
  /// **'Close App'**
  String get closeApp;

  /// No description provided for @createPadGrid.
  ///
  /// In en, this message translates to:
  /// **'Create PAD Grid'**
  String get createPadGrid;

  /// No description provided for @rows.
  ///
  /// In en, this message translates to:
  /// **'Rows'**
  String get rows;

  /// No description provided for @columns.
  ///
  /// In en, this message translates to:
  /// **'Columns'**
  String get columns;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
