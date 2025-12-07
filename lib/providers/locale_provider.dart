import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strive/i18n/strings.g.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences não inicializado');
});

class LocaleNotifier extends Notifier<AppLocale> {
  static const String _kLocaleKey = 'app_locale';

  @override
  AppLocale build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedCode = prefs.getString(_kLocaleKey);

    if (savedCode != null) {
      return AppLocale.values.firstWhere(
        (l) => l.languageCode == savedCode,
        orElse: () => AppLocale.pt,
      );
    }

    return AppLocale.pt;
  }

  Future<void> setLocale(AppLocale newLocale) async {
    state = newLocale; 
    
    LocaleSettings.setLocale(newLocale);
    
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_kLocaleKey, newLocale.languageCode);
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, AppLocale>(() {
  return LocaleNotifier();
});