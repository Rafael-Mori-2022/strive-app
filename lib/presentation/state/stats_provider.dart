import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigorbloom/di/service_locator.dart';
import 'package:vigorbloom/domain/entities/stat_item.dart';
import 'package:vigorbloom/domain/repositories/stats_repository.dart';
import 'package:vigorbloom/providers/auth_providers.dart';

final statsRepositoryProvider =
    Provider<StatsRepository>((ref) => sl<StatsRepository>());

final availableStatsProvider = FutureProvider<List<StatItem>>((ref) async {
  // Assiste ao estado de autenticação do Firebase
  final firebaseUser = await ref.watch(authStateStreamProvider.future);

  // Se não houver usuário, retorna uma lista vazia
  if (firebaseUser == null) {
    return [];
  }
  
  // Usa o UID para buscar as estatísticas
  return ref.read(statsRepositoryProvider).getAvailableStats(firebaseUser.uid);
});

class SelectedStatsNotifier extends AsyncNotifier<List<String>> {
  // Helper para pegar o UID de forma segura nos métodos de ação
  String _getUid() {
    final firebaseUser = ref.read(authStateStreamProvider).valueOrNull;
    if (firebaseUser == null) {
      throw Exception("Usuário não autenticado. Não é possível realizar a ação.");
    }
    return firebaseUser.uid;
  }

  @override
  Future<List<String>> build() async {
    // Aguarda o auth resolver
    final firebaseUser = await ref.watch(authStateStreamProvider.future);

    if (firebaseUser == null) {
      return []; // Retorna lista vazia se deslogado
    }

    // Busca os dados do repositório usando o uid
    final selectedIds = await ref
        .read(statsRepositoryProvider)
        .getSelectedStatIds(firebaseUser.uid);

    return List<String>.from(selectedIds);
  }

  Future<void> toggle(String id) async {
    // Pega o UID atual
    final String uid;
    try {
      uid = _getUid();
    } catch (e) {
      // Se o usuário tentar clicar no toggle antes da auth carregar
      state = AsyncError(e, StackTrace.current);
      return;
    }

    final current = List<String>.from(state.value ?? const <String>[]);
    if (current.contains(id)) {
      current.remove(id);
    } else {
      current.add(id);
    }
    state = const AsyncLoading();

    await ref.read(statsRepositoryProvider).setSelectedStatIds(uid, current);
    
    state = AsyncData(current);
  }

}

final selectedStatsProvider =
    AsyncNotifierProvider<SelectedStatsNotifier, List<String>>(
        SelectedStatsNotifier.new);
