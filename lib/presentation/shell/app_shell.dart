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
    final backgroundColor = Theme.of(context).colorScheme.background;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: widget
                  .navigationShell, // Tela atual
            ),
          ),
          // Barra de Navegação 
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
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      color: colors.surface,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), 
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _BottomNavItem(
              icon: Icons.home_filled,
              isActive: currentIndex == 0,
              onTap: () => onTap(0), 
            ),
            _BottomNavItem(
              icon: Icons.restaurant_menu_rounded,
              isActive: currentIndex == 1,
              onTap: () => onTap(1), 
            ),
            _BottomNavItem(
              icon: Icons.fitness_center_rounded,
              isActive: currentIndex == 2,
              onTap: () => onTap(2), 
            ),
            _BottomNavItem(
              icon: Icons.grid_view_rounded, 
              isActive: currentIndex == 3,
              onTap: () => onTap(3), 
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
