import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Importe suas configurações e o app
import 'package:strive/firebase_options.dart'; // Certifique-se que o caminho está certo
import 'package:strive/di/service_locator.dart';
import 'package:strive/i18n/strings.g.dart'; // Slang
import 'package:strive/main.dart'; // Para importar o StriveApp

// Importe o arquivo gerado (vai dar erro até rodar o build_runner)
import 'widgetbook.directories.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // --- REPLICANDO A INICIALIZAÇÃO DA SUA MAIN ---

  // 1. Slang
  LocaleSettings.useDeviceLocale();

  // 2. Firebase
  // Nota: Se rodar na web, certifique-se que o firebase_options suporta web
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 3. Service Locator
  await setupServiceLocator();

  // --- FIM DA INICIALIZAÇÃO ---

  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories, // Gerado automaticamente
      addons: [
        // Adiciona suporte a troca de tema Dark/Light no menu do Widgetbook
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

// --- AQUI ESTÁ O "PULO DO GATO" PARA O SEU PROFESSOR ---

@widgetbook.UseCase(
  name: 'Aplicação Completa',
  type: StriveApp,
)
Widget buildFullApp(BuildContext context) {
  // Precisamos envelopar o StriveApp nos mesmos Providers da sua main original
  // senão o Riverpod e o Slang vão quebrar.
  return ProviderScope(
    child: TranslationProvider(
      child: const StriveApp(),
    ),
  );
}
