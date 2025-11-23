class Exercise {
  final String id;
  final String name;
  final String muscleGroup;
  final String details; // Usado para séries/reps (ex: "4x12")
  final bool completed;
  final String? imageUrl; // <--- Novo: Imagem do exercício
  final String? description; // <--- Novo: Descrição técnica

  const Exercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    this.details = '',
    this.completed = false,
    this.imageUrl,
    this.description,
  });

  // Converter para Map (Salvar no Firebase)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'muscleGroup': muscleGroup,
      'details': details,
      'completed': completed,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  // Criar a partir de Map (Ler do Firebase)
  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      muscleGroup: map['muscleGroup'] ?? '',
      details: map['details'] ?? '',
      completed: map['completed'] ?? false,
      imageUrl: map['imageUrl'],
      description: map['description'],
    );
  }

  Exercise toggleComplete() {
    return Exercise(
      id: id,
      name: name,
      muscleGroup: muscleGroup,
      details: details,
      completed: !completed,
      imageUrl: imageUrl,
      description: description,
    );
  }
}