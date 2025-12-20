import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/di/service_locator.dart';
import 'package:strive/services/auth_service.dart';
import 'package:flutter/foundation.dart';

// Provider para o AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return sl<AuthService>();
});

// Provider para o Stream de Estado de Autenticação
final authStateStreamProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

// Provider para o Usuário Atual
final currentUserProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

// Helper para GoRouter
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
      _listener?.call(); 
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
