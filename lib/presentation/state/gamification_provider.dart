import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/domain/enums/xp_action.dart';
import 'package:strive/presentation/state/profile_providers.dart';

class LevelData {
  final int currentLevel;
  final int totalXp;
  final int xpForNextLevel;
  final int currentLevelBaseXp;
  
  // Getters para a UI
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

// --- LÓGICA DE CÁLCULO DE NÍVEL ---
final levelCalculatorProvider = Provider.family<LevelData, int>((ref, totalXp) {
  // Constante de dificuldade (quanto maior, mais difícil subir)
  const int xpPerLevel = 1000; 

  // Cálculo simples linear para MVP
  // Nvl 1 = 0-999, Nvl 2 = 1000-1999...
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

// --- CONTROLLER DE GAMIFICAÇÃO ---
final gamificationControllerProvider = Provider((ref) => GamificationController(ref));

class GamificationController {
  final Ref _ref;

  GamificationController(this._ref);

  /// Função principal para dar XP ao usuário
  Future<void> earnXp(BuildContext context, XpAction action) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      // 1. Atualiza no Firestore (Atômico)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'xp': FieldValue.increment(action.points),
        'lastActive': FieldValue.serverTimestamp(),
      });

      // 2. Feedback Visual (Wow Effect!)
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
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

      // 3. Força o refresh do perfil para atualizar a barra de progresso instantaneamente
      _ref.refresh(userProfileProvider);

    } catch (e) {
      debugPrint("Erro ao dar XP: $e");
    }
  }
}