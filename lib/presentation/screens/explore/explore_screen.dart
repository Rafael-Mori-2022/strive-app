import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/i18n/strings.g.dart'; // Importação do Slang

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Lista de itens com Strings traduzidas
    final exploreItems = [
      {
        'title': t.explore.categories.activity, // "Atividade"
        'icon': Icons.local_fire_department,
        'color': const Color(0xFFFF8A65),
        'route': '/workout'
      },
      {
        'title': t.explore.categories.nutrition, // "Alimentação"
        'icon': Icons.restaurant_rounded,
        'color': const Color(0xFFFACC15),
        'route': '/diet'
      },
      {
        'title': t.explore.categories.sleep, // "Sono"
        'icon': Icons.bed_rounded,
        'color': Colors.blue.shade300,
        'route': '/sleep'
      },
      {
        'title': t.explore.categories.medication, // "Medicamentos"
        'icon': Icons.medication_rounded,
        'color': Colors.cyan.shade300,
        'route': '/medicine'
      },
      {
        'title': t.explore.categories.body_measurements, // "Medidas Corporais"
        'icon': Icons.accessibility_new_rounded,
        'color': Colors.red.shade300,
        'route': '/body'
      },
      {
        'title': t.explore.categories.mobility, // "Mobilidade"
        'icon': Icons.directions_walk_rounded,
        'color': const Color(0xFFFACC15),
        'route': '/activity'
      },
    ];

    // Lógica de Filtragem (Funciona igual, agora buscando no texto traduzido)
    final filteredItems = exploreItems.where((item) {
      final title = item['title'] as String;
      return title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: theme.colorScheme.background, // Mantido original
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            const SizedBox(height: 16),
            // 2. Barra de Busca
            _SearchBar(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 24),
            // 3. Título "Explorar"
            Text(
              t.explore.title,
              style: theme.textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            // 4. Renderização da Lista Filtrada
            if (filteredItems.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Center(
                  child: Text(
                    t.explore.not_found, // "Nenhuma funcionalidade encontrada."
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              )
            else
              Column(
                children: filteredItems
                    .map((item) => _CategoryRow(
                          title: item['title'] as String,
                          icon: item['icon'] as IconData,
                          iconColor: item['color'] as Color,
                          // Passamos a rota para o widget
                          onTap: () => context.go(item['route'] as String),
                        ))
                    .toList(),
              ),

            const SizedBox(height: 100), // Espaço extra para o final da lista
          ],
        ),
      ),
    );
  }
}

// --- WIDGETS PRIVADOS ---

class _SearchBar extends StatelessWidget {
  // Adicionamos o parâmetro onChanged
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: t.explore.search_hint, // "Buscar funcionalidade"
        hintStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant),
        prefixIcon:
            Icon(Icons.search, color: theme.colorScheme.onSurfaceVariant),
        filled: true,
        fillColor:
            theme.colorScheme.surfaceContainerHighest, // Mantido original
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerLow, // Mantido original
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(title,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w500)),
              ),
              Icon(Icons.chevron_right,
                  color: theme.colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
