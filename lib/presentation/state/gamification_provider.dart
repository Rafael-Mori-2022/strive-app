import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/domain/enums/xp_action.dart';
import 'package:strive/presentation/state/profile_providers.dart';
import 'package:strive/providers/auth_providers.dart'; // Certifique-se que o caminho está correto

class LevelData {
  final int currentLevel;
  final int totalXp;
  final int xpForNextLevel;
  final int currentLevelBaseXp;
  
  int get xpInCurrentLevel => totalXp - currentLevelBaseXp;
  int get xpNeededForNextLevel => xpForNextLevel - currentLevelBaseXp;
  double get progress => (xpInCurrentLevel / xpNeededForNextLevel).clamp(0.0, 1.0);

  LevelData({
    required this.currentLevel,
    required this.totalXp,
    required this.xpForNextLevel,
    required this.currentLevelBaseXp,
  });
}

// --- Lógica de Cálculo de Nível (Baseada apenas em visualização) ---
final levelCalculatorProvider = Provider.family<LevelData, int>((ref, totalXp) {
  // Constante de dificuldade
  const int xpPerLevel = 1000; 

  final currentLevel = (totalXp / xpPerLevel).floor() + 1;
  
  final currentLevelBaseXp = (currentLevel - 1) * xpPerLevel;
  final xpForNextLevel = currentLevel * xpPerLevel;

  return LevelData(
    currentLevel: currentLevel,
    totalXp: totalXp,
    xpForNextLevel: xpForNextLevel,
    currentLevelBaseXp: currentLevelBaseXp,
  );
});

// Provider do Controller (Injeção de Dependências)
final gamificationControllerProvider = Provider((ref) {
  return GamificationController(ref, FirebaseFirestore.instance);
});

class GamificationController {
  final Ref ref;
  final FirebaseFirestore _firestore;

  GamificationController(this.ref, this._firestore);

  /// Adiciona XP ao usuário (Total e Semanal) de forma atômica
  Future<void> earnXp(BuildContext context, XpAction action) async {
    try {
      // 1. Obtém o usuário atual do Provider de Autenticação
      final userState = ref.read(currentUserProvider);
      final user = userState.value;
      
      if (user == null) {
        debugPrint("Tentativa de ganhar XP sem usuário logado.");
        return;
      }

      final userRef = _firestore.collection('users').doc(user.uid);
      bool leveledUp = false;
      int newLevelVal = 1;

      // 2. Transação Firestore (Leitura + Escrita Segura)
      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(userRef);
        
        if (!snapshot.exists) {
            // Se o documento não existe, podemos criar ou ignorar.
            // Aqui assumimos que o perfil já foi criado na tela de onboarding.
            return; 
        }

        final data = snapshot.data()!;
        final currentTotalXp = (data['xp'] as num?)?.toInt() ?? 0;
        // Se 'weeklyXp' não existir (usuário antigo), começa do zero
        final currentWeeklyXp = (data['weeklyXp'] as num?)?.toInt() ?? 0;

        final newTotalXp = currentTotalXp + action.points;
        final newWeeklyXp = currentWeeklyXp + action.points;

        // Verifica Level Up (baseado no XP total)
        final currentLevel = (currentTotalXp / 1000).floor() + 1;
        final newLevel = (newTotalXp / 1000).floor() + 1;

        if (newLevel > currentLevel) {
          leveledUp = true;
          newLevelVal = newLevel;
        }

        // Atualiza campos
        transaction.update(userRef, {
          'xp': newTotalXp,
          'weeklyXp': newWeeklyXp, // Importante para a Liga Semanal
          'level': newLevel,
          // Garante que o campo de liga exista para evitar bugs no Leaderboard
          if (!data.containsKey('leagueTier')) 'leagueTier': 0,
        });
      });

      // 3. Atualiza o estado local do app para refletir a mudança na UI imediatamente
      ref.refresh(userProfileProvider);

      // 4. Feedback Visual (SnackBar e Dialog)
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        
        if (leveledUp) {
           _showLevelUpDialog(context, newLevelVal);
        } else {
           _showXpSnackBar(context, action);
        }
      }

    } catch (e) {
      debugPrint("Erro ao dar XP: $e");
    }
  }

  void _showXpSnackBar(BuildContext context, XpAction action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          children: [
            const Icon(Icons.bolt, color: Color(0xFFFACC15), size: 28), // Dourado
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "+ ${action.points} XP",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  action.label,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showLevelUpDialog(BuildContext context, int newLevel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("SUBIU DE NÍVEL! 🎉"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.stars, size: 64, color: Colors.orange),
            const SizedBox(height: 16),
            Text(
              "Parabéns! Você alcançou o Nível $newLevel.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Legal!"),
          )
        ],
      ),
    );
  }
}