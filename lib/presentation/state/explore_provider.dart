import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/di/service_locator.dart';
import 'package:strive/domain/entities/category.dart';
import 'package:strive/domain/repositories/explore_repository.dart';

final exploreRepositoryProvider =
    Provider<ExploreRepository>((ref) => sl<ExploreRepository>());

final exploreCategoriesProvider = FutureProvider<List<ExploreCategory>>(
    (ref) async => ref.read(exploreRepositoryProvider).getCategories());
