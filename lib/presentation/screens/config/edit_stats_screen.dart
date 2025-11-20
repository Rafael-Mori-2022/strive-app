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

    final selectedList = selected.valueOrNull ?? [];
    final isMaxReached = selectedList.length >= 4;

    return Scaffold(
      appBar: AppBar(title: const Text('Editar destaques')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Selecione até 4 estatísticas para destacar',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: allStats.when(
              data: (list) => ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: list.length,
                itemBuilder: (_, i) {
                  final s = list[i];
                  final isOn = selectedList.contains(s.id);
                  final isEnabled = isOn || !isMaxReached;

                  return SwitchListTile(
                    title: Text(s.title),
                    subtitle: Text(s.value),
                    value: isOn,
                    onChanged: isEnabled ? (_) => notifier.toggle(s.id) : null,
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => const Center(child: Text('Erro')),
            ),
          ),
        ],
      ),
    );
  }
}
