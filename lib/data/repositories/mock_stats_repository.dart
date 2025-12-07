import 'dart:async';
import 'package:flutter/material.dart';
import 'package:strive/domain/entities/stat_item.dart';
import 'package:strive/domain/repositories/stats_repository.dart';
import 'package:strive/i18n/strings.g.dart'; // Importação do Slang

class MockStatsRepository implements StatsRepository {
  List<String> _selected = ['calories', 'water', 'steps', 'sleep'];

  @override
  Future<List<StatItem>> getAvailableStats(String uid) async {
    // Removido 'const' para permitir tradução dinâmica
    return [
      StatItem(
          id: 'calories',
          title: t.mock.stats.calories, // "Calorias"
          value: '1,420 kcal',
          icon: Icons.local_fire_department),
      StatItem(
          id: 'protein',
          title: t.mock.stats.protein, // "Proteína"
          value: '95 g',
          icon: Icons.egg),
      StatItem(
          id: 'carbs',
          title: t.mock.stats.carbs, // "Carbo"
          value: '180 g',
          icon: Icons.breakfast_dining),
      StatItem(
          id: 'fat',
          title: t.mock.stats.fat, // "Gordura"
          value: '50 g',
          icon: Icons.bubble_chart),
      StatItem(
          id: 'water',
          title: t.mock.stats.water, // "Água"
          value: '1.8 L',
          icon: Icons.water_drop),
      StatItem(
          id: 'steps',
          title: t.mock.stats.steps, // "Passos"
          value: '7,230',
          icon: Icons.directions_walk),
      StatItem(
          id: 'sleep',
          title: t.mock.stats.sleep, // "Sono"
          value: '7h 10m',
          icon: Icons.nightlight_round),
    ];
  }

  @override
  Future<List<String>> getSelectedStatIds(String uid) async => _selected;
  @override
  Future<void> setSelectedStatIds(String uid, List<String> ids) async {
    _selected = ids;
  }
}
