import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/presentation/state/health_providers.dart';

class StepsScreen extends ConsumerWidget {
  const StepsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final stepsAsync = ref.watch(stepsProvider);

    // Agora a meta vem do SharedPreferences via Riverpod
    final stepGoal = ref.watch(stepGoalProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(stepsProvider),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: theme.colorScheme.surface,
              elevation: 0,
              leading: IconButton(
                icon:
                    Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
                onPressed: () =>
                    context.canPop() ? context.pop() : context.go('/dashboard'),
              ),
              title: Text("Mobilidade",
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // --- O GRANDE INDICADOR ---
                    stepsAsync.when(
                      data: (steps) => _AnimatedRing(
                        current: steps,
                        target: stepGoal, // Meta dinâmica
                        theme: theme,
                        onEditGoal: () =>
                            _showEditGoalDialog(context, ref, stepGoal),
                      ),
                      loading: () => const SizedBox(
                          height: 320,
                          child: Center(child: CircularProgressIndicator())),
                      error: (_, __) => const Text("Erro ao carregar"),
                    ),

                    const SizedBox(height: 50),

                    // --- GRID DE STATUS ---
                    stepsAsync.when(
                      data: (steps) {
                        final calories = (steps * 0.04).toInt();
                        final km = (steps * 0.00076).toStringAsFixed(2);
                        final minutes = (steps * 0.012).toInt();

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _StatItem(
                              value: "$calories",
                              unit: "kcal",
                              icon: Icons.local_fire_department_rounded,
                              color: Colors.orangeAccent,
                              theme: theme,
                            ),
                            _VerticalDivider(theme: theme),
                            _StatItem(
                              value: km,
                              unit: "km",
                              icon: Icons.map_rounded,
                              color: Colors.blueAccent,
                              theme: theme,
                            ),
                            _VerticalDivider(theme: theme),
                            _StatItem(
                              value: "$minutes",
                              unit: "min",
                              icon: Icons.timer_rounded,
                              color: Colors.purpleAccent,
                              theme: theme,
                            ),
                          ],
                        );
                      },
                      loading: () => const SizedBox(),
                      error: (_, __) => const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para abrir o diálogo de edição
  void _showEditGoalDialog(
      BuildContext context, WidgetRef ref, int currentGoal) {
    final controller = TextEditingController(text: currentGoal.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Definir Meta Diária"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          autofocus: true,
          decoration: const InputDecoration(
            labelText: "Passos",
            hintText: "Ex: 10000",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          FilledButton(
            onPressed: () {
              final newGoal = int.tryParse(controller.text);
              if (newGoal != null && newGoal > 0) {
                // Salva no provider (e no SharedPreferences)
                ref.read(stepGoalProvider.notifier).setGoal(newGoal);
                Navigator.pop(context);
              }
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }
}

// --- Componente do Anel Customizado ---

class _AnimatedRing extends StatelessWidget {
  final int current;
  final int target;
  final ThemeData theme;
  final VoidCallback onEditGoal; // Callback para editar

  const _AnimatedRing({
    required this.current,
    required this.target,
    required this.theme,
    required this.onEditGoal,
  });

  @override
  Widget build(BuildContext context) {
    // Evita divisão por zero e clamp
    final safeTarget = target > 0 ? target : 10000;
    final double percentage = (current / safeTarget).clamp(0.0, 1.0);

    return SizedBox(
      height: 320,
      width: 320,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. O Desenho do Anel
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: percentage),
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              final Color animatedColor = Color.lerp(
                  Colors.deepOrangeAccent, Colors.greenAccent.shade700, value)!;

              return CustomPaint(
                size: const Size(320, 320),
                painter: _ProgressRingPainter(
                  progress: value,
                  strokeWidth: 20,
                  backgroundColor: theme.colorScheme.surfaceContainerHighest
                      .withOpacity(0.3),
                  color: animatedColor,
                ),
              );
            },
          ),

          // 2. Conteúdo Central
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.directions_walk, size: 32, color: Colors.grey),
              const SizedBox(height: 8),
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: current),
                duration: const Duration(milliseconds: 1500),
                curve: Curves.easeOutExpo,
                builder: (context, value, _) {
                  return Text(
                    "$value",
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 64,
                      letterSpacing: -2,
                      height: 1,
                    ),
                  );
                },
              ),
              Text(
                "passos hoje",
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 16),

              // --- Pílula da Meta (Editável) ---
              InkWell(
                onTap: onEditGoal,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Meta: $target",
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.edit_rounded,
                          size: 14,
                          color: theme.colorScheme.onSurface.withOpacity(0.6)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- Painter (Igual ao anterior) ---
class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color color;

  _ProgressRingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final foregroundPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}

// --- Stats Widgets ---
class _StatItem extends StatelessWidget {
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final ThemeData theme;

  const _StatItem({
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            children: [
              TextSpan(
                  text: value,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              TextSpan(
                  text: " $unit",
                  style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  final ThemeData theme;
  const _VerticalDivider({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 1,
      color: theme.colorScheme.outlineVariant,
    );
  }
}
