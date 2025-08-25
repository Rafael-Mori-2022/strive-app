import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigorbloom/presentation/state/diet_providers.dart';
import 'package:vigorbloom/presentation/widgets/common_widgets.dart';

class AddFoodScreen extends ConsumerStatefulWidget {
  const AddFoodScreen({super.key});

  @override
  ConsumerState<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends ConsumerState<AddFoodScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final search = ref.watch(searchFoodsProvider(_query));
    final frequentes = ref.watch(frequentFoodsProvider);
    final recentes = ref.watch(recentFoodsProvider);
    final favoritos = ref.watch(favoriteFoodsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Alimento')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: SearchInput(hint: 'Buscar alimentos', onChanged: (v) => setState(() => _query = v)),
        ),
        TabBar(controller: _tabController, tabs: const [Tab(text: 'Frequentes'), Tab(text: 'Recentes'), Tab(text: 'Favoritos')]),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            _FoodList(provider: frequentes),
            _FoodList(provider: recentes),
            _FoodList(provider: favoritos),
          ]),
        ),
        if (_query.isNotEmpty)
          Expanded(child: search.when(
            data: (list) => _Results(list: list),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => const Center(child: Text('Erro na busca')),
          )),
      ]),
    );
  }
}

class _FoodList extends StatelessWidget {
  final AsyncValue provider;
  const _FoodList({required this.provider});

  @override
  Widget build(BuildContext context) {
    return provider.when(
      data: (list) => ListView.separated(
        padding: const EdgeInsets.all(12),
        itemBuilder: (_, i) {
          final item = list[i];
          return ListTile(
            leading: const Icon(Icons.fastfood, color: Colors.orange),
            title: Text(item.name),
            subtitle: Text('${item.calories.toStringAsFixed(0)} kcal'),
            trailing: IconButton(icon: const Icon(Icons.add_circle, color: Colors.green), onPressed: () {}),
          );
        },
        separatorBuilder: (_, __) => const Divider(height: 8),
        itemCount: list.length,
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => const Center(child: Text('Erro')),
    );
  }
}

class _Results extends StatelessWidget {
  final List list;
  const _Results({required this.list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: list.length,
      itemBuilder: (_, i) {
        final item = list[i];
        return ListTile(
          leading: const Icon(Icons.search, color: Colors.blue),
          title: Text(item.name),
          subtitle: Text('${item.calories.toStringAsFixed(0)} kcal'),
          trailing: IconButton(icon: const Icon(Icons.add_circle, color: Colors.green), onPressed: () {}),
        );
      },
    );
  }
}
