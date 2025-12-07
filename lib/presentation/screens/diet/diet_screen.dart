import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/domain/entities/meal.dart';
import 'package:strive/presentation/state/diet_providers.dart';
import 'package:strive/presentation/state/gamification_provider.dart';
import 'package:strive/domain/enums/xp_action.dart';
import 'package:strive/i18n/strings.g.dart';

class DietScreen extends ConsumerWidget {
  const DietScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observa a lista de refeições
    final mealsAsync = ref.watch(mealsProvider);

    return Scaffold(
      backgroundColor:
          Theme.of(context).colorScheme.background, // Mantido original
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async {
            // Recarrega refeições e reseta estados se necessário
            ref.refresh(mealsProvider);
          },
          child: ListView(
            // Padding inferior grande para não ficar atrás da navbar flutuante
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            children: [
              const _Header(),
              const SizedBox(height: 16),

              // Card de Calorias (Calculado com base nas refeições)
              mealsAsync.when(
                data: (meals) => _CalorieMacroCard(meals: meals),
                loading: () => const _LoadingCard(height: 150),
                error: (_, __) => const SizedBox.shrink(),
              ),

              const SizedBox(height: 16),

              // Card de Água (Agora com Meta Editável)
              const _WaterCard(),

              const SizedBox(height: 16),

              // Lista de Refeições
              mealsAsync.when(
                data: (list) => ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final meal = list[index];
                    return _MealCard(meal: meal);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                ),
                loading: () => const LinearProgressIndicator(),
                error: (e, st) => Center(child: Text('${t.common.error}: $e')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        t.diet.title, // "Dieta"
        style: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

// --- CARD DE ÁGUA ATUALIZADO (META EDITÁVEL) ---
class _WaterCard extends ConsumerWidget {
  const _WaterCard();

  // Dialog para editar a Meta
  void _showEditGoalDialog(
      BuildContext context, WidgetRef ref, int currentGoal) {
    final controller =
        TextEditingController(text: (currentGoal / 1000).toString());
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.diet.water.edit_goal_title), // "Definir Meta de Água"
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))
          ],
          decoration: InputDecoration(
            labelText: t.diet.water.liters_label, // "Litros"
            suffixText: 'L',
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(t.common.cancel)),
          FilledButton(
            onPressed: () {
              final val = double.tryParse(controller.text.replaceAll(',', '.'));
              if (val != null && val > 0) {
                ref.read(waterGoalProvider.notifier).setGoal((val * 1000).toInt());
              }
              Navigator.pop(ctx);
            },
            child: Text(t.common.save),
          ),
        ],
      ),
    );
  }

  // Dialog para editar o Stepper (Quantidade por clique)
  void _showEditStepperDialog(
      BuildContext context, WidgetRef ref, int currentStep) {
    final controller = TextEditingController(text: currentStep.toString());
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.diet.water.edit_stepper_title), // "Quantidade por Clique"
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: t.diet.water.ml_label, // "Mililitros (ml)"
                suffixText: 'ml',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(t.common.cancel)),
          FilledButton(
            onPressed: () {
              final val = int.tryParse(controller.text);
              if (val != null && val > 0) {
                ref.read(waterStepperProvider.notifier).state = val;
              }
              Navigator.pop(ctx);
            },
            child: Text(t.common.save),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWaterAsync = ref.watch(waterIntakeProvider);
    final goalWaterAsync = ref.watch(waterGoalProvider);
    final stepperValue = ref.watch(waterStepperProvider); // Lê do provider

    final currentWater = currentWaterAsync.value ?? 0;
    final goalWater = goalWaterAsync.value ?? 3000;

    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final progress = (currentWater / goalWater).clamp(0.0, 1.0);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 4,
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation(Colors.blue.shade300),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                Icon(Icons.water_drop, color: Colors.blue.shade300, size: 32),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${(currentWater / 1000).toStringAsFixed(2)} L',
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () => _showEditGoalDialog(context, ref, goalWater),
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          children: [
                            Text(
                              // "Meta: X L"
                              t.diet.water.goal_display(
                                  value: (goalWater / 1000).toStringAsFixed(1)),
                              style: textTheme.bodySmall?.copyWith(
                                color: colors.onSurfaceVariant,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.dotted,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(Icons.edit,
                                size: 12, color: colors.onSurfaceVariant),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Controles
                Container(
                  decoration: BoxDecoration(
                    color: colors.surfaceVariant.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, size: 20),
                        onPressed: () {
                          final newVal =
                              (currentWater - stepperValue).clamp(0, 10000);
                          ref.read(waterIntakeProvider.notifier).updateVolume(newVal);
                        },
                      ),
                      // Valor do stepper agora é clicável para editar
                      InkWell(
                        onTap: () =>
                            _showEditStepperDialog(context, ref, stepperValue),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '$stepperValue ml',
                            style: textTheme.labelMedium?.copyWith(
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.dotted,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, size: 20),
                        onPressed: () {
                          final newVal =
                              (currentWater + stepperValue).clamp(0, 10000);
                          ref.read(waterIntakeProvider.notifier).updateVolume(newVal);
                          if (context.mounted) {
                            ref
                                .read(gamificationControllerProvider)
                                .earnXp(context, XpAction.addWater);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- CARD DE CALORIAS E MACROS (Mantido, apenas garantindo imports) ---
class _CalorieMacroCard extends StatelessWidget {
  final List<Meal> meals;
  const _CalorieMacroCard({required this.meals});

  @override
  Widget build(BuildContext context) {
    double totalCalories = 0;
    double totalCarbs = 0;
    double totalProtein = 0;
    double totalFat = 0;

    for (var meal in meals) {
      totalCalories += meal.calories;
      totalCarbs += meal.carbs;
      totalProtein += meal.protein;
      totalFat += meal.fat;
    }

    // Metas fixas para MVP (poderiam vir do userProfile)
    const double goalCalories = 2500;
    const double goalCarbs = 300;
    const double goalProtein = 160;
    const double goalFat = 70;

    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Anel de Progresso
            SizedBox(
              width: 110,
              height: 110,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: (totalCalories / goalCalories).clamp(0.0, 1.0),
                    strokeWidth: 8,
                    backgroundColor: colors.surfaceVariant,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.redAccent),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          totalCalories.toStringAsFixed(0),
                          style: textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'kcal',
                          style: textTheme.bodySmall
                              ?.copyWith(color: colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            // Barras de Macro
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _MacroBar(
                    title: t.diet.macros.carbs, // "Carboidrato"
                    value: totalCarbs,
                    goal: goalCarbs,
                    color: Colors.blue.shade400,
                  ),
                  const SizedBox(height: 12),
                  _MacroBar(
                    title: t.diet.macros.protein, // "Proteína"
                    value: totalProtein,
                    goal: goalProtein,
                    color: Colors.green.shade400,
                  ),
                  const SizedBox(height: 12),
                  _MacroBar(
                    title: t.diet.macros.fat, // "Gordura"
                    value: totalFat,
                    goal: goalFat,
                    color: Colors.orange.shade400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MacroBar extends StatelessWidget {
  const _MacroBar({
    required this.title,
    required this.value,
    required this.goal,
    required this.color,
  });

  final String title;
  final double value;
  final double goal;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final progress = (goal == 0) ? 0.0 : (value / goal).clamp(0.0, 1.0);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: textTheme.labelMedium),
            Text(
              '${value.toStringAsFixed(0)} / ${goal.toStringAsFixed(0)} g',
              style: textTheme.labelMedium?.copyWith(color: color),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 6,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}

// --- CARD DE REFEIÇÃO (Mantido) ---
class _MealCard extends ConsumerWidget {
  final Meal meal;
  const _MealCard({required this.meal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    IconData mainIcon = Icons.restaurant;
    if (meal.name.toLowerCase().contains('café'))
      mainIcon = Icons.bakery_dining;
    if (meal.name.toLowerCase().contains('lanche')) mainIcon = Icons.apple;
    if (meal.name.toLowerCase().contains('jantar'))
      mainIcon = Icons.dinner_dining;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/diet/add-food?mealId=${meal.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(mainIcon, color: colors.primary, size: 24),
                      const SizedBox(width: 12),
                      Text(meal.name,
                          style: textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add,
                        size: 20, color: colors.onPrimaryContainer),
                  )
                ],
              ),
              if (meal.items.isNotEmpty) ...[
                const Divider(height: 24),
                // Lista resumida dos itens
                ...meal.items.take(3).map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(item.name,
                                  style: textTheme.bodyMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis)),
                          Text('${item.calories.toStringAsFixed(0)} kcal',
                              style: textTheme.bodySmall
                                  ?.copyWith(color: colors.onSurfaceVariant)),
                        ],
                      ),
                    )),
                if (meal.items.length > 3)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      // "+ X outros itens"
                      t.diet.meal.more_items(count: meal.items.length - 3),
                      style:
                          textTheme.labelSmall?.copyWith(color: colors.primary),
                    ),
                  ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      // "Total: X kcal"
                      t.diet.meal.total_calories(
                          calories: meal.calories.toStringAsFixed(0)),
                      style: textTheme.labelMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ] else
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    t.diet.meal.empty, // "Nenhum alimento registrado"
                    style: textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic, color: colors.outline),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  final double height;
  const _LoadingCard({required this.height});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
