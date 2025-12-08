import 'dart:async';
import 'package:strive/domain/entities/category.dart';
import 'package:strive/domain/repositories/explore_repository.dart';
import 'package:strive/i18n/strings.g.dart'; 

class MockExploreRepository implements ExploreRepository {
  @override
  Future<List<ExploreCategory>> getCategories() async {
    return [
      ExploreCategory(
          id: 'c1',
          title: t.mock.explore.nutrition, // "Nutrição"
          tags: [
            t.mock.explore.tags.macros,
            t.mock.explore.tags.hydration,
            t.mock.explore.tags.recipes
          ]),
      ExploreCategory(
          id: 'c2',
          title: t.mock.explore.training, // "Treino"
          tags: [
            t.mock.explore.tags.hypertrophy,
            t.mock.explore.tags.strength,
            t.mock.explore.tags.mobility
          ]),
      ExploreCategory(
          id: 'c3',
          title: t.mock.explore.sleep, // "Sono"
          tags: [t.mock.explore.tags.hygiene, t.mock.explore.tags.cycle]),
      ExploreCategory(
          id: 'c4',
          title: t.mock.explore.mindfulness, // "Mindfulness"
          tags: [t.mock.explore.tags.breathing, t.mock.explore.tags.focus]),
    ];
  }
}
