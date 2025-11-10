import 'dart:async';
import 'package:strive/domain/entities/category.dart';
import 'package:strive/domain/repositories/explore_repository.dart';

class MockExploreRepository implements ExploreRepository {
  @override
  Future<List<ExploreCategory>> getCategories() async {
    return const [
      ExploreCategory(
          id: 'c1',
          title: 'Nutrição',
          tags: ['macros', 'hidratação', 'receitas']),
      ExploreCategory(
          id: 'c2',
          title: 'Treino',
          tags: ['hipertrofia', 'força', 'mobilidade']),
      ExploreCategory(id: 'c3', title: 'Sono', tags: ['higiene', 'ciclo']),
      ExploreCategory(
          id: 'c4', title: 'Mindfulness', tags: ['respiração', 'foco']),
    ];
  }
}
