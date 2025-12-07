import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:strive/domain/entities/food_item.dart';
import 'package:strive/domain/entities/meal.dart';
import 'package:strive/domain/repositories/nutrition_repository.dart';
import 'package:strive/i18n/strings.g.dart'; // <--- Importação essencial do Slang

class NutritionRepositoryImpl implements NutritionRepository {
  // Simulação de banco de dados local.
  // O "name" aqui é irrelevante, pois será substituído pelo _getLocalizedName
  final Map<String, Meal> _meals = {
    'm1': const Meal(id: 'm1', name: 'Placeholder', items: []),
    'm2': const Meal(id: 'm2', name: 'Placeholder', items: []),
    'm3': const Meal(id: 'm3', name: 'Placeholder', items: []),
    'm4': const Meal(id: 'm4', name: 'Placeholder', items: []),
  };

  // --- A GAMBIARRA DE TRADUÇÃO ---
  // Transforma IDs fixos em textos traduzidos dinamicamente
  String _getLocalizedName(String id) {
    switch (id) {
      case 'm1':
        return t.diet.meal_types.breakfast; // Café da Manhã
      case 'm2':
        return t.diet.meal_types.lunch; // Almoço
      case 'm3':
        return t.diet.meal_types.snack; // Lanche
      case 'm4':
        return t.diet.meal_types.dinner; // Jantar
      default:
        return 'Refeição';
    }
  }

  // --- Buscas na API ---
  @override
  Future<List<FoodItem>> searchFoods(String query) async {
    if (query.isEmpty) return [];

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
          final nutriments = p['nutriments'] ?? {};

          return FoodItem(
            id: p['code'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
            name: p['product_name'] ?? 'Produto desconhecido',
            imageUrl: p['image_front_small_url'],
            calories: (nutriments['energy-kcal_100g'] ?? 0).toDouble(),
            protein: (nutriments['proteins_100g'] ?? 0).toDouble(),
            carbs: (nutriments['carbohydrates_100g'] ?? 0).toDouble(),
            fat: (nutriments['fat_100g'] ?? 0).toDouble(),
          );
        }).toList();
      } else {
        // Usa a tradução de erro configurada
        throw Exception('${t.add_food.error_api}: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar alimentos: $e');
      return [];
    }
  }

  // --- Manipulação das Refeições (Com a Tradução Injetada) ---

  @override
  Future<List<Meal>> getMealsOfDay() async {
    // AQUI É O PULO DO GATO:
    // Percorre a lista e substitui o nome fixo pelo nome traduzido
    return _meals.values.map((m) {
      return m.copyWith(name: _getLocalizedName(m.id));
    }).toList();
  }

  @override
  Future<Meal> getMealById(String id) async {
    final meal = _meals[id]!;
    // Injeta o nome traduzido antes de retornar o detalhe
    return meal.copyWith(name: _getLocalizedName(id));
  }

  @override
  Future<void> addFoodToMeal(String mealId, FoodItem item) async {
    final m = _meals[mealId];
    if (m == null) return;
    _meals[mealId] = m.copyWith(items: [...m.items, item]);
  }

  @override
  Future<void> removeFoodFromMeal(String mealId, String foodId) async {
    final m = _meals[mealId];
    if (m == null) return;
    _meals[mealId] =
        m.copyWith(items: m.items.where((e) => e.id != foodId).toList());
  }

  // Mocks vazios
  @override
  Future<List<FoodItem>> favoriteFoods() async => [];
  @override
  Future<List<FoodItem>> frequentFoods() async => [];
  @override
  Future<List<FoodItem>> recentFoods() async => [];
}
