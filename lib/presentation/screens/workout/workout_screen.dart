import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/domain/entities/workout.dart'; // Mantive sua entidade
import 'package:strive/presentation/state/workout_providers.dart';

// Provider para o calendário
// Gerencia o conjunto de datas que o usuário marcou como treinadas
final completedDatesProvider =
    NotifierProvider<CompletedDatesNotifier, Set<DateTime>>(
        CompletedDatesNotifier.new);

class CompletedDatesNotifier extends Notifier<Set<DateTime>> {
  @override
  Set<DateTime> build() {
    return {};
  }

  void toggleDate(DateTime date) {
    // Normaliza a data para ignorar horas/minutos (dia/mês/ano)
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

class WorkoutScreen extends ConsumerStatefulWidget {
  const WorkoutScreen({super.key});

  @override
  ConsumerState<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends ConsumerState<WorkoutScreen> {
  // Controller para o PageView dos cards de treino 
  final PageController _pageController = PageController();
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
    final plans = ref.watch(workoutPlansProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      // Sem AppBar
      body: SafeArea(
        bottom: false,
        child: ListView(
          // Padding geral da tela
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            const _Header(),
            const SizedBox(height: 16),
            // Card de estatísticas "Hoje"
            const _TodaySummary(),
            const SizedBox(height: 16),
            // Pager dos treinos (Full-body, etc.)
            plans.when(
              data: (list) {
                // Se não houver planos, mostre algo
                if (list.isEmpty) {
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Nenhum plano de treino encontrado.'),
                    ),
                  );
                }
                // O Pager
                return Column(
                  children: [
                    SizedBox(
                      height: 380, // Altura fixa para o PageView
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: list.length,
                        itemBuilder: (_, i) => _PlanCard(plan: list[i]),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // 5. Indicador de página (os pontinhos)
                    _PageIndicator(
                      pageCount: list.length,
                      currentPage: _currentPage,
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) =>
                  const Center(child: Text('Erro ao carregar treinos')),
            ),
            const SizedBox(height: 16),
            // Card do Calendário
            const _CalendarCard(),
            const SizedBox(height: 16),
            // Barra de Navegação (a mesma do Dashboard)
            const SizedBox(height: 84),
          ],
        ),
      ),
    );
  }
}

// --- WIDGETS PRIVADOS ---

class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        'Treino',
        style: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _TodaySummary extends StatelessWidget {
  const _TodaySummary();

  @override
  Widget build(BuildContext context) {
    // Valores hardcoded da imagem
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
          text: '2h',
          iconColor: Color(0xFF63BC6A), // Verde
        ),
        const _SummaryItem(
          icon: Icons.local_fire_department,
          text: '520 Kcal',
          iconColor: Color(0xFFFF8A65), // Laranja
        ),
        const _SummaryItem(
          icon: Icons.track_changes,
          text: '9/29',
          iconColor: Color(0xFFFACC15), // Dourado/Primária
        ),
      ],
    );
  }
}

// Item para o _TodaySummary
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

// Card do Plano de Treino 
class _PlanCard extends ConsumerWidget {
  final WorkoutPlan plan;
  const _PlanCard({required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    // Hardcoded para bater com a imagem
    final exercises = [
      {
        'name': 'Rosca Alternada',
        'sets': '4x10',
        'weight': '12kg',
        'icon': Icons.fitness_center,
        'completed': true
      },
      {
        'name': 'Agachamento com barra',
        'sets': '4x12',
        'weight': '45kg',
        'icon': Icons.fitness_center,
        'completed': true
      },
      {
        'name': 'Abdominal',
        'sets': '3x15',
        'weight': '35kg',
        'icon': Icons.fitness_center,
        'completed': false
      },
      {
        'name': 'Cardio',
        'sets': '30min',
        'weight': '0kg',
        'icon': Icons.directions_run,
        'completed': false
      },
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header do Card
            Row(
              children: [
                Text(plan.name,
                    style: theme.textTheme.headlineSmall), 
                const Spacer(),
                Icon(
                  Icons.edit_outlined,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Lista de Exercícios 
            Column(
              children: exercises 
                  .map((ex) => _ExerciseRow(
                        icon: ex['icon'] as IconData,
                        name: ex['name'] as String,
                        sets: ex['sets'] as String,
                        weight: ex['weight'] as String,
                        completed: ex['completed'] as bool,
                      ))
                  .toList(),
            ),
            const Spacer(),
            // Botão de Adicionar (canto inferior direito)
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                onPressed: () {
                  // Lógica para adicionar exercício
                  context.push('/workout/add-exercise?muscle=Bíceps');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Linha de Exercício
class _ExerciseRow extends StatelessWidget {
  const _ExerciseRow({
    required this.icon,
    required this.name,
    required this.sets,
    required this.weight,
    required this.completed,
  });

  final IconData icon;
  final String name;
  final String sets;
  final String weight;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // Cor do ícone baseada no nome (exemplo)
    Color iconColor = colors.primary;
    if (name.contains('Agachamento')) iconColor = const Color(0xFFC04000);
    if (name.contains('Abdominal')) iconColor = const Color(0xFF7E5A00);
    if (name.contains('Cardio')) iconColor = const Color(0xFF0061A4);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: theme.textTheme.titleMedium),
              Text(
                sets,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: colors.onSurfaceVariant),
              ),
            ],
          ),
          const Spacer(),
          Text(weight, style: theme.textTheme.titleMedium),
          const SizedBox(width: 12),
          Checkbox(
            value: completed,
            onChanged: (val) {},
            activeColor: colors.primary,
            // Cor do checkbox
            fillColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return colors.primary; // Cor quando selecionado
                }
                return colors.surfaceVariant; // Cor quando não selecionado
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Indicador de Página (pontinhos)
class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.pageCount, required this.currentPage});
  final int pageCount;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surfaceVariant,
          ),
        ),
      ),
    );
  }
}

// Card do Calendário
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
    
    // Dados do provider
    final completedDates = ref.watch(completedDatesProvider);

    // Lógica de Datas
    final now = DateTime.now();
    final year = now.year;
    final month = now.month;
    
    // Quantidade de dias no mês atual 
    final daysInMonth = DateTime(year, month + 1, 0).day;
    
    final firstDayOfMonth = DateTime(year, month, 1);
    final firstWeekday = firstDayOfMonth.weekday;
    final offsetDays = firstWeekday % 7;

    final daysOfWeek = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Título do Mês
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_months[month]} $year",
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Icon(Icons.calendar_today, size: 20, color: colors.primary),
              ],
            ),
            const SizedBox(height: 16),
            
            // Dias da semana
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
            
            // Grid dos dias
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              // Total de células = dias do mês + offset inicial
              itemCount: daysInMonth + offsetDays,
              itemBuilder: (context, index) {
                // Células vazias antes do dia 1
                if (index < offsetDays) {
                  return Container();
                }

                final day = index - offsetDays + 1;
                final dateToCheck = DateTime(year, month, day);
                
                // Verifica se esta data está no set de completas
                final isTrained = completedDates.contains(dateToCheck);
                final isToday = day == now.day;

                return InkWell(
                  onTap: () {
                    // Chama o provider para marcar/desmarcar
                    ref.read(completedDatesProvider.notifier).toggleDate(dateToCheck);
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isTrained
                          ? const Color(0xFF3B8E42) // Verde (Treinado)
                          : colors.surfaceVariant, // Cinza (Padrão)
                      borderRadius: BorderRadius.circular(8),
                      border: isToday && !isTrained
                          ? Border.all(color: colors.primary, width: 2) // Borda para hoje se não treinado
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
