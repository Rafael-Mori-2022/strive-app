import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigorbloom/presentation/state/explore_provider.dart';
import 'package:vigorbloom/presentation/widgets/common_widgets.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  String _query = '';
  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(exploreCategoriesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Explorar')),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(16), child: SearchInput(hint: 'Buscar temas de saúde', onChanged: (v) => setState(() => _query = v))),
        Expanded(
          child: categories.when(
            data: (list) {
              final filtered = _query.isEmpty ? list : list.where((c) => c.title.toLowerCase().contains(_query.toLowerCase()) || c.tags.any((t) => t.toLowerCase().contains(_query.toLowerCase()))).toList();
              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const Divider(height: 8),
                itemBuilder: (_, i) {
                  final c = filtered[i];
                  return ListTile(
                    leading: const Icon(Icons.category, color: Colors.purple),
                    title: Text(c.title),
                    subtitle: Wrap(spacing: 8, children: c.tags.map((t) => Chip(label: Text(t))).toList()),
                    onTap: () {},
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => const Center(child: Text('Erro ao carregar categorias')),
          ),
        ),
      ]),
    );
  }
}
