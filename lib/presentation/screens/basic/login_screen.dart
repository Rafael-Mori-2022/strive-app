import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/providers/auth_providers.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Strive Login"),
      ),
      body: Center(
        child: authState.isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text("Entrar com Google"),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  ref.read(authServiceProvider).signInWithGoogle();
                },
              ),
      ),
    );
  }
}
