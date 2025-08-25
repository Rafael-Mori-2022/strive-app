import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigorbloom/di/service_locator.dart';
import 'package:vigorbloom/domain/entities/leaderboard_entry.dart';
import 'package:vigorbloom/domain/repositories/leaderboard_repository.dart';

final leaderboardRepositoryProvider = Provider<LeaderboardRepository>((ref) => sl<LeaderboardRepository>());

final leaderboardProvider = FutureProvider<List<LeaderboardEntry>>((ref) async => ref.read(leaderboardRepositoryProvider).getLeaderboard());
