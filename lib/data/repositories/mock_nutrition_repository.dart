import 'dart:async';
import 'package:strive/domain/entities/food_item.dart';
import 'package:strive/domain/entities/meal.dart';
import 'package:strive/domain/repositories/nutrition_repository.dart';

class MockNutritionRepository implements NutritionRepository {
  final Map<String, Meal> _meals = {
    'm1': Meal(id: 'm1', name: 'Café da manhã', items: [
      const FoodItem(
          id: 'f1',
          name: 'Ovos mexidos (2)',
          calories: 180,
          protein: 12,
          carbs: 2,
          fat: 14),
      const FoodItem(
          id: 'f2',
          name: 'Pão integral (2 fatias)',
          calories: 130,
          protein: 7,
          carbs: 22,
          fat: 2.5),
    ]),
    'm2': const Meal(id: 'm2', name: 'Almoço', items: []),
    'm3': const Meal(id: 'm3', name: 'Lanche', items: []),
    'm4': const Meal(id: 'm4', name: 'Jantar', items: []),
  };

  final List<FoodItem> _catalog = const [
    FoodItem(
        id: 'c1',
        name: 'Peito de frango grelhado 100g',
        calories: 165,
        protein: 31,
        carbs: 0,
        fat: 3.6),
    FoodItem(
        id: 'c2',
        name: 'Arroz integral 100g',
        calories: 111,
        protein: 2.6,
        carbs: 23,
        fat: 0.9),
    FoodItem(
        id: 'c3',
        name: 'Banana',
        calories: 96,
        protein: 1.2,
        carbs: 27,
        fat: 0.3),
    FoodItem(
        id: 'c4',
        name: 'Iogurte natural 170g',
        calories: 100,
        protein: 10,
        carbs: 12,
        fat: 0),
    FoodItem(
        id: 'c5',
        name: 'Aveia 40g',
        calories: 150,
        protein: 5,
        carbs: 27,
        fat: 3),
  ];

  @override
  Future<void> addFoodToMeal(String mealId, FoodItem item) async {
    final m = _meals[mealId];
    if (m == null) return;
    _meals[mealId] = m.copyWith(items: [...m.items, item]);
  }

  @override
  Future<List<FoodItem>> favoriteFoods() async => _catalog.take(3).toList();

  @override
  Future<Meal> getMealById(String id) async => _meals[id]!;

  @override
  Future<List<Meal>> getMealsOfDay() async => _meals.values.toList();

  @override
  Future<List<FoodItem>> frequentFoods() async =>
      _catalog.reversed.take(3).toList();

  @override
  Future<List<FoodItem>> recentFoods() async => _catalog;

  @override
  Future<void> removeFoodFromMeal(String mealId, String foodId) async {
    final m = _meals[mealId];
    if (m == null) return;
    _meals[mealId] =
        m.copyWith(items: m.items.where((e) => e.id != foodId).toList());
  }

  @override
  Future<List<FoodItem>> searchFoods(String query) async {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return _catalog;
    return _catalog.where((f) => f.name.toLowerCase().contains(q)).toList();
  }
}
