import 'package:strive/domain/entities/category.dart';

abstract class ExploreRepository {
  Future<List<ExploreCategory>> getCategories();
}
