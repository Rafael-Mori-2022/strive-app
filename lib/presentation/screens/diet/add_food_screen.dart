import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/domain/entities/food_item.dart';
import 'package:strive/domain/enums/xp_action.dart';
import 'package:strive/presentation/state/diet_providers.dart';
import 'package:strive/presentation/state/gamification_provider.dart';

class AddFoodScreen extends ConsumerStatefulWidget {
  const AddFoodScreen({super.key});

  @override
  ConsumerState<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends ConsumerState<AddFoodScreen> {
  String _query = '';
  
  // Recupera o mealId da rota (query param)
  // Ex: /diet/add-food?mealId=m1
  String? get _mealId => GoRouterState.of(context).uri.queryParameters['mealId'];

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchFoodsProvider(_query));
    // Se não veio mealId, usa um fallback ou trata erro. 'm1' é Café da Manhã no mock/repo.
    final targetMealId = _mealId ?? 'm1'; 

    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Alimento')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            // Simplificado para TextField padrão para garantir compatibilidade
            child: TextField( 
              autofocus: true, // Abre o teclado automaticamente
              decoration: const InputDecoration(
                hintText: 'Busque ex: "Maçã", "Whey"...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: _query.isEmpty
                ? _buildEmptyState(context)
                : searchResults.when(
                    data: (list) => list.isEmpty
                        ? const Center(child: Text("Nenhum alimento encontrado"))
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
                                  // 1. Adiciona na dieta
                                  await ref
                                      .read(mealsProvider.notifier)
                                      .addFood(targetMealId, item);
                                  
                                  // 2. DA O XP (Gamificação!)
                                  if (context.mounted) {
                                    ref
                                        .read(gamificationControllerProvider)
                                        .earnXp(context, XpAction.addMeal);
                                    
                                    // 3. VOLTA PARA A DIETA (CORREÇÃO CRÍTICA)
                                    // O pop fecha a tela de Add e volta para DietScreen
                                    context.pop(); 
                                  }
                                },
                              );
                            },
                          ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, st) =>
                        const Center(child: Text('Erro na conexão com a API')),
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
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(
            "Digite para buscar na base de dados global",
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
                      errorBuilder: (_, __, ___) =>
                          Container(color: colors.surfaceVariant, child: const Icon(Icons.broken_image)),
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
                    style: TextStyle(color: colors.primary, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'P: ${item.protein.toStringAsFixed(1)} C: ${item.carbs.toStringAsFixed(1)} G: ${item.fat.toStringAsFixed(1)}',
                    style: TextStyle(color: colors.onSurfaceVariant, fontSize: 12),
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