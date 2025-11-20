import 'package:get_it/get_it.dart';
import 'package:strive/data/repositories/firestore_profile_repository.dart';
import 'package:strive/data/repositories/mock_explore_repository.dart';
import 'package:strive/data/repositories/mock_leaderboard_repository.dart';
import 'package:strive/data/repositories/mock_nutrition_repository.dart';
import 'package:strive/data/repositories/mock_stats_repository.dart';
import 'package:strive/data/repositories/mock_workout_repository.dart';
import 'package:strive/domain/repositories/explore_repository.dart';
import 'package:strive/domain/repositories/leaderboard_repository.dart';
import 'package:strive/domain/repositories/nutrition_repository.dart';
import 'package:strive/domain/repositories/profile_repository.dart';
import 'package:strive/domain/repositories/stats_repository.dart';
import 'package:strive/domain/repositories/workout_repository.dart';
import 'package:strive/services/auth_service.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final authService = AuthService();

  await authService.init();

  sl.registerSingleton<AuthService>(authService);
  sl.registerLazySingleton<ProfileRepository>(() => FirestoreProfileRepository());
  sl.registerLazySingleton<NutritionRepository>(
      () => MockNutritionRepository());
  sl.registerLazySingleton<WorkoutRepository>(() => MockWorkoutRepository());
  sl.registerLazySingleton<LeaderboardRepository>(
      () => MockLeaderboardRepository());
  sl.registerLazySingleton<ExploreRepository>(() => MockExploreRepository());
  sl.registerLazySingleton<StatsRepository>(() => MockStatsRepository());
}
