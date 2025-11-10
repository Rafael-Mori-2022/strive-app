import 'package:strive/domain/entities/stat_item.dart';

abstract class StatsRepository {
  Future<List<StatItem>> getAvailableStats(String uid);
  Future<List<String>> getSelectedStatIds(String uid);
  Future<void> setSelectedStatIds(String uid, List<String> ids);
}
