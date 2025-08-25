import 'package:vigorbloom/domain/entities/workout.dart';
import 'package:vigorbloom/domain/entities/exercise.dart';

abstract class WorkoutRepository {
  Future<List<WorkoutPlan>> getWorkoutPlans();
  Future<void> createWorkout(String name);
  Future<void> addExercise(String planId, Exercise exercise);
  Future<void> removeExercise(String planId, String exerciseId);
  Future<void> toggleExercise(String planId, String exerciseId);
  Future<List<Exercise>> listExercisesByMuscle(String muscleGroup);
}
