import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/presentation/state/diet_providers.dart';

class MealDetailScreen extends ConsumerWidget {
  final String mealId;
  const MealDetailScreen({super.key, required this.mealId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meal = ref.watch(mealDetailProvider(mealId));
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da Refeição')),
      body: meal.when(
        data: (m) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(m.name, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
                '${m.calories.toStringAsFixed(0)} kcal • P ${m.protein.toStringAsFixed(0)}g • C ${m.carbs.toStringAsFixed(0)}g • G ${m.fat.toStringAsFixed(0)}g'),
            const SizedBox(height: 12),
            ...m.items.map((item) => Card(
                child: ListTile(
                    title: Text(item.name),
                    subtitle: Text(
                        '${item.calories.toStringAsFixed(0)} kcal - P ${item.protein}g C ${item.carbs}g G ${item.fat}g')))),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => const Center(child: Text('Erro ao carregar')),
      ),
    );
  }
}
