import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class ColorHistoryService {
  static const String _key = 'color_history';
  static const int _maxHistory = 100;
  final SharedPreferences _prefs;

  ColorHistoryService(this._prefs);

  List<Color> getHistory() {
    final history = _prefs.getStringList(_key) ?? [];
    return history.map((e) => Color(int.parse(e))).toList();
  }

  Future<void> addToHistory(Color color) async {
    final history = getHistory();
    // Remove if exists to move to top
    history.removeWhere((c) => c.value == color.value);

    // Add to beginning
    history.insert(0, color);

    // Trim to max
    if (history.length > _maxHistory) {
      history.removeRange(_maxHistory, history.length);
    }

    await _prefs.setStringList(_key, history.map((c) => c.value.toString()).toList());
  }
}
