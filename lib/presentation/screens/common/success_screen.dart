import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/presentation/widgets/common_widgets.dart';
import 'package:strive/i18n/strings.g.dart'; // Importação do Slang

class SuccessScreen extends StatelessWidget {
  final String message;
  const SuccessScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      // Título da AppBar
      appBar: AppBar(title: Text(t.success.title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 88),
            const SizedBox(height: 16),
            // Mensagem de sucesso padrão
            Text(t.success.default_message,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center),
            const SizedBox(height: 12),
            // Mensagem dinâmica (mantida original)
            Text(message,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            // Botão Voltar (Adicionado ao common)
            PrimaryButton(
                label: t.common.back,
                leadingIcon: Icons.arrow_back,
                onPressed: () => context.pop(),
                isExpanded: true),
          ]),
        ),
      ),
      backgroundColor: scheme.surface,
    );
  }
}
