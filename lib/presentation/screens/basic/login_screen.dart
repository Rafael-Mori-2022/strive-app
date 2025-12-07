import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/i18n/strings.g.dart'; // O arquivo gerado pelo Slang
import 'package:strive/providers/auth_providers.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateStreamProvider);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Stack(
        children: [
          // Imagem de fundo
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=1000&auto=format&fit=crop',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(color: colors.surface);
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(color: colors.surface);
              },
            ),
          ),

          // Gradiente
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colors.surface.withOpacity(0.3),
                    colors.surface.withOpacity(0.8),
                    colors.surface,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 3),

                  // Ícone
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border:
                          Border.all(color: colors.primary.withOpacity(0.2)),
                    ),
                    child: Icon(
                      Icons.shield_rounded,
                      size: 48,
                      color: colors.primary,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Título do App (Mantido Hardcoded por ser Marca)
                  Text(
                    "Strive",
                    style: theme.textTheme.displayLarge?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.5,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Tagline traduzida
                  Text(
                    t.login.tagline,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      height: 1.3,
                    ),
                  ),

                  const Spacer(flex: 2),

                  if (authState.isLoading)
                    Center(
                      child: CircularProgressIndicator(color: colors.primary),
                    )
                  else
                    _GoogleSignInButton(
                      onPressed: () {
                        ref.read(authServiceProvider).signInWithGoogle();
                      },
                    ),

                  const SizedBox(height: 32),

                  // Termos traduzidos
                  Center(
                    child: Text(
                      t.login.terms_disclaimer, // Nota: snake_case aqui
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _GoogleSignInButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          elevation: 4,
          shadowColor: colors.primary.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.g_mobiledata_rounded,
                color: Colors.black,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            // Texto do botão traduzido
            Text(
              t.login.google_button, // Nota: snake_case aqui
              style: textTheme.titleMedium?.copyWith(
                color: colors.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
