import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/domain/entities/user_profile.dart'; 
import 'package:strive/providers/auth_providers.dart';

final userProfileStreamProvider = StreamProvider<UserProfile?>((ref) {
  final authState = ref.watch(authStateStreamProvider);

  return authState.when(
    data: (user) {
      if (user == null) return Stream.value(null);

      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists && snapshot.data() != null) {
          return UserProfile.fromMap(snapshot.data()!);
        }
        return null; 
      });
    },
    loading: () => const Stream.empty(),
    error: (_, __) => Stream.value(null),
  );
});
