import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/presentation/state/diet_providers.dart';
import 'package:strive/i18n/strings.g.dart'; // Importação do Slang

class MealDetailScreen extends ConsumerWidget {
  final String mealId;
  const MealDetailScreen({super.key, required this.mealId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meal = ref.watch(mealDetailProvider(mealId));
    return Scaffold(
      // Título da AppBar
      appBar: AppBar(title: Text(t.meal_detail.title)),
      body: meal.when(
        data: (m) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(m.name, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            // Resumo de Macros (Cabeçalho)
            Text(t.meal_detail.macro_summary(
                calories: m.calories.toStringAsFixed(0),
                protein: m.protein.toStringAsFixed(0),
                carbs: m.carbs.toStringAsFixed(0),
                fat: m.fat.toStringAsFixed(0))),
            const SizedBox(height: 12),
            ...m.items.map((item) => Card(
                child: ListTile(
                    title: Text(item.name),
                    // Detalhes do Item (Lista)
                    subtitle: Text(t.meal_detail.item_details(
                        calories: item.calories.toStringAsFixed(0),
                        protein: item.protein, // Mantido original (sem asFixed)
                        carbs: item.carbs, // Mantido original
                        fat: item.fat // Mantido original
                        ))))),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        // Mensagem de erro reutilizada
        error: (e, st) => Center(child: Text(t.common.error)),
      ),
    );
  }
}
