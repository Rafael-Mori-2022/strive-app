import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strive/domain/entities/leaderboard_entry.dart';
import 'package:strive/domain/repositories/leaderboard_repository.dart';

class FirestoreLeaderboardRepository implements LeaderboardRepository {
  final FirebaseFirestore _firestore;

  FirestoreLeaderboardRepository(this._firestore);

  @override
  Future<List<LeaderboardEntry>> getLeaderboard() async {
    try {
      // FIX: Ordenamos por 'xp' (Total) no banco para garantir que TODOS venham,
      // pois 'weeklyXp' pode não existir em usuários antigos.
      final querySnapshot = await _firestore
          .collection('users')
          .orderBy('xp', descending: true) 
          .get();

      final entries = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return LeaderboardEntry(
          userId: doc.id,
          name: data['name'] ?? 'Atleta',
          totalXp: (data['xp'] as num?)?.toInt() ?? 0,
          // Se não tiver weeklyXp, assume 0
          weeklyXp: (data['weeklyXp'] as num?)?.toInt() ?? 0, 
          level: (data['level'] as num?)?.toInt() ?? 1,
          leagueTier: (data['leagueTier'] as num?)?.toInt() ?? 0, // 0 = Madeira
        );
      }).toList();

      // ORDENAÇÃO NA MEMÓRIA: Quem tem mais XP na semana fica no topo
      entries.sort((a, b) => b.weeklyXp.compareTo(a.weeklyXp));

      return entries;
    } catch (e) {
      print('Erro ao buscar leaderboard: $e');
      return [];
    }
  }
}