import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/domain/entities/workout.dart';
import 'package:strive/presentation/state/workout_providers.dart';
import 'package:strive/i18n/strings.g.dart'; // Importação do Slang

class WorkoutEditorScreen extends ConsumerWidget {
  final String planId;

  const WorkoutEditorScreen({super.key, required this.planId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(workoutPlansProvider);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        // Título traduzido
        title: Text(t.workout_editor.title),
        actions: [
          // Botão de atalho para adicionar mais exercícios
          TextButton.icon(
            onPressed: () => context.push(
                '/workout/add-exercise?planId=$planId&muscle=Peito'), // Default muscle
            icon: const Icon(Icons.add),
            label: Text(t.workout_editor.add_button),
          ),
        ],
      ),
      body: plansAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        // Erro com parâmetro
        error: (e, _) =>
            Center(child: Text(t.workout_editor.error(error: e.toString()))),
        data: (plans) {
          // Encontra o plano que estamos editando
          final plan = plans.firstWhere(
            (p) => p.id == planId,
            orElse: () => WorkoutPlan(
                id: 'error', name: t.workout_editor.not_found, exercises: []),
          );

          if (plan.id == 'error') {
            return Center(child: Text(t.workout_editor.not_found));
          }

          if (plan.exercises.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.fitness_center,
                      size: 64, color: colors.surfaceVariant),
                  const SizedBox(height: 16),
                  Text(
                    t.workout_editor.empty_text,
                    style: TextStyle(color: colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    icon: const Icon(Icons.add),
                    label: Text(t.workout_editor.add_exercise_button),
                    onPressed: () => context.push(
                        '/workout/add-exercise?planId=$planId&muscle=Peito'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: plan.exercises.length,
            itemBuilder: (context, index) {
              final exercise = plan.exercises[index];

              // Wrapper Dismissible
              return Dismissible(
                key: Key(exercise.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  color: colors.error,
                  child: Icon(Icons.delete, color: colors.onError),
                ),
                onDismissed: (direction) {
                  // Remove do banco
                  ref
                      .read(workoutControllerProvider)
                      .removeExerciseFromPlan(planId, exercise.id);

                  // Feedback visual traduzido
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(t.workout_editor
                            .removed_snackbar(name: exercise.name))),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: colors.surfaceVariant,
                      child: Icon(Icons.fitness_center,
                          color: colors.onSurfaceVariant),
                    ),
                    title: Text(
                      exercise.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      exercise.muscleGroup,
                      style: TextStyle(color: colors.primary),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_outline, color: colors.error),
                      onPressed: () {
                        // Confirmação antes de excluir via botão
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(t.workout_editor.remove_dialog.title),
                            content: Text(t.workout_editor.remove_dialog
                                .content(name: exercise.name)),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: Text(
                                    t.common.cancel), // Reutilizado de common
                              ),
                              FilledButton(
                                style: FilledButton.styleFrom(
                                    backgroundColor: colors.error),
                                onPressed: () {
                                  ref
                                      .read(workoutControllerProvider)
                                      .removeExerciseFromPlan(
                                          planId, exercise.id);
                                  Navigator.pop(ctx);
                                },
                                child: Text(
                                    t.workout_editor.remove_dialog.confirm),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
