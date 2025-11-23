import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:strive/domain/entities/food_item.dart';
import 'package:strive/domain/entities/meal.dart';
import 'package:strive/domain/repositories/nutrition_repository.dart';

class NutritionRepositoryImpl implements NutritionRepository {
  // Simulação de persistência local (em memória por enquanto) para o MVP
  final Map<String, Meal> _meals = {
    'm1': const Meal(id: 'm1', name: 'Café da manhã', items: []),
    'm2': const Meal(id: 'm2', name: 'Almoço', items: []),
    'm3': const Meal(id: 'm3', name: 'Lanche', items: []),
    'm4': const Meal(id: 'm4', name: 'Jantar', items: []),
  };

  @override
  Future<List<FoodItem>> searchFoods(String query) async {
    if (query.isEmpty) return [];

    // API OpenFoodFacts
    final url = Uri.parse(
        'https://world.openfoodfacts.org/cgi/search.pl?search_terms=$query&search_simple=1&action=process&json=1&page_size=20');

    try {
      final response = await http.get(
        url,
        headers: {'User-Agent': 'StriveApp - Android - Version 1.0'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final products = data['products'] as List;

        return products.map((p) {
          // Tratamento seguro de nulos
          final nutriments = p['nutriments'] ?? {};
          
          return FoodItem(
            id: p['code'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
            name: p['product_name'] ?? 'Produto desconhecido',
            // URL da imagem (pode ser null, trataremos na UI)
            imageUrl: p['image_front_small_url'], 
            calories: (nutriments['energy-kcal_100g'] ?? 0).toDouble(),
            protein: (nutriments['proteins_100g'] ?? 0).toDouble(),
            carbs: (nutriments['carbohydrates_100g'] ?? 0).toDouble(),
            fat: (nutriments['fat_100g'] ?? 0).toDouble(),
          );
        }).toList();
      } else {
        throw Exception('Erro na API: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar alimentos: $e');
      return [];
    }
  }

  @override
  Future<void> addFoodToMeal(String mealId, FoodItem item) async {
    final m = _meals[mealId];
    if (m == null) return;
    // Adiciona o item à lista existente
    _meals[mealId] = m.copyWith(items: [...m.items, item]);
  }

  @override
  Future<Meal> getMealById(String id) async => _meals[id]!;

  @override
  Future<List<Meal>> getMealsOfDay() async => _meals.values.toList();

  // Para o MVP, removeFood apenas remove da lista local
  @override
  Future<void> removeFoodFromMeal(String mealId, String foodId) async {
    final m = _meals[mealId];
    if (m == null) return;
    _meals[mealId] =
        m.copyWith(items: m.items.where((e) => e.id != foodId).toList());
  }

  // Mocks para listas rápidas (já que a API não tem "favoritos do usuário")
  @override
  Future<List<FoodItem>> favoriteFoods() async => [];
  @override
  Future<List<FoodItem>> frequentFoods() async => [];
  @override
  Future<List<FoodItem>> recentFoods() async => [];
}