import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vigorbloom/domain/entities/meal.dart';
import 'package:vigorbloom/presentation/state/diet_providers.dart';
// Removi a importação 'common_widgets.dart' pois o ExpandableMealCard
// foi substituído pelo design do protótipo.

class DietScreen extends ConsumerWidget {
  const DietScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meals = ref.watch(mealsProvider);

    return Scaffold(
      // 1. Removemos a AppBar
      // 2. Usamos a cor de fundo do tema
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        bottom: false,
        child: ListView(
          // 3. Padding ajustado para o layout
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            // 4. Header "Dieta"
            const _Header(),
            const SizedBox(height: 16),

            // 5. Novo Card de Calorias e Macros (do protótipo)
            const _CalorieMacroCard(),
            const SizedBox(height: 16),

            // 6. Novo Card de Água (do protótipo)
            const _WaterCard(),
            const SizedBox(height: 16),

            // 7. Lista de Refeições
            meals.when(
              data: (list) => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final meal = list[index];
                  return _MealCard(meal: meal);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
              ),
              loading: () => const LinearProgressIndicator(),
              error: (e, st) => const Text('Erro ao carregar refeições'),
            ),
            const SizedBox(height: 72), // Espaço para a bottom nav
          ],
        ),
      ),
    );
  }
}

// 4. Header "Dieta"
class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        'Dieta',
        style: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

// 5. Card de Calorias e Macros
class _CalorieMacroCard extends StatelessWidget {
  const _CalorieMacroCard();

  @override
  Widget build(BuildContext context) {
    // Você pode conectar seus providers aqui para
    // valores dinâmicos de calorias e macros
    const double caloriasConsumidas = 701;
    const double carboidratos = 70.1;
    const double proteinas = 16.7;
    const double gorduras = 28.6;

    // Metas (exemplo)
    const double metaCalorias = 2500;
    const double metaCarboidratos = 300;
    const double metaProteinas = 150;
    const double metaGorduras = 80;

    final textTheme = Theme.of(context).textTheme;

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
                    value: caloriasConsumidas / metaCalorias,
                    strokeWidth: 8,
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceVariant,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.redAccent),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          caloriasConsumidas.toStringAsFixed(0),
                          style: textTheme.headlineSmall,
                        ),
                        Text(
                          'calorias consumidas',
                          textAlign: TextAlign.center,
                          style: textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Barras de Macro
            Expanded(
              child: Column(
                children: [
                  _MacroBar(
                    title: 'Carboidrato',
                    value: carboidratos,
                    goal: metaCarboidratos,
                    color: Colors.blue.shade300,
                  ),
                  const SizedBox(height: 8),
                  _MacroBar(
                    title: 'Proteína',
                    value: proteinas,
                    goal: metaProteinas,
                    color: Colors.green.shade300,
                  ),
                  const SizedBox(height: 8),
                  _MacroBar(
                    title: 'Gordura',
                    value: gorduras,
                    goal: metaGorduras,
                    color: Colors.red.shade300,
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

// Widget auxiliar para as barras de macro
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
    final progress = (goal == 0) ? 0.0 : (value / goal);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: textTheme.labelMedium),
            Text(
              '${value.toStringAsFixed(0)} g',
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

// 6. Card de Água
class _WaterCard extends StatelessWidget {
  const _WaterCard();

  @override
  Widget build(BuildContext context) {
    // Você pode conectar seus providers aqui
    const double aguaConsumida = 0.75;
    const int stepperValue = 250; // Valor do stepper (ex: 250 ml)

    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            // Ícone e Total
            Icon(Icons.local_drink, color: Colors.blue.shade300, size: 36),
            const SizedBox(width: 8),
            Text('${aguaConsumida.toStringAsFixed(2)} L',
                style: textTheme.titleMedium),
            const Spacer(),

            // Stepper
            Container(
              decoration: BoxDecoration(
                color: colors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, color: colors.onSurfaceVariant),
                    onPressed: () {/* Lógica de remover água */},
                  ),
                  Text('${stepperValue} ml', style: textTheme.bodyMedium),
                  IconButton(
                    icon: Icon(Icons.add, color: colors.onSurfaceVariant),
                    onPressed: () {/* Lógica de adicionar stepper */},
                  ),
                ],
              ),
            ),

            // Botão de Adicionar
            IconButton(
              icon: Icon(Icons.add_circle, color: colors.primary, size: 30),
              onPressed: () {/* Lógica de adicionar valor do stepper */},
            ),
          ],
        ),
      ),
    );
  }
}

// 8. Card de Refeição (redesenhado)
class _MealCard extends ConsumerWidget {
  final Meal meal;
  const _MealCard({required this.meal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    // Define os ícones com base no nome da refeição (exemplo)
    IconData mainIcon = Icons.restaurant_menu;
    IconData secondIcon = Icons.coffee;

    if (meal.name.toLowerCase().contains('almoço')) {
      mainIcon = Icons.restaurant;
      secondIcon = Icons.local_drink;
    } else if (meal.name.toLowerCase().contains('jantar')) {
      mainIcon = Icons.dinner_dining;
      secondIcon = Icons.local_drink;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header do Card
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(meal.name, style: textTheme.titleLarge),
                Text(
                  '${meal.calories.toStringAsFixed(0)} Kcal',
                  style: textTheme.titleMedium
                      ?.copyWith(color: textTheme.bodySmall?.color),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Ícones Grandes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(mainIcon,
                    size: 100,
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
                const SizedBox(width: 24),
                Icon(secondIcon,
                    size: 80,
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ],
            ),
            // Botão de expandir (como no protótipo)
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(Icons.expand_more,
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
                onPressed: () {
                  // Você pode implementar a lógica de expansão aqui
                  // ou navegar para a tela de detalhes
                  context.push('/diet/meal/${meal.id}');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
