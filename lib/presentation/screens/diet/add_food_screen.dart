import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/domain/entities/food_item.dart';
import 'package:strive/domain/enums/xp_action.dart';
import 'package:strive/presentation/state/diet_providers.dart';
import 'package:strive/presentation/state/gamification_provider.dart';
import 'package:strive/i18n/strings.g.dart'; 

class AddFoodScreen extends ConsumerStatefulWidget {
  const AddFoodScreen({super.key});

  @override
  ConsumerState<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends ConsumerState<AddFoodScreen> {
  String _query = '';

  // Recupera o mealId da rota (query param)
  String? get _mealId =>
      GoRouterState.of(context).uri.queryParameters['mealId'];

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchFoodsProvider(_query));
    final targetMealId = _mealId ?? 'm1';

    return Scaffold(
      appBar: AppBar(title: Text(t.add_food.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                // Hint de busca
                hintText: t.add_food.search_hint,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: _query.isEmpty
                ? _buildEmptyState(context)
                : searchResults.when(
                    data: (list) => list.isEmpty
                        // Estado vazio da busca
                        ? Center(child: Text(t.add_food.not_found))
                        : ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount: list.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (_, i) {
                              final item = list[i];
                              return _FoodItemCard(
                                item: item,
                                onAdd: () async {
                                  await ref
                                      .read(mealsProvider.notifier)
                                      .addFood(targetMealId, item);

                                  if (context.mounted) {
                                    ref
                                        .read(gamificationControllerProvider)
                                        .earnXp(context, XpAction.addMeal);

                                    context.pop();
                                  }
                                },
                              );
                            },
                          ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    // Erro de API
                    error: (e, st) => Center(child: Text(t.add_food.error_api)),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search,
              size: 64,
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withOpacity(0.3)),
          const SizedBox(height: 16),
          // Instrução inicial
          Text(
            t.add_food.instruction,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _FoodItemCard extends StatelessWidget {
  final FoodItem item;
  final VoidCallback onAdd;

  const _FoodItemCard({required this.item, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onAdd,
        child: Row(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: item.imageUrl != null
                  ? Image.network(
                      item.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                          color: colors.surfaceVariant,
                          child: const Icon(Icons.broken_image)),
                    )
                  : Container(
                      color: colors.surfaceVariant,
                      child: Icon(Icons.fastfood, color: colors.primary),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.calories.toStringAsFixed(0)} kcal',
                    style: TextStyle(
                        color: colors.primary, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  // Macros traduzidos (P/C/G)
                  Text(
                    '${t.add_food.macro_p}: ${item.protein.toStringAsFixed(1)} ${t.add_food.macro_c}: ${item.carbs.toStringAsFixed(1)} ${t.add_food.macro_f}: ${item.fat.toStringAsFixed(1)}',
                    style:
                        TextStyle(color: colors.onSurfaceVariant, fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add_circle, color: colors.secondary, size: 32),
            ),
          ],
        ),
      ),
    );
  }
}
