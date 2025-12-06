import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:strive/domain/entities/exercise.dart';
import 'package:strive/domain/entities/workout.dart';
import 'package:strive/domain/repositories/workout_repository.dart';
import 'package:http/http.dart' as http;
import 'package:strive/i18n/strings.g.dart'; // Importação do Slang

class WorkoutRepositoryImpl implements WorkoutRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Cache simples em memória
  final Map<String, List<Exercise>> _apiCache = {};

  // Mapeamento Expandido (PT + EN) para IDs da Wger API
  final Map<String, int> _categoryMap = {
    // Português
    'peito': 11,
    'costas': 12,
    'bíceps': 8, 'biceps': 8,
    'tríceps': 8, 'triceps': 8,
    'braços': 8, 'bracos': 8,
    'pernas': 9, 'coxas': 9,
    'ombros': 13,
    'abdômen': 10, 'abdomen': 10,
    'panturrilhas': 14,
    'cardio': 15,

    // English (Adicionado para suportar a tradução)
    'chest': 11,
    'back': 12,
    'arms': 8,
    'biceps': 8,
    'triceps': 8,
    'legs': 9,
    'shoulders': 13,
    'abs': 10,
    'calves': 14,
    // 'cardio' é igual em ambos
  };

  @override
  Future<List<Exercise>> listExercisesByMuscle(String muscleGroup) async {
    final key = muscleGroup.toLowerCase().trim();
    final categoryId = _categoryMap[key];

    // Fallback: Se não achar (ex: busca digitada errada), tenta buscar Peito (11) ou retorna vazio na UI
    final effectiveId = categoryId ?? 11;

    if (_apiCache.containsKey(key)) {
      return _apiCache[key]!;
    }

    try {
      final url = Uri.parse(
          'https://wger.de/api/v2/exerciseinfo/?category=$effectiveId&limit=50');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] == null) return [];

        final results = data['results'] as List;
        final exercises = <Exercise>[];

        // Detecta o idioma atual do App para priorizar a API
        // ID 2 = Inglês, ID 7 = Português
        final currentLocale = LocaleSettings.currentLocale; // Vem do Slang
        final int targetLangId = (currentLocale == AppLocale.pt) ? 7 : 2;

        for (var item in results) {
          final translations = item['translations'] as List? ?? [];
          if (translations.isEmpty) continue;

          // 1. Tenta achar no idioma do app
          var translation = translations.firstWhere(
            (t) => t['language'] == targetLangId,
            orElse: () => null,
          );

          // 2. Fallback: Se não achar no idioma do app, tenta Inglês (2) (se o app for PT)
          if (translation == null && targetLangId != 2) {
            translation = translations.firstWhere(
              (t) => t['language'] == 2,
              orElse: () => null,
            );
          }

          // 3. Último caso: pega o primeiro que vier ou pula
          if (translation == null) continue;

          // --- Extração de Dados ---
          String name = translation['name']?.toString().trim() ?? 'Exercise';

          String descRaw = translation['description']?.toString() ?? '';
          String descClean = descRaw
              .replaceAll(RegExp(r'<[^>]*>'), '')
              .replaceAll('&nbsp;', ' ')
              .trim();

          if (descClean.length > 100) {
            descClean = "${descClean.substring(0, 100)}...";
          }
          if (descClean.isEmpty) descClean = "No details.";

          String? imageUrl;
          final images = item['images'] as List? ?? [];
          if (images.isNotEmpty) {
            imageUrl = images[0]['image'];
          }

          exercises.add(Exercise(
              id: item['id'].toString(),
              name: name,
              muscleGroup: muscleGroup,
              description: descClean,
              details: "4x12",
              imageUrl: imageUrl,
              completed: false));
        }

        _apiCache[key] = exercises;
        return exercises;
      }
    } catch (e) {
      print('ERRO API WGER: $e');
    }
    return [];
  }

  @override
  Future<List<WorkoutPlan>> getWorkoutPlans() async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('workouts')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      List<Exercise> exercises = [];
      if (data['exercises'] != null) {
        exercises = (data['exercises'] as List)
            .map((e) => Exercise.fromMap(e))
            .toList();
      }

      return WorkoutPlan(
        id: doc.id,
        // Fallback simples se vier nulo do banco
        name: data['name'] ?? 'Workout',
        exercises: exercises,
      );
    }).toList();
  }

  @override
  Future<void> createWorkout(String name) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('workouts')
        .add({
      'name': name,
      'exercises': [],
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> addExercise(String planId, Exercise exercise) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('workouts')
        .doc(planId);

    await docRef.update({
      'exercises': FieldValue.arrayUnion([exercise.toMap()])
    });
  }

  @override
  Future<void> removeExercise(String planId, String exerciseId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('workouts')
        .doc(planId);

    final snapshot = await docRef.get();
    if (!snapshot.exists) return;

    final exercises = (snapshot.data()!['exercises'] as List)
        .map((e) => Exercise.fromMap(e))
        .where((e) => e.id != exerciseId)
        .map((e) => e.toMap())
        .toList();

    await docRef.update({'exercises': exercises});
  }

  @override
  Future<void> toggleExercise(String planId, String exerciseId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('workouts')
        .doc(planId);

    final snapshot = await docRef.get();
    if (!snapshot.exists) return;

    final exercises = (snapshot.data()!['exercises'] as List)
        .map((e) => Exercise.fromMap(e))
        .map((e) => e.id == exerciseId ? e.toggleComplete() : e)
        .map((e) => e.toMap())
        .toList();

    await docRef.update({'exercises': exercises});
  }

  @override
  Future<void> deleteWorkout(String planId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('workouts')
        .doc(planId)
        .delete();
  }

  @override
  Future<void> updateWorkoutName(String planId, String newName) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('workouts')
        .doc(planId)
        .update({'name': newName});
  }
}
