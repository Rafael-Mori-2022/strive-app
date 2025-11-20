class UserProfile {
  final String id;
  final String name;
  final String email;
  final int age;
  final double heightCm;
  final double weightKg;
  final String? gender;
  final String? goal;
  final int xp;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    this.gender,
    this.goal,
    this.xp = 0,
  });

  // Converte do formato do Firebase (Map) para o Objeto Dart
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      age: map['age']?.toInt() ?? 0,
      heightCm: (map['heightCm'] ?? 0).toDouble(),
      weightKg: (map['weightKg'] ?? 0).toDouble(),
      gender: map['gender'],
      goal: map['goal'],
      xp: map['xp']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
      'heightCm': heightCm,
      'weightKg': weightKg,
      'gender': gender,
      'goal': goal,
      'xp': xp,
    };
  }
}
