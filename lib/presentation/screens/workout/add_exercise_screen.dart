import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/domain/entities/exercise.dart';
import 'package:strive/domain/enums/xp_action.dart';
import 'package:strive/presentation/state/gamification_provider.dart';
import 'package:strive/presentation/state/workout_providers.dart';

// Provider auxiliar para buscar exercícios da API
final searchExercisesProvider = FutureProvider.family<List<Exercise>, String>((ref, query) async {
  // Se a query estiver vazia, retorna uma lista padrão (ex: Peito) ou vazia
  if (query.isEmpty) {
    return ref.read(workoutRepositoryProvider).listExercisesByMuscle('Peito');
  }
  
  // Lógica simples: verifica se a query corresponde a um grupo muscular conhecido
  final muscleGroups = ['Peito', 'Costas', 'Bíceps', 'Tríceps', 'Pernas', 'Ombros', 'Abdômen'];
  
  // Tenta encontrar um match exato ou parcial
  final match = muscleGroups.firstWhere(
    (m) => m.toLowerCase().contains(query.toLowerCase()), 
    orElse: () => 'Peito' // Fallback padrão
  );
  
  return ref.read(workoutRepositoryProvider).listExercisesByMuscle(match);
});

class AddExerciseScreen extends ConsumerStatefulWidget {
  final String muscleGroup;
  final String planId;

  const AddExerciseScreen({
    super.key,
    required this.muscleGroup,
    required this.planId,
  });

  @override
  ConsumerState<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends ConsumerState<AddExerciseScreen> {
  String _query = '';
  late TextEditingController _searchCtrl;

  @override
  void initState() {
    super.initState();
    _query = widget.muscleGroup;
    _searchCtrl = TextEditingController(text: widget.muscleGroup);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = ref.watch(searchExercisesProvider(_query));
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Adicionar Exercício'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          // CORREÇÃO: Usa GoRouter para voltar de forma segura
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              // Fallback seguro caso não haja histórico (ex: deep link)
              context.go('/workout'); 
            }
          },
        ),
      ),
      body: Column(
        children: [
          // Barra de Busca
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'Buscar por grupo muscular (ex: Peito, Costas)',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchCtrl.clear();
                    setState(() => _query = '');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: colors.surfaceVariant.withOpacity(0.3),
              ),
              onSubmitted: (value) {
                setState(() => _query = value);
              },
            ),
          ),

          // Lista de Resultados
          Expanded(
            child: exercisesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Erro: $e')),
              data: (exercises) {
                if (exercises.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: colors.onSurfaceVariant),
                        const SizedBox(height: 16),
                        Text(
                          'Nenhum exercício encontrado para "$_query"',
                          style: TextStyle(color: colors.onSurfaceVariant),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tente: Peito, Costas, Pernas, Bíceps...',
                          style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: exercises.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        leading: CircleAvatar(
                          backgroundColor: colors.primaryContainer,
                          child: Icon(Icons.fitness_center, color: colors.onPrimaryContainer),
                        ),
                        title: Text(
                          exercise.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          // Mostra grupo muscular e um trecho da descrição limpa
                          "${exercise.muscleGroup} • ${exercise.description?.replaceAll(RegExp(r'<[^>]*>'), '').split('.').first ?? ''}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.add_circle, size: 32),
                          color: colors.primary,
                          onPressed: () async {
                            // 1. Adicionar ao Plano
                            await ref.read(workoutControllerProvider).addExerciseToPlan(
                              widget.planId,
                              // Cria uma nova instância para garantir dados limpos
                              Exercise(
                                id: exercise.id, 
                                name: exercise.name,
                                muscleGroup: exercise.muscleGroup,
                                description: exercise.description,
                                details: "3x12", // Valor padrão inicial
                                completed: false,
                              ),
                            );

                            // 2. Dar XP e Feedback Visual
                            if (context.mounted) {
                              // Usando 'updateProfile' como ação genérica, idealmente teria 'addExercise' no enum
                              ref.read(gamificationControllerProvider).earnXp(context, XpAction.updateProfile); 
                              
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${exercise.name} adicionado ao treino!'),
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}