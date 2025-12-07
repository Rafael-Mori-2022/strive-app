import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/providers/theme_provider.dart';
import 'package:strive/theme.dart';
import 'package:strive/routes/app_router.dart';
import 'package:strive/di/service_locator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:strive/providers/locale_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:strive/i18n/strings.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupServiceLocator();

  final prefs = await SharedPreferences.getInstance();

  final savedLocaleCode = prefs.getString('app_locale'); 
  if (savedLocaleCode != null) {
    final locale = AppLocale.values.firstWhere(
      (l) => l.languageCode == savedLocaleCode,
      orElse: () => AppLocale.pt,
    );
    LocaleSettings.setLocale(locale);
  } else {
    LocaleSettings.useDeviceLocale();
  }
  // ---------------------

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: TranslationProvider(
        child: const StriveApp(),
      ),
    ),
  );
}

class StriveApp extends ConsumerWidget {
  const StriveApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final currentThemeMode = ref.watch(themeProvider);
    
    final currentLocale = ref.watch(localeProvider); 

    return MaterialApp.router(
      title: 'Strive',
      debugShowCheckedModeBanner: false,
      
      locale: currentLocale.flutterLocale, 
      
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: currentThemeMode,
      routerConfig: router,
    );
  }
}