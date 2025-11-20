import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strive/domain/entities/user_profile.dart';
import 'package:strive/domain/repositories/profile_repository.dart';

class FirestoreProfileRepository implements ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserProfile?> getProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();

      if (doc.exists && doc.data() != null) {
        return UserProfile.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      print("Erro ao buscar perfil no Firestore: $e");
      return null;
    }
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    try {
      // .set com SetOptions(merge: true) é bom para não apagar campos extras que você crie no futuro
      await _firestore
          .collection('users')
          .doc(profile.id)
          .set(profile.toMap(), SetOptions(merge: true));
    } catch (e) {
      print("Erro ao salvar perfil no Firestore: $e");
      throw Exception("Erro ao salvar dados");
    }
  }
}
