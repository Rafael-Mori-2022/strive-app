import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/domain/entities/leaderboard_entry.dart';
import 'package:strive/presentation/state/leaderboard_provider.dart';

class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen> {
  late PageController _pageController;
  final int _currentLeagueIndex = 4;

  final List<Map<String, dynamic>> _leagues = [
    {'name': 'MADEIRA', 'color': Color(0xFF8D6E63), 'icon': Icons.nature},
    {'name': 'FERRO', 'color': Color(0xFF78909C), 'icon': Icons.gavel},
    {
      'name': 'BRONZE',
      'color': Color.fromARGB(255, 193, 83, 49),
      'icon': Icons.shield_outlined
    },
    {'name': 'PRATA', 'color': Color(0xFF90A4AE), 'icon': Icons.shield},
    {'name': 'OURO', 'color': Color(0xFFFFC107), 'icon': Icons.shield},
    {
      'name': 'PLATINA',
      'color': Color(0xFF00BCD4),
      'icon': Icons.diamond_outlined
    },
    {'name': 'DIAMANTE', 'color': Color(0xFF2979FF), 'icon': Icons.diamond},
    {'name': 'OBSIDIANA', 'color': Color(0xFF311B92), 'icon': Icons.hexagon},
    {'name': 'MESTRE', 'color': Color(0xFFD500F9), 'icon': Icons.auto_awesome},
    {'name': 'ESTELAR', 'color': Color(0xFF00E676), 'icon': Icons.stars},
    {
      'name': 'LENDA',
      'color': Color(0xFFFF3D00),
      'icon': Icons.local_fire_department
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.18,
      initialPage: _currentLeagueIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final board = ref.watch(leaderboardProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: board.when(
        data: (originalList) {
          final sortedList = List<LeaderboardEntry>.from(originalList)
            ..sort((a, b) => b.xp.compareTo(a.xp));

          return Column(
            children: [
              SizedBox(
                height: 150,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _leagues.length,
                  itemBuilder: (context, index) {
                    final isLocked = index > _currentLeagueIndex;
                    return AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        double value = 1.0;
                        if (_pageController.position.haveDimensions) {
                          value = _pageController.page! - index;
                          value = (1 - (value.abs() * 0.4)).clamp(0.0, 1.0);
                        } else {
                          value = index == _currentLeagueIndex ? 1.0 : 0.6;
                        }
                        return Center(
                          child: Transform.scale(
                            scale: Curves.easeOut.transform(value),
                            child: Opacity(
                              opacity: value < 0.8 ? 0.5 : 1.0,
                              child: child,
                            ),
                          ),
                        );
                      },
                      child: _buildLeagueItem(_leagues[index], isLocked),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: sortedList.length,
                  itemBuilder: (_, i) {
                    final e = sortedList[i];
                    final position = i + 1;

                    final bool showPromoLineBelow = i == 4;
                    final bool showDemotionLineAbove =
                        sortedList.length > 5 && i == sortedList.length - 5;

                    return Column(
                      children: [
                        if (showDemotionLineAbove)
                          _buildZoneDivider("ZONA DE REBAIXAMENTO",
                              Colors.redAccent, Icons.arrow_downward),
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 30,
                                child: Center(child: _getRankIcon(position)),
                              ),
                              const SizedBox(width: 12),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.deepPurple.shade50,
                                child: Icon(Icons.person,
                                    color: Colors.deepPurple.shade300),
                              ),
                            ],
                          ),
                          title: Text(
                            e.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Nível ${e.level}',
                          ),
                          trailing: Text(
                            '${e.xp} XP',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (showPromoLineBelow)
                          _buildZoneDivider("ZONA DE PROMOÇÃO",
                              const Color(0xFF43A047), Icons.arrow_upward),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) =>
            const Center(child: Text('Erro ao carregar leaderboard')),
      ),
    );
  }

  Widget _buildZoneDivider(String text, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: Divider(color: color.withOpacity(0.5), thickness: 1)),
          const SizedBox(width: 12),
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Divider(color: color.withOpacity(0.5), thickness: 1)),
        ],
      ),
    );
  }

  Widget _buildLeagueItem(Map<String, dynamic> league, bool isLocked) {
    final color = isLocked ? Colors.grey.shade200 : league['color'] as Color;
    final icon = isLocked ? Icons.lock_outline : league['icon'] as IconData;
    final iconColor = isLocked ? Colors.grey.shade400 : color;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 45, color: iconColor),
        const SizedBox(height: 8),
        if (!isLocked)
          Text(
            league['name'] as String,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w800, color: color),
          ),
      ],
    );
  }

  Widget _getRankIcon(int position) {
    switch (position) {
      case 1:
        return const Icon(Icons.workspace_premium,
            color: Color(0xFFFFC107), size: 28);
      case 2:
        return const Icon(Icons.workspace_premium,
            color: Color(0xFF90A4AE), size: 26);
      case 3:
        return const Icon(Icons.workspace_premium,
            color: Color.fromARGB(255, 193, 83, 49));
      default:
        return Text(
          "$position",
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        );
    }
  }
}
