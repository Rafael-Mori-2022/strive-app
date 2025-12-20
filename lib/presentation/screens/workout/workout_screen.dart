import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strive/domain/entities/workout.dart';
import 'package:strive/domain/entities/exercise.dart';
import 'package:strive/presentation/state/workout_providers.dart';
import 'package:strive/presentation/state/gamification_provider.dart';
import 'package:strive/domain/enums/xp_action.dart';
import 'package:strive/i18n/strings.g.dart';

final completedDatesProvider =
    AsyncNotifierProvider<CompletedDatesNotifier, Set<DateTime>>(
        CompletedDatesNotifier.new);

class CompletedDatesNotifier extends AsyncNotifier<Set<DateTime>> {
  static const _kKey = 'completed_workout_dates';

  @override
  Future<Set<DateTime>> build() async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList(_kKey) ?? [];

    return stringList.map((s) => DateTime.parse(s)).toSet();
  }

  Future<void> toggleDate(DateTime date) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    
    final currentSet = state.value ?? {};
    final newSet = Set<DateTime>.from(currentSet);

    if (newSet.contains(normalizedDate)) {
      newSet.remove(normalizedDate);
    } else {
      newSet.add(normalizedDate);
    }

    state = AsyncData(newSet);

    final prefs = await SharedPreferences.getInstance();
    final stringList = newSet.map((d) => d.toIso8601String()).toList();
    await prefs.setStringList(_kKey, stringList);
  }
}

// --- ESTADO DO RESUMO DIÁRIO (TEMPO E CALORIAS) ---

class DailySummaryState {
  final int durationMinutes;
  final int caloriesBurned;

  DailySummaryState({this.durationMinutes = 0, this.caloriesBurned = 0});
}

final dailySummaryProvider =
    AsyncNotifierProvider<DailySummaryNotifier, DailySummaryState>(
        DailySummaryNotifier.new);

class DailySummaryNotifier extends AsyncNotifier<DailySummaryState> {
  static const _kPrefix = 'daily_summary_';

  // Gera uma chave única para o dia de hoje. Amanhã a chave muda, "resetando" o valor.
  String _getKey() {
    final now = DateTime.now();
    return '$_kPrefix${now.year}-${now.month}-${now.day}';
  }

  @override
  Future<DailySummaryState> build() async {
    final prefs = await SharedPreferences.getInstance();
    final key = _getKey();
    
    // Se não tiver dados para hoje, retorna zerado
    final duration = prefs.getInt('${key}_duration') ?? 0;
    final calories = prefs.getInt('${key}_calories') ?? 0;

    return DailySummaryState(durationMinutes: duration, caloriesBurned: calories);
  }

  Future<void> updateStats({int? minutes, int? calories}) async {
    final currentState = state.value ?? DailySummaryState();
    
    final newMinutes = minutes ?? currentState.durationMinutes;
    final newCalories = calories ?? currentState.caloriesBurned;

    state = AsyncData(DailySummaryState(
      durationMinutes: newMinutes,
      caloriesBurned: newCalories,
    ));

    // Salva no disco vinculado à data de hoje
    final prefs = await SharedPreferences.getInstance();
    final key = _getKey();
    await prefs.setInt('${key}_duration', newMinutes);
    await prefs.setInt('${key}_calories', newCalories);
  }
}

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
    final plansAsync = ref.watch(workoutPlansProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async {
            ref.refresh(workoutPlansProvider);
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            children: [
              const _Header(),
              const SizedBox(height: 16),

              const _TodaySummary(),
              const SizedBox(height: 24),

              // Lista de Planos 
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
                        height: 450,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: plans.length,
                          itemBuilder: (_, i) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
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
                  child: Text('${t.common.error}: $e'),
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

class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          t.workout.title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        IconButton(
          onPressed: () => context.push('/workout/create'),
          icon: const Icon(Icons.add_circle_outline, size: 28),
          tooltip: t.workout.create_tooltip,
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
            Text(
              t.workout.empty_state.title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onPressed,
              child: Text(t.workout.empty_state.button),
            )
          ],
        ),
      ),
    );
  }
}

class _TodaySummary extends ConsumerWidget {
  const _TodaySummary();

