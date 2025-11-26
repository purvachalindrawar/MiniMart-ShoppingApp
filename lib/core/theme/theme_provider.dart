import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

const _settingsBoxName = 'settingsBox';
const _themeKey = 'themeMode';

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) {
    final box = Hive.box(_settingsBoxName);
    final stored = box.get(_themeKey, defaultValue: 'light') as String;
    final initial = stored == 'dark' ? ThemeMode.dark : ThemeMode.light;
    return ThemeModeNotifier(box, initial);
  },
);

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier(this._box, ThemeMode initial) : super(initial);

  final Box _box;

  void toggle() {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
      _box.put(_themeKey, 'dark');
    } else {
      state = ThemeMode.light;
      _box.put(_themeKey, 'light');
    }
  }
}
