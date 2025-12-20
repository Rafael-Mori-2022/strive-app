import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

// Tipos visuais para facilitar a identificação
enum MedicineType { pill, liquid, injection, inhaler, supplement }

class Medicine {
  final String id;
  final String name; // O usuário digita (ex: "Dipirona")
  final String dosage; // O usuário digita (ex: "1 cp" ou "5ml")
  final MedicineType type; // Ícone visual
  final TimeOfDay time;
  final bool isTaken;

  Medicine({
    required this.id,
    required this.name,
    required this.dosage,
    required this.type,
    required this.time,
    this.isTaken = false,
  });

  Medicine copyWith({bool? isTaken}) {
    return Medicine(
      id: id,
      name: name,
      dosage: dosage,
      type: type,
      time: time,
      isTaken: isTaken ?? this.isTaken,
    );
  }
}

final medicineProvider = NotifierProvider<MedicineNotifier, List<Medicine>>(MedicineNotifier.new);

class MedicineNotifier extends Notifier<List<Medicine>> {
  @override
  List<Medicine> build() {
    // ⚠️ Começa VAZIO para o usuário ter o controle total.
    // Em um app real, aqui você carregaria do SharedPreferences/Hive/Isar.
    return [];
  }

  void addMedicine(String name, String dosage, MedicineType type, TimeOfDay time) {
    final newMed = Medicine(
      id: const Uuid().v4(),
      name: name,
      dosage: dosage,
      type: type,
      time: time,
    );
    
    // Adiciona e ordena cronologicamente
    final newList = [...state, newMed]..sort((a, b) {
      final aMinutes = a.time.hour * 60 + a.time.minute;
      final bMinutes = b.time.hour * 60 + b.time.minute;
      return aMinutes.compareTo(bMinutes);
    });
    
    state = newList;
  }

  void toggleTaken(String id) {
    state = [
      for (final med in state)
        if (med.id == id) med.copyWith(isTaken: !med.isTaken) else med
    ];
  }

  void removeMedicine(String id) {
    state = state.where((m) => m.id != id).toList();
  }
}