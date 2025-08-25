import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vigorbloom/domain/entities/stat_item.dart';
import 'package:vigorbloom/domain/repositories/stats_repository.dart';

class MockStatsRepository implements StatsRepository {
  List<String> _selected = ['calories', 'water', 'steps', 'sleep'];

  @override
  Future<List<StatItem>> getAvailableStats() async => const [
        StatItem(id: 'calories', title: 'Calorias', value: '1,420 kcal', icon: Icons.local_fire_department),
        StatItem(id: 'protein', title: 'Proteína', value: '95 g', icon: Icons.egg),
        StatItem(id: 'carbs', title: 'Carbo', value: '180 g', icon: Icons.breakfast_dining),
        StatItem(id: 'fat', title: 'Gordura', value: '50 g', icon: Icons.bubble_chart),
        StatItem(id: 'water', title: 'Água', value: '1.8 L', icon: Icons.water_drop),
        StatItem(id: 'steps', title: 'Passos', value: '7,230', icon: Icons.directions_walk),
        StatItem(id: 'sleep', title: 'Sono', value: '7h 10m', icon: Icons.nightlight_round),
      ];

  @override
  Future<List<String>> getSelectedStatIds() async => _selected;

  @override
  Future<void> setSelectedStatIds(List<String> ids) async {
    _selected = ids;
  }
}
