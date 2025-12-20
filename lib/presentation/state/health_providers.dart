import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/monitor/health_monitoring_service.dart';

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
