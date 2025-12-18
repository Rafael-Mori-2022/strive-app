import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strive/domain/entities/leaderboard_entry.dart';
import 'package:strive/domain/repositories/leaderboard_repository.dart';

class FirestoreLeaderboardRepository implements LeaderboardRepository {
  final FirebaseFirestore _firestore;

  FirestoreLeaderboardRepository(this._firestore);

  @override
  Future<List<LeaderboardEntry>> getLeaderboard() async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .orderBy('currentXp', descending: true) 
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return LeaderboardEntry(
          userId: doc.id,
          name: data['name'] ?? 'Atleta',
          xp: (data['currentXp'] as num?)?.toInt() ?? 0,
          level: (data['level'] as num?)?.toInt() ?? 1,
        );
      }).toList();
    } catch (e) {
      print('Erro ao buscar leaderboard: $e');
      return [];
    }
  }
}