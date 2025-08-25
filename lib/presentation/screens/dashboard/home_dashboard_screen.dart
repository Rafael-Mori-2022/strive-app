import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vigorbloom/presentation/state/profile_providers.dart';
import 'package:vigorbloom/presentation/state/stats_provider.dart';
import 'package:vigorbloom/presentation/widgets/common_widgets.dart';

class HomeDashboardScreen extends ConsumerWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);
    final availableStats = ref.watch(availableStatsProvider);
    final selected = ref.watch(selectedStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('VigorBloom'),
        actions: [
          IconButton(
              icon: const Icon(Icons.explore_outlined, color: Colors.blue),
              onPressed: () => context.push('/dashboard/explore')),
          IconButton(
              icon: const Icon(Icons.emoji_events, color: Colors.amber),
              onPressed: () => context.push('/dashboard/leaderboard')),
          IconButton(
              icon: const Icon(Icons.tune, color: Colors.deepPurple),
              onPressed: () => context.push('/dashboard/edit-stats')),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            profile.when(
              data: (p) => Text('Olá, ${p.name} 👋',
                  style: Theme.of(context).textTheme.headlineMedium),
              loading: () =>
                  const SizedBox(height: 28, child: LinearProgressIndicator()),
              error: (e, st) => const Text('Olá!'),
            ),
            const SizedBox(height: 16),
            const XPBar(
                progress: 0.65, label: 'Faltam 350 XP para o próximo nível'),
            const SizedBox(height: 16),
            LeagueCard(
                tier: 'Prata II',
                rank: 12,
                onTap: () => context.push('/dashboard/leaderboard')),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Seus destaques',
                  style: Theme.of(context).textTheme.titleLarge),
              TextButton.icon(
                  onPressed: () => context.push('/dashboard/edit-stats'),
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Editar')),
            ]),
            const SizedBox(height: 8),
            availableStats.when(
              data: (list) {
                final selectedIds = selected.valueOrNull ?? [];
                final statCards = list
                    .where((s) => selectedIds.contains(s.id))
                    .take(4)
                    .toList();
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: statCards.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 120,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12),
                  itemBuilder: (_, i) {
                    final s = statCards[i];
                    return StatCard(
                        title: s.title,
                        value: s.value,
                        icon: s.icon,
                        onTap: () {});
                  },
                );
              },
              loading: () => const Center(
                  child: Padding(
                      padding: EdgeInsets.all(24),
                      child: CircularProgressIndicator())),
              error: (e, st) => const Text('Erro ao carregar stats'),
            ),
          ],
        ),
      ),
    );
  }
}
