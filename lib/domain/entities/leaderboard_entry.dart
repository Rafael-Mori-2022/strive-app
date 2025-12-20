class LeaderboardEntry {
  final String userId;
  final String name;
  final int totalXp; 
  final int weeklyXp; 
  final int level;
  final int leagueTier; 

  const LeaderboardEntry({
    required this.userId,
    required this.name,
    required this.totalXp,
    required this.weeklyXp,
    required this.level,
    required this.leagueTier,
  });
}