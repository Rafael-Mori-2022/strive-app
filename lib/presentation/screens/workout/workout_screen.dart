import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vigorbloom/domain/entities/workout.dart';
import 'package:vigorbloom/presentation/state/workout_providers.dart';

class WorkoutScreen extends ConsumerStatefulWidget {
  const WorkoutScreen({super.key});

  @override
  ConsumerState<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends ConsumerState<WorkoutScreen> {
  final PageController _controller = PageController(viewportFraction: 0.92);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final plans = ref.watch(workoutPlansProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Treino'), actions: [IconButton(icon: const Icon(Icons.add), onPressed: () => context.push('/workout/create'))]),
      body: plans.when(
        data: (list) => PageView.builder(
          controller: _controller,
          itemCount: list.length,
          itemBuilder: (_, i) => _PlanCard(plan: list[i]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => const Center(child: Text('Erro ao carregar treinos')),
      ),
    );
  }
}

class _PlanCard extends ConsumerWidget {
  final WorkoutPlan plan;
  const _PlanCard({required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(plan.name, style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () => context.push('/workout/editor')),
            ]),
            const SizedBox(height: 8),
            Text('${plan.exercises.length} exercícios'),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: plan.exercises.length,
                itemBuilder: (_, i) {
                  final ex = plan.exercises[i];
                  return CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(ex.name),
                    subtitle: Text(ex.details),
                    value: ex.completed,
                    onChanged: (_) {},
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
