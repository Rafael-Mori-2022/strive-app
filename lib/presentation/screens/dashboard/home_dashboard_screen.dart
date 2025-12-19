import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/presentation/state/profile_providers.dart';
import 'package:strive/presentation/state/stats_provider.dart';
import 'package:strive/i18n/strings.g.dart'; 
import 'package:strive/presentation/state/leaderboard_provider.dart';

class HomeDashboardScreen extends ConsumerWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(userProfileProvider);
          ref.refresh(availableStatsProvider);
          ref.refresh(leaderboardProvider); // Atualiza o ranking também
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          children: [
            const _TopBar(),
            const SizedBox(height: 24),
            const _Greeting(),
            const SizedBox(height: 24),
            const _ClassificationCard(),
            const SizedBox(height: 24),
            const _StatisticsCard(),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends ConsumerWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final profile = ref.watch(userProfileProvider);

    return profile.when(
      data: (p) {
        // CORREÇÃO: Usando 1000 XP para alinhar com o GamificationController
        const int xpPerLevel = 1000; 
        
        // Se o objeto 'p' (Profile) já tiver o campo .level vindo do banco, 
        // prefira usar: final level = p.level;
        // Caso contrário, calculamos igual ao Controller:
        final level = (p.xp / xpPerLevel).floor() + 1;
        
        final currentXp = p.xp % xpPerLevel;
        const goalXp = xpPerLevel;

        return Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: currentXp / goalXp,
                    strokeWidth: 5,
                    backgroundColor: colors.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
                  ),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: textTheme.labelSmall
                            ?.copyWith(color: colors.primary),
                        children: [
                          TextSpan(text: '${t.dashboard.level_abbr} '),
                          TextSpan(
                            text: '$level',
                            style: textTheme.titleMedium
                                ?.copyWith(color: colors.primary, height: 1.1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              // Exibe XP formatado (ex: 400/1000)
              '${currentXp.toInt()}/$goalXp',
              style: textTheme.bodyMedium
                  ?.copyWith(color: colors.onSurfaceVariant),
            ),
            const Spacer(),
            InkWell(
              onTap: () => context.push('/profile'),
              borderRadius: BorderRadius.circular(24),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: colors.surfaceVariant,
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: colors.onSurfaceVariant.withOpacity(0.8),
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const SizedBox(
        height: 50,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: LinearProgressIndicator(),
        ),
      ),
      error: (e, st) => SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red),
            const SizedBox(width: 8),
            Text(t.common.error_profile),
          ],
        ),
      ),
    );
  }
}

// ... (Resto do arquivo: _Greeting, _ClassificationCard, etc. mantidos iguais)
// O erro estava apenas na lógica da _TopBar acima. 
// Copie as outras classes do código anterior se precisar, elas não mudaram.

class _Greeting extends ConsumerWidget {
  const _Greeting();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final profile = ref.watch(userProfileProvider);

    final greetingName = profile.when(
      data: (p) => '${t.dashboard.greeting}${p.name.split(' ')[0]}!',
      loading: () => t.dashboard.greeting_generic,
      error: (e, st) => t.dashboard.greeting_generic,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greetingName,
          style:
              textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          t.dashboard.subtitle,
          style:
              textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _ClassificationCard extends ConsumerWidget {
  const _ClassificationCard();

  int _getDaysRemaining() {
    final now = DateTime.now();
    final daysUntilSunday = DateTime.sunday - now.weekday;
    return daysUntilSunday <= 0 ? 0 : daysUntilSunday;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final days = _getDaysRemaining();
    final myRank = ref.watch(myRankProvider); 

    return InkWell(
      onTap: () => context.push('/dashboard/leaderboard'),
      borderRadius: BorderRadius.circular(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.dashboard.classification.title,
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.shield,
                    color: colors.primary,
                    size: 100,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: [
                        _InfoChip(
                          text:
                              '${t.dashboard.classification.remaining_prefix}$days${t.dashboard.classification.remaining_suffix}',
                          icon: Icons.access_time_filled_rounded,
                        ),
                        const SizedBox(height: 8),
                        
                        if (myRank != null)
                          _InfoChip(
                            text: '$myRank${t.dashboard.classification.rank_suffix}',
                            icon: Icons.emoji_events_rounded,
                          )
                        else
                          const _InfoChip(
                            text: '---',
                            icon: Icons.emoji_events_rounded,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatisticsCard extends ConsumerWidget {
  const _StatisticsCard();

  Color _getColorForStat(String id) {
    switch (id) {
      case 'water':
        return const Color(0xFF53A9FF);
      case 'calories':
        return const Color(0xFFFF8A65);
      case 'steps':
        return const Color(0xFFFF8A65);
      case 'heartRate':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final availableStats = ref.watch(availableStatsProvider);
    final selectedStats = ref.watch(selectedStatsProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.dashboard.stats.title,
                  style: textTheme.titleLarge,
                ),
                IconButton(
                  icon:
                      Icon(Icons.edit_outlined, color: colors.onSurfaceVariant),
                  onPressed: () => context.push('/dashboard/edit-stats'),
                ),
              ],
            ),
            availableStats.when(
              data: (list) {
                final selectedIds = selectedStats.valueOrNull ?? [];
                final statCards = list
                    .where((s) => selectedIds.contains(s.id))
                    .take(4)
                    .toList();

                if (statCards.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.only(top: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      t.dashboard.stats.empty,
                      style: textTheme.bodyMedium
                          ?.copyWith(color: colors.onSurfaceVariant),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.only(top: 16.0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.8,
                  ),
                  itemCount: statCards.length,
                  itemBuilder: (context, index) {
                    final stat = statCards[index];
                    return _StatGridItem(
                      text: stat.value,
                      icon: stat.icon,
                      iconColor: _getColorForStat(stat.id),
                    );
                  },
                );
              },
              loading: () => const SizedBox(
                height: 150,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, st) => Container(
                padding: const EdgeInsets.only(top: 16.0),
                alignment: Alignment.center,
                child: Text(t.common.error_stats),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.text, required this.icon});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: colors.onSurface),
          const SizedBox(width: 8),
          Text(text, style: textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _StatGridItem extends StatelessWidget {
  const _StatGridItem(
      {required this.text, required this.icon, required this.iconColor});
  final String text;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: iconColor),
          const SizedBox(height: 8),
          Text(text, style: textTheme.titleSmall),
        ],
      ),
    );
  }
}