import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/domain/entities/workout.dart';
import 'package:strive/domain/entities/exercise.dart';
import 'package:strive/presentation/state/workout_providers.dart';
import 'package:strive/presentation/state/gamification_provider.dart';
import 'package:strive/domain/enums/xp_action.dart';

// --- PROVIDER DO CALENDÁRIO ---
final completedDatesProvider =
    NotifierProvider<CompletedDatesNotifier, Set<DateTime>>(
        CompletedDatesNotifier.new);

class CompletedDatesNotifier extends Notifier<Set<DateTime>> {
  @override
  Set<DateTime> build() {
    return {};
  }

  void toggleDate(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final newState = Set<DateTime>.from(state);
    
    if (newState.contains(normalizedDate)) {
      newState.remove(normalizedDate);
    } else {
      newState.add(normalizedDate);
    }
    state = newState;
  }
}

// --- TELA PRINCIPAL DE TREINO ---
class WorkoutScreen extends ConsumerStatefulWidget {
  const WorkoutScreen({super.key});

  @override
  ConsumerState<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends ConsumerState<WorkoutScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.92);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page != null) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Observa a lista de planos vinda do Repositório (Firebase)
    final plansAsync = ref.watch(workoutPlansProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async {
            ref.refresh(workoutPlansProvider);
          },
          child: ListView(
            // Padding inferior para não conflitar com a Navbar Flutuante
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            children: [
              const _Header(),
              const SizedBox(height: 16),
              
              const _TodaySummary(),
              const SizedBox(height: 24),
              
              // Lista de Planos (Carrossel)
              plansAsync.when(
                data: (plans) {
                  if (plans.isEmpty) {
                    return _EmptyStateCard(
                      onPressed: () => context.push('/workout/create'),
                    );
                  }
                  return Column(
                    children: [
                      SizedBox(
                        height: 450, // Altura suficiente para lista de exercícios
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: plans.length,
                          itemBuilder: (_, i) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: _PlanCard(plan: plans[i]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _PageIndicator(
                        pageCount: plans.length,
                        currentPage: _currentPage,
                      ),
                    ],
                  );
                },
                loading: () => const SizedBox(
                  height: 400,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, st) => Center(
                  child: Text('Erro ao carregar treinos: $e'),
                ),
              ),
              
              const SizedBox(height: 24),
              const _CalendarCard(),
            ],
          ),
        ),
      ),
    );
  }
}

// --- WIDGETS INTERNOS ---

class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Treino',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        IconButton(
          onPressed: () => context.push('/workout/create'),
          icon: const Icon(Icons.add_circle_outline, size: 28),
          tooltip: "Criar novo plano",
        )
      ],
    );
  }
}

class _EmptyStateCard extends StatelessWidget {
  final VoidCallback onPressed;
  const _EmptyStateCard({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const Icon(Icons.fitness_center, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Nenhum plano de treino encontrado.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onPressed,
              child: const Text("Criar meu primeiro treino"),
            )
          ],
        ),
      ),
    );
  }
}

class _TodaySummary extends StatelessWidget {
  const _TodaySummary();

  @override
  Widget build(BuildContext context) {
    // Idealmente, isso viria de um provider de estatísticas diárias
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Hoje',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        const _SummaryItem(
          icon: Icons.timer_outlined,
          text: '0h', // Placeholder MVP
          iconColor: Color(0xFF63BC6A),
        ),
        const _SummaryItem(
          icon: Icons.local_fire_department,
          text: '0 Kcal', // Placeholder MVP
          iconColor: Color(0xFFFF8A65),
        ),
        const _SummaryItem(
          icon: Icons.track_changes,
          text: '0/5', // Placeholder MVP
          iconColor: Color(0xFFFACC15),
        ),
      ],
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem(
      {required this.icon, required this.text, required this.iconColor});
  final IconData icon;
  final String text;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 4),
        Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

// CARD PRINCIPAL DO PLANO (DINÂMICO)
class _PlanCard extends ConsumerWidget {
  final WorkoutPlan plan;
  const _PlanCard({required this.plan});

