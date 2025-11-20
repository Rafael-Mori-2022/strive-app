import 'dart:async';
import 'package:strive/domain/entities/leaderboard_entry.dart';
import 'package:strive/domain/repositories/leaderboard_repository.dart';

class MockLeaderboardRepository implements LeaderboardRepository {
  @override
  Future<List<LeaderboardEntry>> getLeaderboard() async {
    return const [
      LeaderboardEntry(userId: '1', name: 'Alex', xp: 1957, level: 11),
      LeaderboardEntry(userId: '2', name: 'Marina', xp: 1341, level: 2),
      LeaderboardEntry(userId: '3', name: 'Rafa', xp: 1788, level: 13),
      LeaderboardEntry(userId: '4', name: 'Bruno', xp: 1012, level: 7),
      LeaderboardEntry(userId: '5', name: 'Lebron', xp: 1805, level: 67),
      LeaderboardEntry(userId: '6', name: 'James', xp: 1229, level: 2),
      LeaderboardEntry(userId: '7', name: 'Cristiano', xp: 1699, level: 1),
      LeaderboardEntry(userId: '8', name: 'Joao', xp: 802, level: 9),
      LeaderboardEntry(userId: '9', name: 'Ronaldo', xp: 1530, level: 17),
      LeaderboardEntry(userId: '10', name: 'Lionel', xp: 1916, level: 10),
      LeaderboardEntry(userId: '11', name: 'Messi', xp: 1104, level: 8),
      LeaderboardEntry(userId: '12', name: 'Martha', xp: 1753, level: 10),
      LeaderboardEntry(userId: '13', name: 'Laika', xp: 1477, level: 13),
      LeaderboardEntry(userId: '14', name: 'Turing', xp: 1990, level: 4),
      LeaderboardEntry(userId: '15', name: 'Berserker', xp: 1045, level: 5),
      LeaderboardEntry(userId: '16', name: 'Tasha', xp: 1836, level: 5),
      LeaderboardEntry(userId: '17', name: 'Pablo', xp: 1981, level: 13),
      LeaderboardEntry(userId: '18', name: 'Pedro', xp: 470, level: 8),
      LeaderboardEntry(userId: '19', name: 'Uniqua', xp: 1324, level: 17),
      LeaderboardEntry(userId: '20', name: 'Tyrone', xp: 1568, level: 27),
    ];
  }
}
