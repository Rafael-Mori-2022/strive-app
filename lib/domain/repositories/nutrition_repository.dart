import 'package:strive/domain/entities/food_item.dart';
import 'package:strive/domain/entities/meal.dart';

abstract class NutritionRepository {
  Future<List<Meal>> getMealsOfDay();
  Future<Meal> getMealById(String id);
  Future<void> addFoodToMeal(String mealId, FoodItem item);
  Future<void> removeFoodFromMeal(String mealId, String foodId);
  Future<List<FoodItem>> searchFoods(String query);
  Future<List<FoodItem>> frequentFoods();
  Future<List<FoodItem>> recentFoods();
  Future<List<FoodItem>> favoriteFoods();
}
