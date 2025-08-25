import 'package:vigorbloom/domain/entities/category.dart';

abstract class ExploreRepository {
  Future<List<ExploreCategory>> getCategories();
}
