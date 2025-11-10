import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/presentation/widgets/common_widgets.dart';

class SuccessScreen extends StatelessWidget {
  final String message;
  const SuccessScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Sucesso')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.check_circle, color: Colors.green, size: 88),
            const SizedBox(height: 16),
            Text('Tudo Certo! Seus dados foram cadastrados!',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center),
            const SizedBox(height: 12),
            Text(message,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            PrimaryButton(
                label: 'Voltar',
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
