import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strive/monitor/health_monitoring_service.dart';

final criticalAlertStreamProvider = StreamProvider<int>((ref) {
  final service = ref.watch(healthServiceProvider);
  return service.criticalAlertStream;
});

// 1. Instância do Serviço
final healthServiceProvider = Provider<HealthMonitoringService>((ref) {
  return HealthMonitoringService();
});

// 2. Stream do Coração (UI escuta isso)
final heartRateProvider = StreamProvider.autoDispose<int>((ref) {
  final service = ref.watch(healthServiceProvider);
  return service.heartRateStream;
});

// 3. Passos (Future)
final stepsProvider = FutureProvider.autoDispose<int>((ref) async {
  final service = ref.watch(healthServiceProvider);
  return await service.getDailySteps();
});

// 4. Controller (Liga/Desliga tudo)
// Coloque: ref.watch(healthControllerProvider) dentro do build da Dashboard
final healthControllerProvider = FutureProvider.autoDispose<bool>((ref) async {
  final service = ref.watch(healthServiceProvider);

  final authorized = await service.initialize();

  if (authorized) {
    service.startVitalMonitoring();

    // Cleanup quando sair da tela
    ref.onDispose(() {
      service.stopMonitoring();
    });
  }

  return authorized;
});

final stepGoalProvider = StateNotifierProvider<StepGoalNotifier, int>((ref) {
  return StepGoalNotifier();
});

class StepGoalNotifier extends StateNotifier<int> {
  StepGoalNotifier() : super(10000) {
    // Valor padrão inicial
    _loadGoal();
  }

  Future<void> _loadGoal() async {
    final prefs = await SharedPreferences.getInstance();
    // Tenta ler do disco, se não existir, mantém 10000
    state = prefs.getInt('daily_step_goal') ?? 10000;
  }

  Future<void> setGoal(int newGoal) async {
    state = newGoal; // Atualiza a UI instantaneamente
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('daily_step_goal', newGoal); // Salva no disco
  }
}
