import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/presentation/state/stats_provider.dart';
import 'package:strive/i18n/strings.g.dart'; // Importação do Slang

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
      // Título da AppBar
      appBar: AppBar(title: Text(t.edit_stats.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            // Instrução ao usuário
            child: Text(
              t.edit_stats.instruction,
              style: const TextStyle(color: Colors.grey),
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
                    title: Text(s.title), // Vem do provider (não alterado)
                    subtitle: Text(s.value), // Vem do provider (não alterado)
                    value: isOn,
                    onChanged: isEnabled ? (_) => notifier.toggle(s.id) : null,
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              // Reutilizando mensagem de erro comum
              error: (e, st) => Center(child: Text(t.common.error)),
            ),
          ),
        ],
      ),
    );
  }
}
