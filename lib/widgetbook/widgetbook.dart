import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:strive/firebase_options.dart';
import 'package:strive/di/service_locator.dart';
import 'package:strive/i18n/strings.g.dart';
import 'package:strive/main.dart';
import 'package:strive/providers/locale_provider.dart'; 

import 'widgetbook.directories.g.dart';

late final SharedPreferences widgetbookPrefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LocaleSettings.useDeviceLocale();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupServiceLocator();

  widgetbookPrefs = await SharedPreferences.getInstance();

  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: ThemeData.light()),
            WidgetbookTheme(name: 'Dark', data: ThemeData.dark()),
          ],
        ),
      ],
    );
  }
}


@widgetbook.UseCase(
  name: 'Aplicação Completa',
  type: StriveApp,
)
Widget buildFullApp(BuildContext context) {
  return ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(widgetbookPrefs),
    ],
    child: TranslationProvider(
      child: const StriveApp(),
    ),
  );
}