import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/presentation/state/profile_providers.dart';
import 'package:strive/presentation/widgets/common_widgets.dart';
import 'package:strive/providers/auth_providers.dart';
import 'package:strive/providers/theme_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);
    final currentTheme = ref.watch(themeProvider);
    final isDarkMode = currentTheme == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: profile.when(
        data: (p) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(children: [
              CircleAvatar(
                  radius: 28, child: Text(p.name.isNotEmpty ? p.name[0] : '?')),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(p.name, style: Theme.of(context).textTheme.titleLarge),
                Text(
                    '${p.age} anos • ${p.heightCm.toStringAsFixed(0)} cm • ${p.weightKg.toStringAsFixed(1)} kg'),
              ])
            ]),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceVariant
                    .withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                title: const Text('Modo Escuro'),
                secondary: Icon(
                  isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).colorScheme.primary,
                ),
                value: isDarkMode,
                onChanged: (val) {
                  ref.read(themeProvider.notifier).toggleTheme(val);
                },
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Atualizar perfil'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/profile/edit')),
            const SizedBox(height: 24),
            PrimaryButton(
                label: 'Ver Leaderboard',
                leadingIcon: Icons.emoji_events,
                onPressed: () => context.push('/dashboard/leaderboard'),
                isExpanded: true),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              icon: Icon(Icons.logout),
              label: Text('Sair (Logout)'),
              onPressed: () {
                ref.read(authServiceProvider).signOut();
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: BorderSide(color: Colors.red),
              ),
            )
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('Perfil não encontrado'),
            const SizedBox(height: 12),
            SecondaryButton(
                label: 'Criar perfil',
                leadingIcon: Icons.person_add,
                onPressed: () => context.push('/onboarding')),
          ]),
        ),
      ),
    );
  }
}
