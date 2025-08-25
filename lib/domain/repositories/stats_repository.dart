import 'package:vigorbloom/domain/entities/stat_item.dart';

abstract class StatsRepository {
  Future<List<StatItem>> getAvailableStats();
  Future<List<String>> getSelectedStatIds();
  Future<void> setSelectedStatIds(List<String> ids);
}
