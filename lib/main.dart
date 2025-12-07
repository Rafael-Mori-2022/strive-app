import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/providers/theme_provider.dart';
import 'package:strive/theme.dart';
import 'package:strive/routes/app_router.dart';
import 'package:strive/di/service_locator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';

// 1. Importe o arquivo gerado pelo Slang
import 'package:strive/i18n/strings.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Inicialize o Slang para usar o local do dispositivo
  LocaleSettings.useDeviceLocale();

  // Inicialização do Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupServiceLocator();

  // 3. Envolva o StriveApp no TranslationProvider
  // A ordem sugerida é: ProviderScope -> TranslationProvider -> App
  runApp(
    ProviderScope(
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

    return MaterialApp.router(
      title: 'Strive',
      debugShowCheckedModeBanner: false,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: currentThemeMode,
      routerConfig: router,
    );
  }
}
