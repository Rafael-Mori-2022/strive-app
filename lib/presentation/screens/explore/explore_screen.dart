import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/i18n/strings.g.dart';

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

    final exploreItems = [
      {
        'title': t.explore.categories.activity,
        'icon': Icons.local_fire_department,
        'color': const Color(0xFFFF8A65),
        'route': '/workout'
      },
      {
        'title': t.explore.categories.nutrition,
        'icon': Icons.restaurant_rounded,
        'color': const Color(0xFFFACC15),
        'route': '/diet'
      },
      {
        'title': t.explore.categories.sleep,
        'icon': Icons.bed_rounded,
        'color': Colors.blue.shade300,
        'route': '/sleep'
      },
      {
        'title': t.explore.categories.medication,
        'icon': Icons.medication_rounded,
        'color': Colors.cyan.shade300,
        'route': '/medicine'
      },
      {
        'title': t.explore.categories.body_measurements,
        'icon': Icons.accessibility_new_rounded,
        'color': Colors.red.shade300,
        'route': '/body'
      },
      {
        'title': t.explore.categories.mobility,
        'icon': Icons.directions_walk_rounded,
        'color': const Color(0xFFFACC15),
        'route': '/steps'
      },
    ];

    // Lógica de Filtragem
    final filteredItems = exploreItems.where((item) {
      final title = item['title'] as String;
      return title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            const SizedBox(height: 16),
            _SearchBar(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 24),
            Text(
              t.explore.title,
              style: theme.textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            if (filteredItems.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Center(
                  child: Text(
                    t.explore.not_found,
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
                          onTap: () => context.push(item['route'] as String),
                        ))
                    .toList(),
              ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

// --- Widgets Privados ---

class _SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: t.explore.search_hint,
        hintStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant),
        prefixIcon:
            Icon(Icons.search, color: theme.colorScheme.onSurfaceVariant),
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest,
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
            color: theme.colorScheme.surfaceContainerLow,
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
