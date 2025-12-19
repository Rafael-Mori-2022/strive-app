import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/domain/entities/leaderboard_entry.dart';
import 'package:strive/presentation/state/leaderboard_provider.dart';
import 'package:strive/providers/auth_providers.dart';
import 'package:strive/i18n/strings.g.dart';

class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen> {
  late PageController _pageController;
  // O índice inicial será ajustado quando os dados carregarem
  int _currentLeagueIndex = 0; 

  // Getter para as ligas (usa as traduções)
  List<Map<String, dynamic>> get _leagues => [
        {'name': t.leaderboard.leagues.wood, 'color': const Color(0xFF8D6E63), 'icon': Icons.nature},
        {'name': t.leaderboard.leagues.iron, 'color': const Color(0xFF78909C), 'icon': Icons.gavel},
        {'name': t.leaderboard.leagues.bronze, 'color': const Color.fromARGB(255, 193, 83, 49), 'icon': Icons.shield_outlined},
        {'name': t.leaderboard.leagues.silver, 'color': const Color(0xFF90A4AE), 'icon': Icons.shield},
        {'name': t.leaderboard.leagues.gold, 'color': const Color(0xFFFFC107), 'icon': Icons.shield},
        {'name': t.leaderboard.leagues.platinum, 'color': const Color(0xFF00BCD4), 'icon': Icons.diamond_outlined},
        {'name': t.leaderboard.leagues.diamond, 'color': const Color(0xFF2979FF), 'icon': Icons.diamond},
        {'name': t.leaderboard.leagues.obsidian, 'color': const Color(0xFF311B92), 'icon': Icons.hexagon},
        {'name': t.leaderboard.leagues.master, 'color': const Color(0xFFD500F9), 'icon': Icons.auto_awesome},
        {'name': t.leaderboard.leagues.stellar, 'color': const Color(0xFF00E676), 'icon': Icons.stars},
        {'name': t.leaderboard.leagues.legend, 'color': const Color(0xFFFF3D00), 'icon': Icons.local_fire_department},
      ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.18,
      initialPage: 0, 
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
    
    // Obtém o ID do usuário atual de forma segura
    final currentUserState = ref.watch(currentUserProvider);
    final currentUserId = currentUserState.valueOrNull?.uid;

    final leaguesList = _leagues;

    return Scaffold(
      appBar: AppBar(title: Text(t.leaderboard.title)),
      body: board.when(
        data: (originalList) {
          // 1. Encontrar o usuário atual para descobrir sua liga
          // Se não achar (erro ou loading), assume a primeira liga (Madeira)
          final me = originalList.firstWhere(
            (e) => e.userId == currentUserId,
            orElse: () => originalList.isNotEmpty 
                ? originalList.first 
                : const LeaderboardEntry(userId: '', name: '', totalXp: 0, weeklyXp: 0, level: 1, leagueTier: 0),
          );

          final myLeagueIndex = me.leagueTier;

          // 2. Atualizar o controlador do PageView apenas se mudou
          // Isso garante que o carrossel foque na liga correta
          if (_currentLeagueIndex != myLeagueIndex) {
             _currentLeagueIndex = myLeagueIndex;
             WidgetsBinding.instance.addPostFrameCallback((_) {
               if (_pageController.hasClients) {
                 _pageController.jumpToPage(myLeagueIndex);
               }
             });
          }

          // 3. Filtrar e Ordenar:
          // Mostra apenas usuários da MESMA liga que você
          final leagueUsers = originalList.where((e) => e.leagueTier == myLeagueIndex).toList();
          
          // Ordena pelo XP SEMANAL (Esforço atual)
          final sortedList = List<LeaderboardEntry>.from(leagueUsers)
            ..sort((a, b) => b.weeklyXp.compareTo(a.weeklyXp));

          return Column(
            children: [
              // --- CARROSSEL DE LIGAS ---
              SizedBox(
                height: 150,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: leaguesList.length,
                  itemBuilder: (context, index) {
                    // Ligas acima da atual aparecem "bloqueadas" visualmente
                    final isLocked = index > myLeagueIndex;
                    
                    return AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        double value = 1.0;
                        if (_pageController.position.haveDimensions) {
                          value = _pageController.page! - index;
                          value = (1 - (value.abs() * 0.4)).clamp(0.0, 1.0);
                        } else {
                          value = index == myLeagueIndex ? 1.0 : 0.6;
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
                      child: _buildLeagueItem(leaguesList[index], isLocked),
                    );
                  },
                ),
              ),

              // --- LISTA DE CLASSIFICAÇÃO ---
              Expanded(
                child: sortedList.isEmpty 
                  ? Center(child: Text(t.common.empty_list)) 
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: sortedList.length,
                      itemBuilder: (_, i) {
                        final e = sortedList[i];
                        final position = i + 1;

                        // Lógica para destacar o próprio usuário
                        final isMe = currentUserId != null && e.userId == currentUserId;

                        // Zonas de Promoção/Rebaixamento (Regra: Top 5 sobem, Bottom 5 descem)
                        // Ajuste conforme sua regra de negócio (ex: top 3, bottom 3)
                        final bool showPromoLineBelow = i == 4 && myLeagueIndex < leaguesList.length - 1; 
                        final bool showDemotionLineAbove = sortedList.length > 5 && i == sortedList.length - 5 && myLeagueIndex > 0;

                        return Column(
                          children: [
                            if (showDemotionLineAbove)
                              _buildZoneDivider(t.leaderboard.zones.demotion,
                                  Colors.redAccent, Icons.arrow_downward),
                            
                            Container(
                              // Destaque visual se for o usuário logado
                              decoration: isMe
                                  ? BoxDecoration(
                                      color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.2),
                                      border: Border(
                                        left: BorderSide(
                                          color: Theme.of(context).colorScheme.primary,
                                          width: 4,
                                        ),
                                      ),
                                    )
                                  : null,
                              child: ListTile(
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
                                      backgroundColor: isMe
                                          ? Theme.of(context).colorScheme.primary
                                          : Colors.deepPurple.shade50,
                                      child: Icon(
                                        Icons.person,
                                        color: isMe
                                            ? Colors.white
                                            : Colors.deepPurple.shade300,
                                      ),
                                    ),
                                  ],
                                ),
                                title: Text(
                                  isMe ? '${e.name} (Você)' : e.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  // Mostra Nível global, mas ordena por XP Semanal
                                  t.leaderboard.entry.level(level: e.level),
                                ),
                                trailing: Text(
                                  // Exibe XP SEMANAL
                                  t.leaderboard.entry.xp(value: e.weeklyXp),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),

                            if (showPromoLineBelow)
                              _buildZoneDivider(t.leaderboard.zones.promotion,
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
        error: (e, st) => Center(child: Text(t.leaderboard.error)),
      ),
    );
  }

  // --- WIDGETS AUXILIARES ---

  Widget _buildZoneDivider(String text, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: Divider(color: color.withValues(alpha: 0.5), thickness: 1)),
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
          Expanded(child: Divider(color: color.withValues(alpha: 0.5), thickness: 1)),
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