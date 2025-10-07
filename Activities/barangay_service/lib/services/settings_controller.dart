import 'package:flutter/material.dart';

class SettingsController {
  SettingsController._();
  static final SettingsController instance = SettingsController._();

  final themeMode = ValueNotifier<ThemeMode>(ThemeMode.system);

  Future<void> load() async {
    // Stub: load from storage if you want.
    themeMode.value = ThemeMode.system;
  }

  void setThemeMode(ThemeMode mode) => themeMode.value = mode;
}
