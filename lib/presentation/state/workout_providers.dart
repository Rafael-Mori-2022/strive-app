import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:strive/domain/entities/exercise.dart';
import 'package:strive/domain/entities/workout.dart';
import 'package:strive/domain/repositories/workout_repository.dart';

// Acesso ao Repositório
final workoutRepositoryProvider = Provider<WorkoutRepository>((ref) {
  return GetIt.instance<WorkoutRepository>();
});

// Lista de Planos 
final workoutPlansProvider = FutureProvider<List<WorkoutPlan>>((ref) async {
  final repo = ref.watch(workoutRepositoryProvider);
  return repo.getWorkoutPlans();
});

// Lista de Exercícios da API 
final exercisesByMuscleProvider = FutureProvider.family<List<Exercise>, String>((ref, muscle) async {
  final repo = ref.watch(workoutRepositoryProvider);
  return repo.listExercisesByMuscle(muscle);
});

// Controller para ações (Adicionar, Remover, Toggle)
final workoutControllerProvider = Provider((ref) => WorkoutController(ref));

class WorkoutController {
  final Ref _ref;
  WorkoutController(this._ref);

  Future<void> createPlan(String name) async {
    await _ref.read(workoutRepositoryProvider).createWorkout(name);
    _ref.refresh(workoutPlansProvider); 
  }

  Future<void> addExerciseToPlan(String planId, Exercise exercise) async {
    await _ref.read(workoutRepositoryProvider).addExercise(planId, exercise);
    _ref.refresh(workoutPlansProvider);
  }

  Future<void> toggleExercise(String planId, String exerciseId) async {
    await _ref.read(workoutRepositoryProvider).toggleExercise(planId, exerciseId);
    _ref.refresh(workoutPlansProvider);
  }

  Future<void> deletePlan(String planId) async {
    await _ref.read(workoutRepositoryProvider).deleteWorkout(planId);
    _ref.refresh(workoutPlansProvider);
  }

  Future<void> renamePlan(String planId, String newName) async {
    await _ref.read(workoutRepositoryProvider).updateWorkoutName(planId, newName);
    _ref.refresh(workoutPlansProvider);
  }

  Future<void> removeExerciseFromPlan(String planId, String exerciseId) async {
    await _ref.read(workoutRepositoryProvider).removeExercise(planId, exerciseId);
    _ref.refresh(workoutPlansProvider);
  }
}