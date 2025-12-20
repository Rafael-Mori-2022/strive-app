import 'dart:async';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class HealthMonitoringService {
  // Singleton
  static final HealthMonitoringService _instance =
      HealthMonitoringService._internal();
  factory HealthMonitoringService() => _instance;
  HealthMonitoringService._internal();

  // ATENÇÃO: Na versão 10+, a classe é apenas 'Health'
  final Health _health = Health();

  // Limite para o alerta (ex: 120 bpm)
  final int _safeHeartRateLimit = 120;

  // Stream para a UI
  final _heartRateController = StreamController<int>.broadcast();
  Stream<int> get heartRateStream => _heartRateController.stream;

  bool _isMonitoring = false;
  Timer? _pollingTimer;

  // Definindo tipos específicos para iOS
  final List<HealthDataType> _types = [
    HealthDataType.STEPS,
    HealthDataType.HEART_RATE,
  ];

  /// Inicializa permissões e notificações
  Future<bool> initialize() async {
    // Mantém a tela ligada (Vital para iOS não matar o app)
    await WakelockPlus.enable();

    // Configura notificações locais
    await _initNotifications();

    // Requisita acesso ao HealthKit
    // No iOS, se o usuário negar, o requestAuthorization retorna true mas não dá dados.
    // É uma medida de privacidade da Apple (você não sabe que foi bloqueado).
    bool requested = await _health.requestAuthorization(_types);

    return requested;
  }

  /// Inicia o loop de leitura
  void startVitalMonitoring() {
    if (_isMonitoring) return;
    _isMonitoring = true;
    print("iOS Health Service: Iniciando monitoramento...");

    // pollingTimer: HealthKit não envia stream em tempo real para apps terceiros
    // passivamente. Precisamos perguntar "tem algo novo?" periodicamente.
    // 5 segundos é um bom equilíbrio.
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await _fetchLatestHeartRate();
    });
  }

  void stopMonitoring() {
    _isMonitoring = false;
    _pollingTimer?.cancel();
    WakelockPlus.disable(); // Deixa a tela apagar
    print("iOS Health Service: Parado.");
  }

  /// Busca o batimento mais recente no HealthKit
  Future<void> _fetchLatestHeartRate() async {
    try {
      final now = DateTime.now();
      // Olha para os últimos 5 minutos
      final startTime = now.subtract(const Duration(minutes: 5));

      // Busca dados
      List<HealthDataPoint> data = await _health.getHealthDataFromTypes(
        startTime: startTime,
        endTime: now,
        types: [HealthDataType.HEART_RATE],
      );

      // Remove duplicatas e ordena
      data = _health.removeDuplicates(data);

      if (data.isNotEmpty) {
        data.sort((a, b) => b.dateTo.compareTo(a.dateTo));
        final latestPoint = data.first;

        // Extrai o valor (HealthValueNumeric)
        // No iOS HealthKit, o valor geralmente vem como double
        final value = latestPoint.value as NumericHealthValue;
        final double bpm = value.numericValue.toDouble();

        print("HealthKit LATEST BPM: $bpm");

        // Envia para a UI
        _heartRateController.add(bpm.toInt());

        // Lógica de Alerta
        if (bpm > _safeHeartRateLimit) {
          _triggerCriticalAlert(bpm.toInt());
        }
      } else {
        // Debug: útil para saber se o HealthKit está vazio
        // print("HealthKit: Nenhum batimento recente encontrado.");
      }
    } catch (e) {
      print("Erro HealthKit: $e");
    }
  }

  /// Busca o total de passos do dia (HealthKit calcula automaticamente)
  Future<int> getDailySteps() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    try {
      int? steps = await _health.getTotalStepsInInterval(midnight, now);
      return steps ?? 0;
    } catch (e) {
      print("Erro ao ler passos: $e");
      return 0;
    }
  }

  // --- Notificações Locais (Configuração Padrão) ---
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> _initNotifications() async {
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(iOS: iosSettings);
    await _notifications.initialize(settings);
  }

  Future<void> _triggerCriticalAlert(int bpm) async {
    // Previne spam de notificações (opcional: adicionar lógica de debounce aqui)
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      sound: 'default', // Ou um som de alarme customizado
      interruptionLevel: InterruptionLevel
          .critical, // Requer entitlement especial, use .active ou .timeSensitive se der erro
    );

    const details = NotificationDetails(iOS: iosDetails);

    await _notifications.show(
      1, // ID fixo
      'ALERTA CARDÍACO',
      'Frequência alta detectada: $bpm BPM',
      details,
    );
  }
}
