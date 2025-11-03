import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Removidas as providers não utilizadas, você pode adicionar de volta se precisar
// import 'package:vigorbloom/presentation/state/explore_provider.dart';
// import 'package:vigorbloom/presentation/widgets/common_widgets.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  // final String _query = ''; // Você pode reativar isso para o filtro

  @override
  Widget build(BuildContext context) {
    // final categories = ref.watch(exploreCategoriesProvider); // Você pode reativar
    final theme = Theme.of(context);

    // Lista de itens hardcoded para bater com o protótipo
    final exploreItems = [
      {
        'title': 'Atividade',
        'icon': Icons.local_fire_department,
        'color': const Color(0xFFFF8A65)
      },
      {
        'title': 'Alimentação',
        'icon': Icons.restaurant_rounded,
        'color': const Color(0xFFFACC15)
      },
      {
        'title': 'Bem-estar Mental',
        'icon': Icons.psychology,
        'color': Colors.green.shade300
      },
      {
        'title': 'Sono',
        'icon': Icons.bed_rounded,
        'color': Colors.blue.shade300
      },
      {
        'title': 'Medicamentos',
        'icon': Icons.medication_rounded,
        'color': Colors.cyan.shade300
      },
      {
        'title': 'Medidas Corporais',
        'icon': Icons.accessibility_new_rounded,
        'color': Colors.red.shade300
      },
      {
        'title': 'Mobilidade',
        'icon': Icons.directions_walk_rounded,
        'color': const Color(0xFFFACC15)
      },
      {
        'title': 'Controle de Ciclo',
        'icon': Icons.water_drop_outlined,
        'color': Colors.pink.shade300
      },
    ];

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      // 1. Sem AppBar
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            const SizedBox(height: 16),
            // 2. Barra de Busca
            const _SearchBar(),
            const SizedBox(height: 24),
            // 3. Título "Explorar"
            Text(
              'Explorar',
              style: theme.textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            // 4. Lista de Categorias
            // Substituí seu ListView.separated por isto:
            Column(
              children: exploreItems
                  .map((item) => _CategoryRow(
                        title: item['title'] as String,
                        icon: item['icon'] as IconData,
                        iconColor: item['color'] as Color,
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            // 5. A BARRA DE NAVEGAÇÃO CORRIGIDA
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// --- WIDGETS PRIVADOS DA TELA EXPLORAR ---

// 2. Barra de Busca
class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      // onChanged: (v) => setState(() => _query = v), // Reative para o filtro
      decoration: InputDecoration(
        hintText: 'Buscar',
        hintStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant),
        prefixIcon:
            Icon(Icons.search, color: theme.colorScheme.onSurfaceVariant),
        filled: true,
        fillColor: theme.colorScheme.surfaceVariant, // Cor de fundo do tema
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

// 4. Linha de Categoria (Estilo do protótipo)
class _CategoryRow extends StatelessWidget {
  const _CategoryRow(
      {required this.title, required this.icon, required this.iconColor});
  final String title;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: () {
          // Navega para a tela de placeholder usando o Navigator padrão.
          // O GoRouter ainda gerencia a pilha de navegação (como o botão "voltar").
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => _PlaceholderScreen(title: title),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface, // Cor de card
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 16),
              Text(title, style: theme.textTheme.titleMedium),
              const Spacer(),
              Icon(Icons.chevron_right,
                  color: theme.colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'Página "$title" ainda não implementada.',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
