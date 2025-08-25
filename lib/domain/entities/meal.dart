import 'package:vigorbloom/domain/entities/food_item.dart';

class Meal {
  final String id;
  final String name;
  final List<FoodItem> items;
  const Meal({required this.id, required this.name, required this.items});

  double get calories => items.fold(0, (p, e) => p + e.calories);
  double get protein => items.fold(0, (p, e) => p + e.protein);
  double get carbs => items.fold(0, (p, e) => p + e.carbs);
  double get fat => items.fold(0, (p, e) => p + e.fat);

  Meal copyWith({String? name, List<FoodItem>? items}) => Meal(id: id, name: name ?? this.name, items: items ?? this.items);
}