  void _showEditDialog(BuildContext context, WidgetRef ref, DailySummaryState current) {
    final timeController = TextEditingController(text: current.durationMinutes.toString());
    final calController = TextEditingController(text: current.caloriesBurned.toString());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Editar Resumo de Hoje"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: timeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Tempo de Treino (minutos)",
                prefixIcon: Icon(Icons.timer_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: calController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Calorias Queimadas (kcal)",
                prefixIcon: Icon(Icons.local_fire_department),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(t.common.cancel),
          ),
          FilledButton(
            onPressed: () {
              final min = int.tryParse(timeController.text) ?? 0;
              final cal = int.tryParse(calController.text) ?? 0;
              
              ref.read(dailySummaryProvider.notifier).updateStats(
                minutes: min,
                calories: cal,
              );
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
    final summaryAsync = ref.watch(dailySummaryProvider);
    final summary = summaryAsync.value ?? DailySummaryState();

    final plansAsync = ref.watch(workoutPlansProvider);
    
    int totalExercises = 0;
    int completedExercises = 0;

    plansAsync.whenData((plans) {
      for (var plan in plans) {
        totalExercises += plan.exercises.length;
        completedExercises += plan.exercises.where((e) => e.completed).length;
      }
    });

    final hours = summary.durationMinutes ~/ 60;
    final minutes = summary.durationMinutes % 60;
    final timeString = hours > 0 ? '${hours}h ${minutes}m' : '${minutes}m';

    return InkWell(
      // Ao clicar em qualquer lugar do resumo, abre a edição
      onTap: () => _showEditDialog(context, ref, summary),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.workout.summary.today,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            _SummaryItem(
              icon: Icons.timer_outlined,
              text: timeString,
              iconColor: const Color(0xFF63BC6A),
            ),
            _SummaryItem(
              icon: Icons.local_fire_department,
              text: '${summary.caloriesBurned} Kcal',
              iconColor: const Color(0xFFFF8A65),
            ),
            _SummaryItem(
              icon: Icons.track_changes,
              text: '$completedExercises/$totalExercises',
              iconColor: const Color(0xFFFACC15),
            ),
          ],
        ),
      ),
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
        Text(
          text, 
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold
          )
        ),
      ],
    );
  }
}

class _PlanCard extends ConsumerWidget {
  final WorkoutPlan plan;
  const _PlanCard({required this.plan});

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
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: Text(t.workout.options.rename),
              onTap: () {
                Navigator.pop(ctx);
                _showRenameDialog(context, ref);
              },
            ),
            const Divider(indent: 16, endIndent: 16),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: Text(t.workout.options.delete,
                  style: const TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(ctx);
                _showDeleteConfirmDialog(context, ref);
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _showRenameDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: plan.name);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.workout.options.rename),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            labelText: t.workout.dialogs.rename_label,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(t.common.cancel),
          ),
          FilledButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                ref
                    .read(workoutControllerProvider)
                    .renamePlan(plan.id, controller.text.trim());
              }
              Navigator.pop(ctx);
            },
            child: Text(t.common.save),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.workout.dialogs.delete_title),
        content: Text(t.workout.dialogs.delete_content(name: plan.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(t.common.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              ref.read(workoutControllerProvider).deletePlan(plan.id);
              Navigator.pop(ctx);
            },
            child: Text(t.workout.dialogs.delete_confirm),
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
            Row(
              children: [
                Expanded(
                  child: Text(
                    plan.name,
                    style: theme.textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_vert, color: colors.onSurfaceVariant),
                  onPressed: () => _showPlanOptions(context, ref),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),

            if (plan.exercises.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_task,
                          size: 48,
                          color: colors.onSurfaceVariant.withOpacity(0.3)),
                      const SizedBox(height: 8),
                      Text(
                        t.workout.plan_empty,
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
                          final gamification = ref.read(gamificationControllerProvider);

                          gamification.earnXp(context, XpAction.completeExercise);

                          final currentPlans = ref.read(workoutPlansProvider).valueOrNull ?? [];
                          
                          final updatedPlan = currentPlans.firstWhere(
                            (p) => p.id == plan.id, 
                            orElse: () => plan
                          );

                          final isWorkoutFinished = updatedPlan.exercises.every((e) => e.completed);

                          if (isWorkoutFinished) {
                            gamification.earnXp(context, XpAction.completeWorkout);
                            
                            Future.delayed(const Duration(seconds: 2), () {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Treino finalizado! Parabéns! 🔥"),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            });
                          }
                        }
                      },
                    );
                  },
                ),
              ),

            const SizedBox(height: 16),

            Align(
              alignment: Alignment.bottomRight,
              child: FilledButton.icon(
                icon: const Icon(Icons.add),
                label: Text(t.workout.add_exercise_short),
                onPressed: () {
                  context.push(
                      '/workout/add-exercise?planId=${plan.id}&muscle=Peito');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
                      decoration: exercise.completed
                          ? TextDecoration.lineThrough
                          : null,
                      color: exercise.completed
                          ? colors.onSurfaceVariant
                          : colors.onSurface,
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
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

class _CalendarCard extends ConsumerWidget {
  const _CalendarCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final completedDatesAsync = ref.watch(completedDatesProvider);
    final completedDates = completedDatesAsync.value ?? {};

    final now = DateTime.now();
    final year = now.year;
    final month = now.month;

    final months = t.workout.calendar.months;
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final firstDayOfMonth = DateTime(year, month, 1);
    final firstWeekday = firstDayOfMonth.weekday;
    final offsetDays = firstWeekday == 7 ? 0 : firstWeekday;

    final daysOfWeek = t.workout.calendar.weekdays;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${months.length > month ? months[month] : ''} $year",
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Icon(Icons.calendar_month, size: 20, color: colors.primary),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: daysOfWeek
                  .map((day) => Text(
                        day,
                        style: theme.textTheme.labelMedium?.copyWith(
                            color: colors.primary, fontWeight: FontWeight.bold),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 12),

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
                    ref
                        .read(completedDatesProvider.notifier)
                        .toggleDate(dateToCheck);
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