import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/presentation/state/stats_provider.dart';

class EditStatsScreen extends ConsumerWidget {
  const EditStatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allStats = ref.watch(availableStatsProvider);
    final selected = ref.watch(selectedStatsProvider);
    final notifier = ref.read(selectedStatsProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Editar destaques')),
      body: allStats.when(
        data: (list) => ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: list.length,
          itemBuilder: (_, i) {
            final s = list[i];
            final isOn = (selected.valueOrNull ?? []).contains(s.id);
            return SwitchListTile(
              title: Text(s.title),
              subtitle: Text(s.value),
              value: isOn,
              onChanged: (_) => notifier.toggle(s.id),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => const Center(child: Text('Erro')),
      ),
    );
  }
}
