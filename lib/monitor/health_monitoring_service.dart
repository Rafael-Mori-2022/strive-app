import 'dart:async';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class HealthMonitoringService {
  static final HealthMonitoringService _instance =
      HealthMonitoringService._internal();
  factory HealthMonitoringService() => _instance;
  HealthMonitoringService._internal();

  final Health _health = Health();

  // Limites e Configurações
  final int _safeHeartRateLimit = 120;

  // COOLDOWN: Tempo mínimo entre dois alertas (ex: 1 minuto)
  final Duration _alertCooldown = const Duration(minutes: 1);
  DateTime? _lastAlertTime; // Guarda quando foi o último grito

  final _heartRateController = StreamController<int>.broadcast();
  Stream<int> get heartRateStream => _heartRateController.stream;

  final _criticalAlertController = StreamController<int>.broadcast();
  Stream<int> get criticalAlertStream => _criticalAlertController.stream;

  bool _isMonitoring = false;
  Timer? _pollingTimer;

  final List<HealthDataType> _types = [
    HealthDataType.STEPS,
    HealthDataType.HEART_RATE,
  ];

  Future<bool> initialize() async {
    await WakelockPlus.enable();
    await _initNotifications();
    bool requested = await _health.requestAuthorization(_types);
    return requested;
  }

  void startVitalMonitoring() {
    if (_isMonitoring) return;
    _isMonitoring = true;
    print("Health Service: Iniciando monitoramento...");

    // Timer de 5 segundos para leitura
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await _fetchLatestHeartRate();
    });
  }

  void stopMonitoring() {
    _isMonitoring = false;
    _pollingTimer?.cancel();
    WakelockPlus.disable();
    print("Health Service: Parado.");
  }

  Future<void> _fetchLatestHeartRate() async {
    try {
      final now = DateTime.now();
      // Janela curta (5 min) para focar no "agora"
      final startTime = now.subtract(const Duration(minutes: 5));

      List<HealthDataPoint> data = await _health.getHealthDataFromTypes(
        startTime: startTime,
        endTime: now,
        types: [HealthDataType.HEART_RATE],
      );

      // IMPORTANTE: Removemos o removeDuplicates() para não perder dados rápidos
      // data = _health.removeDuplicates(data);

      if (data.isNotEmpty) {
        // Ordena pelo final da leitura (dateTo) decrescente
        data.sort((a, b) => b.dateTo.compareTo(a.dateTo));

        final latestPoint = data.first;
        final value = latestPoint.value as NumericHealthValue;
        final double bpm = value.numericValue.toDouble();
        final bpmInt = bpm.toInt();

        // --- CORREÇÃO: LOG GERAL ---
        // Agora este print roda SEMPRE, independente do valor
        print(
            "[Monitor] Leitura: $bpmInt BPM (Horário: ${latestPoint.dateTo.hour}:${latestPoint.dateTo.minute}:${latestPoint.dateTo.second})");
        // ---------------------------

        // Atualiza a tela
        _heartRateController.add(bpmInt);

        // Só entra aqui se for CRÍTICO
        if (bpmInt > _safeHeartRateLimit) {
          _checkAndTriggerAlert(bpmInt);
        }
      } else {
        // Log opcional para saber que o timer está rodando mas sem dados
        // print("... (sem dados recentes no HealthKit)");
      }
    } catch (e) {
      print("Erro no HealthKit: $e");
    }
  }

  /// Verifica se pode alertar (Cooldown) antes de disparar
  Future<void> _checkAndTriggerAlert(int bpm) async {
    final now = DateTime.now();
    if (_lastAlertTime == null ||
        now.difference(_lastAlertTime!) > _alertCooldown) {
      print("ALERTA CRÍTICO: $bpm BPM");

      // 2. DISPARA O EVENTO PARA A UI (POPUP)
      _criticalAlertController.add(bpm);

      // Dispara a notificação do sistema (Banner)
      await _triggerCriticalAlert(bpm);

      _lastAlertTime = now;
    }
  }

  Future<int> getDailySteps() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    try {
      int? steps = await _health.getTotalStepsInInterval(midnight, now);
      return steps ?? 0;
    } catch (e) {
      return 0;
    }
  }

  // --- Notificações ---
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> _initNotifications() async {
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(iOS: iosSettings);
    await _notifications.initialize(settings);
  }

  Future<void> _triggerCriticalAlert(int bpm) async {
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBanner: true,
      sound: 'default',
      interruptionLevel:
          InterruptionLevel.active, // Fura o silêncio se possível
    );

    const details = NotificationDetails(iOS: iosDetails);

    await _notifications.show(
      666,
      'ALERTA DE TAQUICARDIA',
      'Seus batimentos atingiram $bpm BPM. Diminua o ritmo.',
      details,
    );
  }
}
