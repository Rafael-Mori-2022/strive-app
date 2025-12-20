import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class GamificationService {
  final FirebaseFirestore _firestore;

  GamificationService(this._firestore);

  // Configurações da Liga
  static const int promotionCount = 3; // Top 3 sobem
  static const int demotionCount = 3;  // Bottom 3 descem (exceto na madeira)
  static const int maxLeague = 10;     // Liga máxima (Lenda)

  /// Executa o processamento semanal: Promove, Rebaixa e Reseta XP Semanal
  Future<void> processWeeklyLeagues() async {
    try {
      final batch = _firestore.batch();
      
      // 1. Busca todos os usuários
      final snapshot = await _firestore.collection('users').get();
      final allUsers = snapshot.docs;

      // 2. Agrupa usuários por Liga (Tier)
      Map<int, List<QueryDocumentSnapshot>> usersByLeague = {};
      
      for (var doc in allUsers) {
        final data = doc.data();
        final tier = (data['leagueTier'] as num?)?.toInt() ?? 0;
        
        if (!usersByLeague.containsKey(tier)) {
          usersByLeague[tier] = [];
        }
        usersByLeague[tier]!.add(doc);
      }

      // 3. Processa cada liga separadamente
      usersByLeague.forEach((tier, usersInTier) {
        // Ordena por Weekly XP (Decrescente)
        usersInTier.sort((a, b) {
          final dataA = a.data() as Map<String, dynamic>;
          final dataB = b.data() as Map<String, dynamic>;
          final xpA = (dataA['weeklyXp'] as num?)?.toInt() ?? 0;
          final xpB = (dataB['weeklyXp'] as num?)?.toInt() ?? 0;
          return xpB.compareTo(xpA);
        });

        final totalUsers = usersInTier.length;

        for (int i = 0; i < totalUsers; i++) {
          final userDoc = usersInTier[i];
          final userData = userDoc.data() as Map<String, dynamic>;
          final currentWeeklyXp = (userData['weeklyXp'] as num?)?.toInt() ?? 0;
          
          int newTier = tier;
          String statusMessage = "Manteve a divisão";

          // Regra de Promoção: Estar no Top N e não estar na última liga
          // E ter feito pelo menos algum XP
          if (i < promotionCount && tier < maxLeague && currentWeeklyXp > 0) {
            newTier = tier + 1;
            statusMessage = "Promovido! 🔥";
          }
          // Regra de Rebaixamento: Estar no Bottom N e não estar na primeira liga
          else if (i >= totalUsers - demotionCount && tier > 0) {
            newTier = tier - 1;
            statusMessage = "Rebaixado 😢";
          }

          // 4. Agenda a atualização
          final userRef = _firestore.collection('users').doc(userDoc.id);
          
          batch.update(userRef, {
            'weeklyXp': 0, // RESET SEMANAL OBRIGATÓRIO
            'leagueTier': newTier,
            'lastWeekStatus': statusMessage, 
            'lastLeagueUpdate': FieldValue.serverTimestamp(),
          });
        }
      });

      // 5. Aplica tudo atomicamente
      await batch.commit();
      debugPrint("✅ Processamento de ligas concluído com sucesso!");
      
    } catch (e) {
      debugPrint("❌ Erro ao processar ligas: $e");
    }
  }
}