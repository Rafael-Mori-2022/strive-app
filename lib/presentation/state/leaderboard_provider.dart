import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/data/repositories/firestore_leaderboard_repository.dart';
import 'package:strive/domain/entities/leaderboard_entry.dart';
import 'package:strive/domain/repositories/leaderboard_repository.dart';
import 'package:strive/providers/auth_providers.dart'; 

final leaderboardRepositoryProvider = Provider<LeaderboardRepository>((ref) {
  return FirestoreLeaderboardRepository(FirebaseFirestore.instance);
});

final leaderboardProvider = FutureProvider<List<LeaderboardEntry>>((ref) async {
  final repository = ref.watch(leaderboardRepositoryProvider);
  return repository.getLeaderboard();
});

final myRankProvider = Provider.autoDispose<int?>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  final leaderboardAsync = ref.watch(leaderboardProvider);

  final user = userAsync.whenOrNull(data: (u) => u);
  final leaderboard = leaderboardAsync.whenOrNull(data: (l) => l);

  if (user == null || leaderboard == null) return null;

  final index =
      leaderboard.indexWhere((entry) => entry.userId == user.uid);

  if (index == -1) return null;
  return index + 1;
});