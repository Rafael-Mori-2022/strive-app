import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/presentation/state/profile_providers.dart';
import 'package:strive/presentation/widgets/common_widgets.dart';
import 'package:strive/providers/auth_providers.dart';
import 'package:strive/providers/theme_provider.dart';
import 'package:strive/i18n/strings.g.dart'; // Importação do Slang

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  // Configuração dos idiomas suportados
  static final List<Map<String, dynamic>> _languages = [
    {'locale': AppLocale.pt, 'label': 'Português', 'flag': '🇧🇷'},
    {'locale': AppLocale.en, 'label': 'English', 'flag': '🇺🇸'},
    {'locale': AppLocale.fr, 'label': 'Français', 'flag': '🇫🇷'},
    {'locale': AppLocale.it, 'label': 'Italiano', 'flag': '🇮🇹'},
    {'locale': AppLocale.es, 'label': 'Español', 'flag': '🇪🇸'},
  ];

  void _showLanguageSelector(BuildContext context) {
    final currentLocale = LocaleSettings.currentLocale;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(
                "Selecione o Idioma / Select Language",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ..._languages.map((lang) {
                final AppLocale thisLocale = lang['locale'];
                final bool isSelected = currentLocale == thisLocale;

                return ListTile(
                  leading: Text(
                    lang['flag'],
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(lang['label']),
                  trailing: isSelected
                      ? Icon(Icons.check_circle,
                          color: Theme.of(context).colorScheme.primary)
                      : null,
                  onTap: () {
                    // Troca o idioma globalmente
                    LocaleSettings.setLocale(thisLocale);
                    Navigator.pop(ctx); // Fecha o modal
                  },
                );
              }),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);
    final currentTheme = ref.watch(themeProvider);
    final isDarkMode = currentTheme == ThemeMode.dark;

    // Escuta mudanças de idioma para reconstruir a tela
    final currentLocaleEnum = TranslationProvider.of(context).flutterLocale;

    // Encontra a bandeira atual para exibir no botão
    // (Lógica simples convertendo o locale do flutter de volta para o mapa)
    final currentFlag = _languages.firstWhere(
      (l) =>
          (l['locale'] as AppLocale).languageCode ==
          currentLocaleEnum.languageCode,
      orElse: () => _languages[0],
    )['flag'];

    return Scaffold(
      appBar: AppBar(title: Text(t.profile.title)),
      body: profile.when(
        data: (p) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // --- HEADER DO PERFIL ---
            Row(children: [
              CircleAvatar(
                  radius: 28, child: Text(p.name.isNotEmpty ? p.name[0] : '?')),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(p.name, style: Theme.of(context).textTheme.titleLarge),
                Text(t.profile.stats_format(
                    age: p.age,
                    height: p.heightCm.toStringAsFixed(0),
                    weight: p.weightKg.toStringAsFixed(1))),
              ])
            ]),

            const SizedBox(height: 24),

            // --- BLOCO DE CONFIGURAÇÕES ---
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceVariant
                    .withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Switch de Tema
                  SwitchListTile(
                    title: Text(t.profile.dark_mode),
                    secondary: Icon(
                      isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    value: isDarkMode,
                    onChanged: (val) {
                      ref.read(themeProvider.notifier).toggleTheme(val);
                    },
                  ),

                  Divider(
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                      color: Colors.grey.withOpacity(0.2)),

                  // SELETOR DE IDIOMA
                  ListTile(
                    leading: Icon(Icons.language,
                        color: Theme.of(context).colorScheme.primary),
                    title: const Text("Idioma / Language"),
                    // Mostra a bandeira do idioma atual
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withOpacity(0.2))),
                      child: Text(
                        currentFlag, // Exibe 🇧🇷 ou 🇺🇸 etc.
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    onTap: () => _showLanguageSelector(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // --- OUTRAS OPÇÕES ---
            ListTile(
                leading: const Icon(Icons.edit),
                title: Text(t.profile.edit_profile),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/profile/edit')),
            const SizedBox(height: 24),

            PrimaryButton(
                label: t.profile.view_leaderboard,
                leadingIcon: Icons.emoji_events,
                onPressed: () => context.push('/dashboard/leaderboard'),
                isExpanded: true),
            const SizedBox(height: 24),

            OutlinedButton.icon(
              icon: const Icon(Icons.logout),
              label: Text(t.profile.logout),
              onPressed: () {
                ref.read(authServiceProvider).signOut();
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
              ),
            )
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(t.profile.not_found),
            const SizedBox(height: 12),
            SecondaryButton(
                label: t.profile.create_profile,
                leadingIcon: Icons.person_add,
                onPressed: () => context.push('/onboarding')),
          ]),
        ),
      ),
    );
  }
}
