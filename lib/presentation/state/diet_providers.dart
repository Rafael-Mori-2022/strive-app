import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/di/service_locator.dart';
import 'package:strive/domain/entities/food_item.dart';
import 'package:strive/domain/entities/meal.dart';
import 'package:strive/domain/repositories/nutrition_repository.dart';

final nutritionRepositoryProvider =
    Provider<NutritionRepository>((ref) => sl<NutritionRepository>());

final mealsProvider = FutureProvider<List<Meal>>(
    (ref) async => ref.read(nutritionRepositoryProvider).getMealsOfDay());

final mealDetailProvider = FutureProvider.family<Meal, String>(
    (ref, id) async => ref.read(nutritionRepositoryProvider).getMealById(id));

final searchFoodsProvider = FutureProvider.family<List<FoodItem>, String>(
    (ref, query) async =>
        ref.read(nutritionRepositoryProvider).searchFoods(query));

final frequentFoodsProvider = FutureProvider<List<FoodItem>>(
    (ref) async => ref.read(nutritionRepositoryProvider).frequentFoods());
final recentFoodsProvider = FutureProvider<List<FoodItem>>(
    (ref) async => ref.read(nutritionRepositoryProvider).recentFoods());
final favoriteFoodsProvider = FutureProvider<List<FoodItem>>(
    (ref) async => ref.read(nutritionRepositoryProvider).favoriteFoods());
