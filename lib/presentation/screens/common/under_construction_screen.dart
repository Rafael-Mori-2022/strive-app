import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vigorbloom/presentation/widgets/common_widgets.dart';

class UnderConstructionScreen extends StatelessWidget {
  const UnderConstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('404')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.directions_run, color: scheme.primary, size: 72),
            const SizedBox(height: 16),
            Text('Essa página ainda está em construção!', style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text('Estava fazendo seu cardio e se perdeu?', style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            PrimaryButton(label: 'Voltar', leadingIcon: Icons.arrow_back, onPressed: () => context.pop(), isExpanded: true),
          ]),
        ),
      ),
    );
  }
}
