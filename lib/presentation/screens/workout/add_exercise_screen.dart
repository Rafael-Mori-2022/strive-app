import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vigorbloom/presentation/state/workout_providers.dart';
import 'package:vigorbloom/presentation/widgets/common_widgets.dart';

class AddExerciseScreen extends ConsumerStatefulWidget {
  final String muscleGroup;
  const AddExerciseScreen({super.key, required this.muscleGroup});

  @override
  ConsumerState<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends ConsumerState<AddExerciseScreen> {
  final Set<String> _selected = {};

  @override
  Widget build(BuildContext context) {
    final ex = ref.watch(exercisesByMuscleProvider(widget.muscleGroup));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.muscleGroup),
        actions: [TextButton(onPressed: () => context.pop(_selected.toList()), child: const Text('OK'))],
      ),
      body: ex.when(
        data: (list) => ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: list.length,
          itemBuilder: (_, i) {
            final e = list[i];
            final checked = _selected.contains(e.id);
            return Card(
              child: ListTile(
                leading: const Icon(Icons.fitness_center),
                title: Text(e.name),
                subtitle: Text(e.details),
                trailing: IconButton(
                  icon: Icon(checked ? Icons.check_circle : Icons.add_circle, color: checked ? Colors.green : Colors.blue),
                  onPressed: () {
                    setState(() {
                      if (checked) {
                        _selected.remove(e.id);
                      } else {
                        _selected.add(e.id);
                      }
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    if (checked) {
                      _selected.remove(e.id);
                    } else {
                      _selected.add(e.id);
                    }
                  });
                },
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => const Center(child: Text('Erro ao listar exercícios')),
      ),
    );
  }
}
