import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strive/domain/entities/food_item.dart';
import 'package:strive/domain/entities/meal.dart';
import 'package:strive/domain/repositories/nutrition_repository.dart';
import 'package:strive/i18n/strings.g.dart'; 

class NutritionRepositoryImpl implements NutritionRepository {
  static const String _kMealsKey = 'daily_meals_data';
  static const String _kDateKey = 'daily_meals_date';

  // Estrutura inicial 
  Map<String, Meal> _meals = {
    'm1': const Meal(id: 'm1', name: 'Placeholder', items: []),
    'm2': const Meal(id: 'm2', name: 'Placeholder', items: []),
    'm3': const Meal(id: 'm3', name: 'Placeholder', items: []),
    'm4': const Meal(id: 'm4', name: 'Placeholder', items: []),
  };

  // Flag para saber se já carregamos do disco
  bool _isLoaded = false;

  // --- Métodos auxiliares de persistência ---

  Future<void> _loadFromPrefs() async {
    if (_isLoaded) return;

    final prefs = await SharedPreferences.getInstance();
    final lastDate = prefs.getString(_kDateKey);
    final today = DateTime.now().toIso8601String().split('T')[0];

    // Se a data mudou, não carrega nada - padrão vazio
    if (lastDate != today) {
      await prefs.setString(_kDateKey, today);
      await prefs.remove(_kMealsKey); // Limpa dados velhos
      _isLoaded = true;
      return;
    }

    // Se é o mesmo dia, carrega os dados
    final jsonString = prefs.getString(_kMealsKey);
    if (jsonString != null) {
      try {
        final Map<String, dynamic> decoded = json.decode(jsonString);
        // Reconstrói o mapa de refeições
        decoded.forEach((key, value) {
          if (_meals.containsKey(key)) {
             final itemsList = (value['items'] as List).map((i) => FoodItem(
               id: i['id'],
               name: i['name'],
               calories: (i['calories'] as num).toDouble(),
               protein: (i['protein'] as num).toDouble(),
               carbs: (i['carbs'] as num).toDouble(),
               fat: (i['fat'] as num).toDouble(),
               imageUrl: i['imageUrl'],
             )).toList();

             _meals[key] = _meals[key]!.copyWith(items: itemsList);
          }
        });
      } catch (e) {
        print("Erro ao carregar refeições: $e");
      }
    }
    _isLoaded = true;
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Converte o mapa de meals para JSON
    final Map<String, dynamic> dataToSave = {};
    _meals.forEach((key, meal) {
      dataToSave[key] = {
        'id': meal.id,
        'items': meal.items.map((i) => {
          'id': i.id,
          'name': i.name,
          'calories': i.calories,
          'protein': i.protein,
          'carbs': i.carbs,
          'fat': i.fat,
          'imageUrl': i.imageUrl,
        }).toList(),
      };
    });

    await prefs.setString(_kMealsKey, json.encode(dataToSave));
    
    // Garante que a data está atualizada
    final today = DateTime.now().toIso8601String().split('T')[0];
    await prefs.setString(_kDateKey, today);
  }

  // --- Tradução ---
  String _getLocalizedName(String id) {
    switch (id) {
      case 'm1': return t.diet.meal_types.breakfast;
      case 'm2': return t.diet.meal_types.lunch;
      case 'm3': return t.diet.meal_types.snack;
      case 'm4': return t.diet.meal_types.dinner;
      default: return 'Refeição';
    }
  }

  // --- API ---
  @override
  Future<List<FoodItem>> searchFoods(String query) async {
    if (query.isEmpty) return [];
    final url = Uri.parse('https://world.openfoodfacts.org/cgi/search.pl?search_terms=$query&search_simple=1&action=process&json=1&page_size=20');
    
    try {
      final response = await http.get(url, headers: {'User-Agent': 'StriveApp - Android - Version 1.0'});
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
        throw Exception('${t.add_food.error_api}: ${response.statusCode}');
      }
    } catch (e) {
      return [];
    }
  }

  // --- Gestão de Refeições ---

  @override
  Future<List<Meal>> getMealsOfDay() async {
    await _loadFromPrefs(); 
    return _meals.values.map((m) {
      return m.copyWith(name: _getLocalizedName(m.id));
    }).toList();
  }

  @override
  Future<Meal> getMealById(String id) async {
    await _loadFromPrefs();
    final meal = _meals[id]!;
    return meal.copyWith(name: _getLocalizedName(id));
  }

  @override
  Future<void> addFoodToMeal(String mealId, FoodItem item) async {
    await _loadFromPrefs();
    final m = _meals[mealId];
    if (m == null) return;
    
    // Atualiza memória
    _meals[mealId] = m.copyWith(items: [...m.items, item]);
    
    // Persiste no disco
    await _saveToPrefs();
  }

  @override
  Future<void> removeFoodFromMeal(String mealId, String foodId) async {
    await _loadFromPrefs();
    final m = _meals[mealId];
    if (m == null) return;
    
    // Atualiza memória
    _meals[mealId] = m.copyWith(items: m.items.where((e) => e.id != foodId).toList());
    
    // Persiste no disco
    await _saveToPrefs();
  }

  @override
  Future<List<FoodItem>> favoriteFoods() async => [];
  @override
  Future<List<FoodItem>> frequentFoods() async => [];
  @override
  Future<List<FoodItem>> recentFoods() async => [];
}