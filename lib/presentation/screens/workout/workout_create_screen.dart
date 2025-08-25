import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vigorbloom/presentation/widgets/common_widgets.dart';

class WorkoutCreateScreen extends StatefulWidget {
  const WorkoutCreateScreen({super.key});

  @override
  State<WorkoutCreateScreen> createState() => _WorkoutCreateScreenState();
}

class _WorkoutCreateScreenState extends State<WorkoutCreateScreen> {
  final _nameCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Treino')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'Nome do treino')),
          const SizedBox(height: 12),
          SecondaryButton(label: 'Adicionar +', leadingIcon: Icons.add, onPressed: () => context.push('/workout/add-exercise?muscle=Bíceps')),
          const Spacer(),
          PrimaryButton(label: 'Salvar', leadingIcon: Icons.check, onPressed: () => Navigator.of(context).pop()),
        ]),
      ),
    );
  }
}
