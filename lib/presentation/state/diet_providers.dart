import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/domain/entities/food_item.dart';
import 'package:strive/domain/entities/meal.dart';
import 'package:strive/domain/repositories/nutrition_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:strive/i18n/strings.g.dart';

// --- REPOSITÓRIOS E BUSCA ---

final nutritionRepositoryProvider = Provider<NutritionRepository>((ref) {
  return GetIt.instance<NutritionRepository>();
});

final searchFoodsProvider =
    FutureProvider.family<List<FoodItem>, String>((ref, query) async {
  final repository = ref.watch(nutritionRepositoryProvider);
  if (query.isEmpty) return [];
  return repository.searchFoods(query);
});

// --- REFEIÇÕES (MEALS) ---

class MealsNotifier extends AsyncNotifier<List<Meal>> {
  @override
  Future<List<Meal>> build() async {
    final repository = ref.read(nutritionRepositoryProvider);
    return repository.getMealsOfDay();
  }

  Future<void> addFood(String mealId, FoodItem item) async {
    final repository = ref.read(nutritionRepositoryProvider);
    await repository.addFoodToMeal(mealId, item);
    ref.invalidateSelf();
    await future;
  }

  Future<void> removeFood(String mealId, String foodId) async {
    final repository = ref.read(nutritionRepositoryProvider);
    await repository.removeFoodFromMeal(mealId, foodId);
    ref.invalidateSelf();
  }
}

final mealsProvider = AsyncNotifierProvider<MealsNotifier, List<Meal>>(() {
  return MealsNotifier();
});

final mealDetailProvider =
    Provider.family<AsyncValue<Meal>, String>((ref, mealId) {
  final mealsState = ref.watch(mealsProvider);
  return mealsState.whenData((meals) {
    return meals.firstWhere(
      (m) => m.id == mealId,
      orElse: () => Meal(id: mealId, name: t.diet.meal.not_found, items: []),
    );
  });
});

// --- LISTAS RÁPIDAS ---

final frequentFoodsProvider = FutureProvider((ref) async {
  return ref.watch(nutritionRepositoryProvider).frequentFoods();
});

final recentFoodsProvider = FutureProvider((ref) async {
  return ref.watch(nutritionRepositoryProvider).recentFoods();
});

final favoriteFoodsProvider = FutureProvider((ref) async {
  return ref.watch(nutritionRepositoryProvider).favoriteFoods();
});


// --- ÁGUA (CORRIGIDO COM ASYNC NOTIFIER) ---

// 1. Consumo de Água
class WaterIntakeNotifier extends AsyncNotifier<int> {
  static const _keyVolume = 'water_volume';
  static const _keyDate = 'water_date';

  @override
  Future<int> build() async {
    // Carregamento inicial assíncrono SEGURO
    final prefs = await SharedPreferences.getInstance();
    final lastDateStr = prefs.getString(_keyDate);
    final todayStr = DateTime.now().toIso8601String().split('T')[0];

    // Se mudou o dia, reseta
    if (lastDateStr != todayStr) {
      await prefs.setString(_keyDate, todayStr);
      await prefs.setInt(_keyVolume, 0);
      return 0;
    }
    
    // Retorna o valor salvo ou 0
    return prefs.getInt(_keyVolume) ?? 0;
  }

  Future<void> updateVolume(int newVolume) async {
    // Atualiza estado local otimisticamente
    state = AsyncData(newVolume);
    
    // Salva no disco
    final prefs = await SharedPreferences.getInstance();
    final todayStr = DateTime.now().toIso8601String().split('T')[0];
    
    await prefs.setInt(_keyVolume, newVolume);
    await prefs.setString(_keyDate, todayStr);
  }
}

final waterIntakeProvider = AsyncNotifierProvider<WaterIntakeNotifier, int>(WaterIntakeNotifier.new);


// 2. Meta de Água
class WaterGoalNotifier extends AsyncNotifier<int> {
  static const _keyGoal = 'water_goal';

  @override
  Future<int> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyGoal) ?? 3000; // Padrão 3000ml
  }

  Future<void> setGoal(int newGoal) async {
    state = AsyncData(newGoal);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyGoal, newGoal);
  }
}

final waterGoalProvider = AsyncNotifierProvider<WaterGoalNotifier, int>(WaterGoalNotifier.new);

// 3. Stepper de Água (Não precisa de persistência complexa, StateProvider basta, ou Async se quiser salvar)
final waterStepperProvider = StateProvider<int>((ref) => 250);