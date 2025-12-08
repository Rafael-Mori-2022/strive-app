import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/presentation/widgets/common_widgets.dart';
import 'package:strive/i18n/strings.g.dart'; 

class UnderConstructionScreen extends StatelessWidget {
  const UnderConstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      // Título "404"
      appBar: AppBar(title: Text(t.under_construction.title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.directions_run, color: scheme.primary, size: 72),
            const SizedBox(height: 16),
            // Mensagem de construção
            Text(t.under_construction.message,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center),
            const SizedBox(height: 8),
            // Subtítulo 
            Text(t.under_construction.subtitle,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            // Reutilizando "Voltar" do common
            PrimaryButton(
                label: t.common.back,
                leadingIcon: Icons.arrow_back,
                onPressed: () => context.go('/dashboard'),
                isExpanded: true),
          ]),
        ),
      ),
    );
  }
}
