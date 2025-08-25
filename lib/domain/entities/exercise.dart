class Exercise {
  final String id;
  final String name;
  final String muscleGroup;
  final String details;
  final bool completed;
  const Exercise({required this.id, required this.name, required this.muscleGroup, required this.details, this.completed = false});

  Exercise toggleComplete() => Exercise(id: id, name: name, muscleGroup: muscleGroup, details: details, completed: !completed);
}
