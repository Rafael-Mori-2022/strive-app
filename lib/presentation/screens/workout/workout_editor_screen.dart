import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WorkoutEditorScreen extends StatelessWidget {
  const WorkoutEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dummy = [
      {'id': 'e1', 'name': 'Supino reto', 'details': '4x8'},
      {'id': 'e2', 'name': 'Desenvolvimento', 'details': '3x10'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Treino'), actions: [
        TextButton.icon(onPressed: () => context.push('/workout/add-exercise?muscle=Bíceps'), icon: const Icon(Icons.add), label: const Text('Adicionar +')),
      ]),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: dummy.length,
        itemBuilder: (_, i) {
          final ex = dummy[i];
          return Card(
            child: ListTile(
              title: Text(ex['name']!),
              subtitle: Text(ex['details']!),
              trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () {}),
            ),
          );
        },
      ),
    );
  }
}
