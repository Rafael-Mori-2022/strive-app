import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/di/service_locator.dart';
import 'package:strive/services/auth_service.dart';
import 'package:flutter/foundation.dart';

// 1. Provider para o AuthService
//    Ele lê o AuthService que foi registrado no GetIt (sl)
final authServiceProvider = Provider<AuthService>((ref) {
  // sl<AuthService>() funciona porque o main.dart chama
  // 'await setupServiceLocator()' ANTES do runApp()
  return sl<AuthService>();
});

// 2. Provider para o Stream de Estado de Autenticação
//    Este é o provider que sua LoginScreen precisa
final authStateStreamProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

// 3. (Opcional, mas útil) Provider para o Usuário Atual
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authServiceProvider).getCurrentUser();
});

// 4. Helper para GoRouter (você vai precisar disso na Fase 7.5)
class GoRouterRefreshStream extends AutoDisposeStreamNotifier<void>
    implements Listenable {
  late final StreamSubscription<dynamic> _subscription;
  VoidCallback? _listener;

  @override
  void addListener(VoidCallback listener) {
    _listener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    _listener = null;
  }

  @override
  Stream<void> build() {
    _subscription = ref.watch(authStateStreamProvider.stream).listen((_) {
      _listener?.call(); // Notifica o GoRouter para re-rotear
    });

    ref.onDispose(() {
      _subscription.cancel();
    });

    return const Stream.empty();
  }
}

// Provider para o GoRouterRefreshStream
final goRouterRefreshStreamProvider =
    AutoDisposeStreamNotifierProvider<GoRouterRefreshStream, void>(
  GoRouterRefreshStream.new,
);