  // 1. Função para mostrar o Menu Inferior (Sheet)
  void _showPlanOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Indicador visual de "puxar"
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Opção: Editar Nome
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Renomear Plano'),
              onTap: () {
                Navigator.pop(ctx); // Fecha o sheet
                _showRenameDialog(context, ref); // Abre o dialog
              },
            ),
            const Divider(indent: 16, endIndent: 16),
            // Opção: Excluir
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Excluir Plano', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(ctx); // Fecha o sheet
                _showDeleteConfirmDialog(context, ref); // Abre confirmação
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  // 2. Dialog para Renomear
  void _showRenameDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: plan.name);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Renomear Plano'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Nome do treino',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                ref.read(workoutControllerProvider).renamePlan(plan.id, controller.text.trim());
              }
              Navigator.pop(ctx);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  // 3. Dialog de Confirmação de Exclusão
  void _showDeleteConfirmDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Plano?'),
        content: Text('Tem certeza que deseja excluir "${plan.name}"? Esta ação não pode ser desfeita.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              ref.read(workoutControllerProvider).deletePlan(plan.id);
              Navigator.pop(ctx);
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header do Plano
            Row(
              children: [
                Expanded(
                  child: Text(
                    plan.name,
                    style: theme.textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // IMPLEMENTADO AQUI:
                IconButton(
                  icon: Icon(Icons.more_vert, color: colors.onSurfaceVariant),
                  onPressed: () => _showPlanOptions(context, ref),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),

            // Lista de Exercícios
            if (plan.exercises.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_task,
                          size: 48, color: colors.onSurfaceVariant.withOpacity(0.3)),
                      const SizedBox(height: 8),
                      Text(
                        "Este plano está vazio.",
                        style: TextStyle(color: colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.separated(
                  itemCount: plan.exercises.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final exercise = plan.exercises[index];
                    return _ExerciseRow(
                      exercise: exercise,
                      onToggle: () async {
                        await ref
                            .read(workoutControllerProvider)
                            .toggleExercise(plan.id, exercise.id);
                        
                        if (!exercise.completed && context.mounted) {
                           ref.read(gamificationControllerProvider).earnXp(context, XpAction.completeWorkout);
                        }
                      },
                    );
                  },
                ),
              ),

            const SizedBox(height: 16),

            // Botão Adicionar Exercício
            Align(
              alignment: Alignment.bottomRight,
              child: FilledButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Exercício"),
                onPressed: () {
                  context.push('/workout/add-exercise?planId=${plan.id}&muscle=Peito');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Linha de Exercício Individual
class _ExerciseRow extends StatelessWidget {
  const _ExerciseRow({
    required this.exercise,
    required this.onToggle,
  });

  final Exercise exercise;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // Cores baseadas no grupo muscular para facilitar visualização
    Color iconColor = colors.primary;
    if (exercise.muscleGroup == 'Pernas') iconColor = Colors.orange;
    if (exercise.muscleGroup == 'Costas') iconColor = Colors.purple;
    if (exercise.muscleGroup == 'Peito') iconColor = Colors.redAccent;

    return InkWell(
      onTap: onToggle,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.fitness_center, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      decoration: exercise.completed ? TextDecoration.lineThrough : null,
                      color: exercise.completed ? colors.onSurfaceVariant : colors.onSurface,
                    ),
                  ),
                  if (exercise.details.isNotEmpty)
                    Text(
                      exercise.details,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
            Checkbox(
              value: exercise.completed,
              onChanged: (_) => onToggle(),
              activeColor: colors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.pageCount, required this.currentPage});
  final int pageCount;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    if (pageCount <= 1) return const SizedBox.shrink();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: currentPage == index ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: currentPage == index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surfaceVariant,
          ),
        ),
      ),
    );
  }
}

// --- CALENDÁRIO ---
class _CalendarCard extends ConsumerWidget {
  const _CalendarCard();

  static const _months = [
    '', 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    
    final completedDates = ref.watch(completedDatesProvider);

    final now = DateTime.now();
    final year = now.year;
    final month = now.month;
    
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final firstDayOfMonth = DateTime(year, month, 1);
    final firstWeekday = firstDayOfMonth.weekday; // 1=Seg, 7=Dom
    // Ajuste para calendário começar no Domingo (0)
    final offsetDays = firstWeekday == 7 ? 0 : firstWeekday; 

    final daysOfWeek = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_months[month]} $year",
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Icon(Icons.calendar_month, size: 20, color: colors.primary),
              ],
            ),
            const SizedBox(height: 16),
            
            // Header Dias da Semana
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: daysOfWeek
                  .map((day) => Text(
                        day,
                        style: theme.textTheme.labelMedium
                            ?.copyWith(color: colors.primary, fontWeight: FontWeight.bold),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 12),
            
            // Grid de Dias
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: daysInMonth + offsetDays,
              itemBuilder: (context, index) {
                if (index < offsetDays) {
                  return Container();
                }

                final day = index - offsetDays + 1;
                final dateToCheck = DateTime(year, month, day);
                
                final isTrained = completedDates.contains(dateToCheck);
                final isToday = day == now.day;

                return InkWell(
                  onTap: () {
                    ref.read(completedDatesProvider.notifier).toggleDate(dateToCheck);
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isTrained
                          ? const Color(0xFF3B8E42) 
                          : colors.surfaceVariant.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                      border: isToday && !isTrained
                          ? Border.all(color: colors.primary, width: 1.5) 
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isTrained ? Colors.white : colors.onSurface,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}