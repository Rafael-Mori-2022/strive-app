import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strive/providers/locale_provider.dart'; // Importa o sharedPreferencesProvider

class ThemeNotifier extends Notifier<ThemeMode> {
  static const String _kThemeKey = 'app_theme';

  @override
  ThemeMode build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedTheme = prefs.getString(_kThemeKey);

    if (savedTheme == 'light') return ThemeMode.light;
    if (savedTheme == 'dark') return ThemeMode.dark;
    
    return ThemeMode.system; // Padrão
  }

  void toggleTheme(bool isDark) async {
    state = isDark ? ThemeMode.dark : ThemeMode.light;
    
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_kThemeKey, isDark ? 'dark' : 'light');
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});