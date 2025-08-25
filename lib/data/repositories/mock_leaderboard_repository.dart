import 'dart:async';
import 'package:vigorbloom/domain/entities/leaderboard_entry.dart';
import 'package:vigorbloom/domain/repositories/leaderboard_repository.dart';

class MockLeaderboardRepository implements LeaderboardRepository {
  @override
  Future<List<LeaderboardEntry>> getLeaderboard() async {
    return const [
      LeaderboardEntry(userId: '1', name: 'Alex', xp: 1890, rank: 1),
      LeaderboardEntry(userId: '2', name: 'Marina', xp: 1760, rank: 2),
      LeaderboardEntry(userId: '3', name: 'Rafa', xp: 1610, rank: 3),
      LeaderboardEntry(userId: '4', name: 'Bruno', xp: 1400, rank: 4),
    ];
  }
}
