import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:strive/domain/entities/exercise.dart';
import 'package:strive/domain/entities/workout.dart';
import 'package:strive/domain/repositories/workout_repository.dart';
import 'package:http/http.dart' as http;

class WorkoutRepositoryImpl implements WorkoutRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Cache simples em memória
  final Map<String, List<Exercise>> _apiCache = {};

  // Mapeamento Seguro (Normalizado para minúsculas sem acentos se possível)
  final Map<String, int> _categoryMap = {
    'peito': 11,
    
    'costas': 12,
    
    'bíceps': 8,
    'biceps': 8,
    'tríceps': 8,
    'triceps': 8,
    
    'pernas': 9,
    'coxas': 9,
    
    'ombros': 13,
    
    'abdômen': 10,
    'abdomen': 10,
    
    'panturrilhas': 14,

    'cardio': 15,
  };

  @override
  Future<List<Exercise>> listExercisesByMuscle(String muscleGroup) async {
    final key = muscleGroup.toLowerCase().trim();
    final categoryId = _categoryMap[key];
    final effectiveId = categoryId ?? 11; // Fallback

    if (_apiCache.containsKey(key)) {
      return _apiCache[key]!;
    }

    try {
      // MUDANÇA 1: Usamos /exerciseinfo/
      // Removemos o filtro de language na URL para receber TODAS as traduções e filtrar aqui
      final url = Uri.parse(
          'https://wger.de/api/v2/exerciseinfo/?category=$effectiveId&limit=50');
      
      print("Chamando Wger Info: $url");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] == null) return [];
        
        final results = data['results'] as List;
        final exercises = <Exercise>[];

        for (var item in results) {
          // MUDANÇA 2: Lógica de Prioridade de Idioma
          // ID 7 = Português (BR ou PT)
          // ID 2 = Inglês
          
          final translations = item['translations'] as List? ?? [];
          if (translations.isEmpty) continue; // Pula se não tem tradução

          // Tenta achar em PT
          var translation = translations.firstWhere(
            (t) => t['language'] == 7,
            orElse: () => null,
          );

          // Se não tem nem PT nem EN, pula esse exercício estranho
          if (translation == null) continue;

          // --- Extração de Dados ---
          
          String name = translation['name']?.toString().trim() ?? 'Exercício';
          
          // Limpeza de HTML da descrição
          String descRaw = translation['description']?.toString() ?? '';
          String descClean = descRaw
              .replaceAll(RegExp(r'<[^>]*>'), '') // Remove tags
              .replaceAll('&nbsp;', ' ') // Remove espaços HTML
              .trim();
          
          if (descClean.length > 100) {
            descClean = "${descClean.substring(0, 100)}...";
          }
          if (descClean.isEmpty) descClean = "Sem detalhes adicionais.";

          // Tenta pegar imagem (se existir no array de imagens)
          String? imageUrl;
          final images = item['images'] as List? ?? [];
          if (images.isNotEmpty) {
            // Pega a primeira imagem disponível
            imageUrl = images[0]['image']; 
          }

          exercises.add(Exercise(
            id: item['id'].toString(),
            name: name,
            muscleGroup: muscleGroup, // Mantemos o filtro original para display
            description: descClean,
            details: "4x12", // Sugestão padrão
            imageUrl: imageUrl, // Agora pode vir preenchido se a API tiver
          ));
        }

        _apiCache[key] = exercises;
        return exercises;
      }
    } catch (e) {
      print('ERRO API WGER: $e');
    }
    return [];
  }

  // --- MÉTODOS DO FIRESTORE (MANTIDOS IGUAIS) ---
  // Copie exatamente os métodos do Firestore que fizemos na resposta anterior
  // (getWorkoutPlans, createWorkout, addExercise, etc.)
  // Vou recolocá-los aqui para facilitar o Copy/Paste completo:

  @override
  Future<List<WorkoutPlan>> getWorkoutPlans() async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('workouts')
        .orderBy('createdAt', descending: true) // Ordenar por mais recente
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      // Tratamento seguro para lista de exercícios
      List<Exercise> exercises = [];
      if (data['exercises'] != null) {
        exercises = (data['exercises'] as List)
            .map((e) => Exercise.fromMap(e))
            .toList();
      }

      return WorkoutPlan(
        id: doc.id,
        name: data['name'] ?? 'Treino sem nome',
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

    // Firestore não tem arrayRemove para objetos complexos facilmente se não tiver a referência exata.
    // A melhor forma é ler, filtrar e salvar de volta.
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