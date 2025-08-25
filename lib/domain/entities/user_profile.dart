class UserProfile {
  final String id;
  final String name;
  final int age;
  final double heightCm;
  final double weightKg;
  final String goal; // e.g., Lose fat, Gain muscle
  final int xp;
  const UserProfile({required this.id, required this.name, required this.age, required this.heightCm, required this.weightKg, required this.goal, required this.xp});

  UserProfile copyWith({String? name, int? age, double? heightCm, double? weightKg, String? goal, int? xp}) => UserProfile(
    id: id,
    name: name ?? this.name,
    age: age ?? this.age,
    heightCm: heightCm ?? this.heightCm,
    weightKg: weightKg ?? this.weightKg,
    goal: goal ?? this.goal,
    xp: xp ?? this.xp,
  );
}
