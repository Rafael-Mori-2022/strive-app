import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/domain/entities/food_item.dart';
import 'package:strive/domain/entities/meal.dart';
import 'package:strive/domain/repositories/nutrition_repository.dart';
import 'package:get_it/get_it.dart';

// 1. Provider para acessar o Repositório (Pega do GetIt)
final nutritionRepositoryProvider = Provider<NutritionRepository>((ref) {
  return GetIt.instance<NutritionRepository>();
});

// 2. Provider de Busca (Conectado à API Real)
final searchFoodsProvider = FutureProvider.family<List<FoodItem>, String>((ref, query) async {
  final repository = ref.watch(nutritionRepositoryProvider);
  // Se a query for vazia, não busca nada (ou retorna lista vazia)
  if (query.isEmpty) return [];
  return repository.searchFoods(query);
});

// 3. Controller das Refeições (Gerencia o Estado da Dieta)
// Este Notifier mantém a lista de refeições atualizada na tela.
class MealsNotifier extends AsyncNotifier<List<Meal>> {
  
  // Carrega os dados iniciais
  @override
  Future<List<Meal>> build() async {
    final repository = ref.read(nutritionRepositoryProvider);
    return repository.getMealsOfDay();
  }

  // Adiciona comida e atualiza a tela
  Future<void> addFood(String mealId, FoodItem item) async {
    final repository = ref.read(nutritionRepositoryProvider);
    
    // 1. Salva no repositório
    await repository.addFoodToMeal(mealId, item);
    
    // 2. Força o Riverpod a recarregar a lista de refeições (Refresh na UI)
    ref.invalidateSelf();
    await future; // Aguarda o reload terminar
  }

  // Remove comida e atualiza a tela
  Future<void> removeFood(String mealId, String foodId) async {
    final repository = ref.read(nutritionRepositoryProvider);
    await repository.removeFoodFromMeal(mealId, foodId);
    ref.invalidateSelf();
  }
}

// O Provider que a tela DietScreen vai "assistir" (watch)
final mealsProvider = AsyncNotifierProvider<MealsNotifier, List<Meal>>(() {
  return MealsNotifier();
});

// 4. Provider para Detalhes de uma Refeição Específica
// (Filtra a lista principal para achar a refeição correta)
final mealDetailProvider = Provider.family<AsyncValue<Meal>, String>((ref, mealId) {
  final mealsState = ref.watch(mealsProvider);
  
  return mealsState.whenData((meals) {
    return meals.firstWhere(
      (m) => m.id == mealId,
      orElse: () => Meal(id: mealId, name: 'Não encontrada', items: []),
    );
  });
});

// 5. Providers auxiliares para listas rápidas (apenas wrappers do repo)
final frequentFoodsProvider = FutureProvider((ref) async {
  return ref.watch(nutritionRepositoryProvider).frequentFoods();
});

final recentFoodsProvider = FutureProvider((ref) async {
  return ref.watch(nutritionRepositoryProvider).recentFoods();
});

final favoriteFoodsProvider = FutureProvider((ref) async {
  return ref.watch(nutritionRepositoryProvider).favoriteFoods();
});

final waterIntakeProvider = StateProvider<int>((ref) => 0);

// Meta diária (em ml)
final waterGoalProvider = StateProvider<int>((ref) => 3000);

// Valor do incremento (Stepper) - Padrão 250ml, mas editável
final waterStepperProvider = StateProvider<int>((ref) => 250);