import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vigorbloom/presentation/state/profile_providers.dart';
import 'package:vigorbloom/presentation/state/stats_provider.dart';
import 'package:vigorbloom/domain/entities/user_profile.dart';
import 'package:vigorbloom/domain/entities/stat_item.dart';

class HomeDashboardScreen extends ConsumerWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(userProfileProvider);
        ref.refresh(availableStatsProvider);
      },
      child: ListView(
        // <<< CORREÇÃO AQUI
        // Força o ListView a ser scrollável mesmo se o conteúdo for curto
        physics: const AlwaysScrollableScrollPhysics(),
        //
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        children: [
          const SizedBox(height: 16),
          const _TopBar(),
          const SizedBox(height: 24),
          const _Greeting(),
          const SizedBox(height: 24),
          const _ClassificationCard(),
          const SizedBox(height: 24),
          const _StatisticsCard(),
        ],
      ),
    );
  }
}

// ... (O restante do seu arquivo - _TopBar, _Greeting, etc. - continua igual)
// <<< 1. Widget convertido para ConsumerWidget
class _TopBar extends ConsumerWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final profile = ref.watch(userProfileProvider);

    return profile.when(
      data: (p) {
        final level = (p.xp / 5000).floor() + 1;
        final currentXp = p.xp % 5000;
        const goalXp = 5000;

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
                          const TextSpan(text: 'nvl. '),
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
              '$currentXp/$goalXp',
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
      error: (e, st) => const SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 8),
            Text('Erro ao carregar perfil'),
          ],
        ),
      ),
    );
  }
}

class _Greeting extends ConsumerWidget {
  const _Greeting();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final profile = ref.watch(userProfileProvider);

    final greetingName = profile.when(
      data: (p) => 'Olá, ${p.name.split(' ')[0]}!',
      loading: () => 'Olá!',
      error: (e, st) => 'Olá!',
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
          'Vamos juntos alcançar suas metas de saúde!',
          style:
              textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _ClassificationCard extends StatelessWidget {
  const _ClassificationCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

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
                '⭐ Classificação',
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
                          text: 'restam 4 dias',
                          icon: Icons.access_time_filled_rounded,
                        ),
                        const SizedBox(height: 8),
                        _InfoChip(
                          text: '3º Lugar',
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estatísticas',
                  style: textTheme.titleLarge,
                ),
                IconButton(
                  icon:
                      Icon(Icons.edit_outlined, color: colors.onSurfaceVariant),
                  onPressed: () => context.push('/dashboard/edit-stats'),
                ),
              ],
            ),
            const SizedBox(height: 4),
            availableStats.when(
              data: (list) {
                final selectedIds = selectedStats.valueOrNull ?? [];
                final statCards = list
                    .where((s) => selectedIds.contains(s.id))
                    .take(4)
                    .toList();

                return GridView.builder(
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
                      iconColor: _getColorForStat(stat.id), // Mapeia a cor
                    );
                  },
                );
              },
              loading: () => const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
              error: (e, st) => const Text('Erro ao carregar estatísticas'),
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
