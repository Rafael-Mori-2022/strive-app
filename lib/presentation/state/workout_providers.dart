import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/di/service_locator.dart';
import 'package:strive/domain/entities/exercise.dart';
import 'package:strive/domain/entities/workout.dart';
import 'package:strive/domain/repositories/workout_repository.dart';

final workoutRepositoryProvider =
    Provider<WorkoutRepository>((ref) => sl<WorkoutRepository>());

final workoutPlansProvider = FutureProvider<List<WorkoutPlan>>(
    (ref) async => ref.read(workoutRepositoryProvider).getWorkoutPlans());

final exercisesByMuscleProvider = FutureProvider.family<List<Exercise>, String>(
    (ref, muscle) async =>
        ref.read(workoutRepositoryProvider).listExercisesByMuscle(muscle));
