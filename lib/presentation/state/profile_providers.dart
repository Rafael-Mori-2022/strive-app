import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strive/di/service_locator.dart';
import 'package:strive/domain/entities/user_profile.dart';
import 'package:strive/domain/repositories/profile_repository.dart';
import 'package:strive/providers/auth_providers.dart';

final profileRepositoryProvider =
    Provider<ProfileRepository>((ref) => sl<ProfileRepository>());

// Função helper para a lógica de buscar ou criar
Future<UserProfile> _fetchOrCreateProfile(
    Ref ref, String uid, String? displayName) async {
  final repo = ref.read(profileRepositoryProvider);
  try {
    final profile = await repo.getProfile(uid);
    print("Perfil encontrado: ${profile.name}");
    return profile;
  } catch (e) {
    print("Mock: Perfil não encontrado. Criando um novo...");

    final newProfile = UserProfile(
      id: uid,
      name: displayName ?? "Alex",
      age: 0,
      heightCm: 0.0,
      weightKg: 0.0,
      goal: 'Ganhar músculo',
      xp: 0,
    );

    await repo.saveProfile(newProfile);

    return newProfile;
  }
}

final userProfileProvider = FutureProvider<UserProfile>((ref) async {
  final firebaseUser = await ref.watch(authStateStreamProvider.future);

  if (firebaseUser == null) {
    throw Exception("Usuário não autenticado.");
  }

  // ⬇️ USA A NOVA LÓGICA ⬇️
  // Chama a função helper que definimos acima
  return _fetchOrCreateProfile(ref, firebaseUser.uid, firebaseUser.displayName);
});

class ProfileUpdateNotifier extends AsyncNotifier<UserProfile> {
  @override
  Future<UserProfile> build() async {
    // Aguarda o estado de autenticação
    final firebaseUser = await ref.watch(authStateStreamProvider.future);

    if (firebaseUser == null) {
      throw Exception("Usuário não autenticado.");
    }

    // ⬇️ USA A NOVA LÓGICA ⬇️
    // Chama a função helper que definimos acima
    return _fetchOrCreateProfile(
        ref, firebaseUser.uid, firebaseUser.displayName);
  }

  Future<void> save(UserProfile profile) async {
    state = const AsyncLoading();

    // O UID já está garantido pelo 'build'
    final uid = ref.read(authStateStreamProvider).valueOrNull?.uid;
    if (uid == null) {
      throw Exception("Usuário não autenticado para salvar.");
    }
  }
}

final profileUpdateProvider =
    AsyncNotifierProvider<ProfileUpdateNotifier, UserProfile>(
        ProfileUpdateNotifier.new);
