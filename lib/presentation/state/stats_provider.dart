import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigorbloom/di/service_locator.dart';
import 'package:vigorbloom/domain/entities/stat_item.dart';
import 'package:vigorbloom/domain/repositories/stats_repository.dart';

final statsRepositoryProvider =
    Provider<StatsRepository>((ref) => sl<StatsRepository>());

final availableStatsProvider = FutureProvider<List<StatItem>>(
    (ref) async => ref.read(statsRepositoryProvider).getAvailableStats());

class SelectedStatsNotifier extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() async {
    // CORREÇÃO: Buscamos os dados do repositório.
    final selectedIds =
        await ref.read(statsRepositoryProvider).getSelectedStatIds();

    // GARANTIMOS O TIPO: Convertemos a lista para List<String> explicitamente.
    // Isso resolve o erro original e o erro em cascata na linha 30.
    return List<String>.from(selectedIds);
  }

  Future<void> toggle(String id) async {
    // Agora 'state.value' será corretamente um List<String>?,
    // então 'current' também será um List<String>.
    final current = List<String>.from(state.value ?? const <String>[]);
    if (current.contains(id)) {
      current.remove(id);
    } else {
      current.add(id);
    }
    state = const AsyncLoading();

    // Esta chamada agora funcionará, pois 'current' tem o tipo correto.
    await ref.read(statsRepositoryProvider).setSelectedStatIds(current);
    state = AsyncData(current);
  }
}

final selectedStatsProvider =
    AsyncNotifierProvider<SelectedStatsNotifier, List<String>>(
        SelectedStatsNotifier.new);
