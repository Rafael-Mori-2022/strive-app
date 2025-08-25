import 'package:vigorbloom/domain/entities/exercise.dart';

class WorkoutPlan {
  final String id;
  final String name;
  final List<Exercise> exercises;
  const WorkoutPlan({required this.id, required this.name, required this.exercises});

  WorkoutPlan copyWith({String? name, List<Exercise>? exercises}) => WorkoutPlan(id: id, name: name ?? this.name, exercises: exercises ?? this.exercises);
}
