import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vigorbloom/domain/entities/meal.dart';
import 'package:vigorbloom/presentation/state/diet_providers.dart';
import 'package:vigorbloom/presentation/widgets/common_widgets.dart';

class DietScreen extends ConsumerWidget {
  const DietScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meals = ref.watch(mealsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Dieta')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          _MacroWaterRow(),
          const SizedBox(height: 16),
          meals.when(
            data: (list) =>
                Column(children: list.map((m) => _MealCard(meal: m)).toList()),
            loading: () => const LinearProgressIndicator(),
            error: (e, st) => const Text('Erro ao carregar refeições'),
          ),
        ],
      ),
    );
  }
}

class _MacroWaterRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.withAlpha(50))),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Macronutrientes',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(children: [
              _Pill(text: 'P 95g', color: Colors.green),
              const SizedBox(width: 8),
              _Pill(text: 'C 180g', color: Colors.blue),
              const SizedBox(width: 8),
              _Pill(text: 'G 50g', color: Colors.orange),
            ])
          ]),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: scheme.primaryContainer),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Água', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            LinearProgressIndicator(
                minHeight: 10,
                value: 0.6,
                backgroundColor: Colors.white.withAlpha(50),
                valueColor: AlwaysStoppedAnimation(Colors.blue)),
            const SizedBox(height: 6),
            Text('1.8L / 3.0L', style: Theme.of(context).textTheme.labelMedium),
          ]),
        ),
      ),
    ]);
  }
}

class _MealCard extends ConsumerWidget {
  final Meal meal;
  const _MealCard({required this.meal});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ExpandableMealCard(
        title: meal.name,
        subtitle:
            '${meal.calories.toStringAsFixed(0)} kcal • P ${meal.protein.toStringAsFixed(0)}g • C ${meal.carbs.toStringAsFixed(0)}g • G ${meal.fat.toStringAsFixed(0)}g',
        onAdd: () => context.push('/diet/add-food'),
        children: [
          ...meal.items.map((item) => ListTile(
                title: Text(item.name),
                subtitle: Text(
                    '${item.calories.toStringAsFixed(0)} kcal - P ${item.protein}g C ${item.carbs}g G ${item.fat}g'),
                trailing: IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () => context.push('/diet/meal/${meal.id}')),
              )),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final Color color;
  const _Pill({required this.text, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: ShapeDecoration(
            color: color.withAlpha(50), shape: const StadiumBorder()),
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: color)));
  }
}
