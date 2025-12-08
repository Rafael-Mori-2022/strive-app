import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/presentation/state/workout_providers.dart';
import 'package:strive/i18n/strings.g.dart'; 

class WorkoutCreateScreen extends ConsumerStatefulWidget {
  const WorkoutCreateScreen({super.key});

  @override
  ConsumerState<WorkoutCreateScreen> createState() =>
      _WorkoutCreateScreenState();
}

class _WorkoutCreateScreenState extends ConsumerState<WorkoutCreateScreen> {
  final _nameCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  List<String> get _suggestions => [
        t.workout_create.suggestions.full_body,
        t.workout_create.suggestions.upper_body,
        t.workout_create.suggestions.lower_body,
        t.workout_create.suggestions.push_day,
        t.workout_create.suggestions.pull_day,
        t.workout_create.suggestions.leg_day,
        t.workout_create.suggestions.cardio_abs,
        t.workout_create.suggestions.yoga_flow
      ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _createWorkout() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      // Cria o plano no Firestore
      await ref
          .read(workoutControllerProvider)
          .createPlan(_nameCtrl.text.trim());

      if (mounted) {
        // Feedback tátil e visual com parâmetro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(t.workout_create.success_feedback(name: _nameCtrl.text)),
            backgroundColor: Colors.green,
          ),
        );
        context.pop(); // Volta para a lista de treinos
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(t.workout_create.error_feedback(error: e.toString())),
              backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    // Captura a lista traduzida
    final currentSuggestions = _suggestions;

    return Scaffold(
      backgroundColor: colors.surface, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: colors.onSurface),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: colors.primaryContainer.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.fitness_center_rounded,
                      size: 48,
                      color: colors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                Text(
                  t.workout_create.title, 
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  t.workout_create.subtitle, 
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 32),

                TextFormField(
                  controller: _nameCtrl,
                  autofocus: true,
                  style: TextStyle(fontSize: 18, color: colors.onSurface),
                  decoration: InputDecoration(
                    labelText: t.workout_create.field_label, 
                    hintText: t.workout_create.field_hint, 
                    prefixIcon:
                        Icon(Icons.edit_outlined, color: colors.primary),
                    filled: true,
                    fillColor: colors.surfaceVariant.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: colors.primary, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return t.workout_create.validator_error; 
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _createWorkout(),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton(
                    onPressed: _isLoading ? null : _createWorkout,
                    style: FilledButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: colors.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: colors.onPrimary,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Text(
                            t.workout_create.button_create, 
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),

                const SizedBox(height: 32),

                Text(
                  t.workout_create.suggestions_label, 
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: currentSuggestions.map((suggestion) {
                    return ActionChip(
                      label: Text(suggestion),
                      backgroundColor: colors.surface,
                      side: BorderSide(color: colors.outline.withOpacity(0.2)),
                      onPressed: () {
                        _nameCtrl.text = suggestion;
                        _nameCtrl.selection = TextSelection.fromPosition(
                          TextPosition(offset: _nameCtrl.text.length),
                        );
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
