import 'package:get_it/get_it.dart';
import 'package:vigorbloom/data/repositories/mock_explore_repository.dart';
import 'package:vigorbloom/data/repositories/mock_leaderboard_repository.dart';
import 'package:vigorbloom/data/repositories/mock_nutrition_repository.dart';
import 'package:vigorbloom/data/repositories/mock_profile_repository.dart';
import 'package:vigorbloom/data/repositories/mock_stats_repository.dart';
import 'package:vigorbloom/data/repositories/mock_workout_repository.dart';
import 'package:vigorbloom/domain/repositories/explore_repository.dart';
import 'package:vigorbloom/domain/repositories/leaderboard_repository.dart';
import 'package:vigorbloom/domain/repositories/nutrition_repository.dart';
import 'package:vigorbloom/domain/repositories/profile_repository.dart';
import 'package:vigorbloom/domain/repositories/stats_repository.dart';
import 'package:vigorbloom/domain/repositories/workout_repository.dart';
import 'package:vigorbloom/services/auth_service.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final authService = AuthService();

  await authService.init();

  sl.registerSingleton<AuthService>(authService);
  sl.registerLazySingleton<ProfileRepository>(() => MockProfileRepository());
  sl.registerLazySingleton<NutritionRepository>(() => MockNutritionRepository());
  sl.registerLazySingleton<WorkoutRepository>(() => MockWorkoutRepository());
  sl.registerLazySingleton<LeaderboardRepository>(() => MockLeaderboardRepository());
  sl.registerLazySingleton<ExploreRepository>(() => MockExploreRepository());
  sl.registerLazySingleton<StatsRepository>(() => MockStatsRepository());
}
