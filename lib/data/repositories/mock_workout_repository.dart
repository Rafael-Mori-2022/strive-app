import 'dart:async';
import 'package:vigorbloom/domain/entities/exercise.dart';
import 'package:vigorbloom/domain/entities/workout.dart';
import 'package:vigorbloom/domain/repositories/workout_repository.dart';

class MockWorkoutRepository implements WorkoutRepository {
  final Map<String, WorkoutPlan> _plans = {
    'p1': WorkoutPlan(id: 'p1', name: 'Push Day', exercises: [
      const Exercise(id: 'e1', name: 'Supino reto', muscleGroup: 'Peito', details: '4x8'),
      const Exercise(id: 'e2', name: 'Desenvolvimento', muscleGroup: 'Ombros', details: '3x10'),
    ]),
    'p2': WorkoutPlan(id: 'p2', name: 'Pull Day', exercises: [
      const Exercise(id: 'e3', name: 'Remada curvada', muscleGroup: 'Costas', details: '4x8'),
      const Exercise(id: 'e4', name: 'Barra fixa', muscleGroup: 'Costas', details: '3x até falha'),
    ]),
  };

  final List<Exercise> _catalog = const [
    Exercise(id: 'c1', name: 'Rosca Scott', muscleGroup: 'Bíceps', details: '3x10'),
    Exercise(id: 'c2', name: 'Rosca alternada', muscleGroup: 'Bíceps', details: '3x12'),
    Exercise(id: 'c3', name: 'Tríceps testa', muscleGroup: 'Tríceps', details: '3x10'),
    Exercise(id: 'c4', name: 'Agachamento livre', muscleGroup: 'Pernas', details: '4x8'),
  ];

  @override
  Future<void> addExercise(String planId, Exercise exercise) async {
    final p = _plans[planId];
    if (p == null) return;
    _plans[planId] = p.copyWith(exercises: [...p.exercises, exercise]);
  }

  @override
  Future<void> createWorkout(String name) async {
    final id = 'p${_plans.length + 1}';
    _plans[id] = WorkoutPlan(id: id, name: name, exercises: const []);
  }

  @override
  Future<List<WorkoutPlan>> getWorkoutPlans() async => _plans.values.toList();

  @override
  Future<List<Exercise>> listExercisesByMuscle(String muscleGroup) async => _catalog.where((e) => e.muscleGroup.toLowerCase() == muscleGroup.toLowerCase()).toList();

  @override
  Future<void> removeExercise(String planId, String exerciseId) async {
    final p = _plans[planId];
    if (p == null) return;
    _plans[planId] = p.copyWith(exercises: p.exercises.where((e) => e.id != exerciseId).toList());
  }

  @override
  Future<void> toggleExercise(String planId, String exerciseId) async {
    final p = _plans[planId];
    if (p == null) return;
    _plans[planId] = p.copyWith(exercises: p.exercises.map((e) => e.id == exerciseId ? e.toggleComplete() : e).toList());
  }
}
