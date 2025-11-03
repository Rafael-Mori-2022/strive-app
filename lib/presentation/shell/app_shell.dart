import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const AppShell({super.key, required this.navigationShell});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int get _currentIndex => widget.navigationShell.currentIndex;

  void _onItemTapped(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pegamos a cor de fundo do tema para o Scaffold principal
    final backgroundColor = Theme.of(context).colorScheme.background;

    return Scaffold(
      backgroundColor: backgroundColor,
      // Usamos um Stack para posicionar o conteúdo e a navbar
      body: Stack(
        children: [
          // Conteúdo principal da tela
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: widget
                  .navigationShell, // Isso é a tela atual (Dashboard, Diet, etc.)
            ),
          ),
          // Barra de Navegação no fundo (flutuante)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _CustomBottomNavBar(
              currentIndex: _currentIndex,
              onTap: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}

// --- NOSSO WIDGET DE NAVEGAÇÃO CUSTOMIZADO ---
// (Agora vivendo permanentemente no AppShell)

class _CustomBottomNavBar extends StatelessWidget {
  const _CustomBottomNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueSetter<int> onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      // Estilização para parecer flutuante como nos protótipos
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      color: colors.surface,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Arredondado
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _BottomNavItem(
              icon: Icons.home_filled,
              isActive: currentIndex == 0,
              onTap: () => onTap(0), // Aba 0
            ),
            _BottomNavItem(
              icon: Icons.restaurant_menu_rounded,
              isActive: currentIndex == 1,
              onTap: () => onTap(1), // Aba 1
            ),
            _BottomNavItem(
              icon: Icons.fitness_center_rounded,
              isActive: currentIndex == 2,
              onTap: () => onTap(2), // Aba 2
            ),
            _BottomNavItem(
              icon: Icons.grid_view_rounded, // Ícone de EXPLORAR
              isActive: currentIndex == 3,
              onTap: () => onTap(3), // Aba 3
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    this.isActive = false,
    this.onTap,
  });
  final IconData icon;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Icon(
        icon,
        size: 30,
        color: isActive ? colors.primary : colors.onSurfaceVariant,
      ),
    );
  }
}
