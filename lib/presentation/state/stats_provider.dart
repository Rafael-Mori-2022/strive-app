import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
import 'package:strive/di/service_locator.dart';
import 'package:strive/domain/entities/stat_item.dart';
import 'package:strive/domain/repositories/stats_repository.dart';
import 'package:strive/providers/auth_providers.dart';
import 'package:strive/providers/locale_provider.dart'; 

final statsRepositoryProvider =
    Provider<StatsRepository>((ref) => sl<StatsRepository>());

final availableStatsProvider = FutureProvider<List<StatItem>>((ref) async {
  final firebaseUser = await ref.watch(authStateStreamProvider.future);
  if (firebaseUser == null) return [];
  return ref.read(statsRepositoryProvider).getAvailableStats(firebaseUser.uid);
});

class SelectedStatsNotifier extends AsyncNotifier<List<String>> {
  static const String _kSelectedStatsKey = 'selected_stats_ids';

  @override
  Future<List<String>> build() async {
    // 1. Tenta carregar do SharedPreferences primeiro (Local)
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedList = prefs.getStringList(_kSelectedStatsKey);

    if (savedList != null) {
      return savedList;
    }

    final firebaseUser = await ref.watch(authStateStreamProvider.future);
    if (firebaseUser != null) {
      final remoteIds = await ref
          .read(statsRepositoryProvider)
          .getSelectedStatIds(firebaseUser.uid);
      
      if (remoteIds.isNotEmpty) {
        await prefs.setStringList(_kSelectedStatsKey, remoteIds);
        return remoteIds;
      }
    }

    return ['calories', 'water', 'steps', 'heartRate']; 
  }

  Future<void> toggle(String id) async {
    final currentList = state.value ?? [];
    final newList = List<String>.from(currentList);

    if (newList.contains(id)) {
      newList.remove(id);
    } else {
      if (newList.length < 4) { 
        newList.add(id);
      }
    }

    state = AsyncData(newList);

    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setStringList(_kSelectedStatsKey, newList);

    final firebaseUser = ref.read(authStateStreamProvider).valueOrNull;
    if (firebaseUser != null) {
      ref.read(statsRepositoryProvider).setSelectedStatIds(firebaseUser.uid, newList);
    }
  }
}

final selectedStatsProvider =
    AsyncNotifierProvider<SelectedStatsNotifier, List<String>>(
        SelectedStatsNotifier.new);