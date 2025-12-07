import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:strive/di/service_locator.dart';
import 'package:strive/domain/entities/user_profile.dart';
import 'package:strive/domain/repositories/profile_repository.dart';
import 'package:strive/providers/auth_providers.dart';
import 'package:strive/i18n/strings.g.dart'; // Importação do Slang

// Provider do Repositório (Pode ser Mock ou Real, dependendo do Service Locator)
final profileRepositoryProvider =
    Provider<ProfileRepository>((ref) => sl<ProfileRepository>());

// --- Lógica Central: Busca ou Cria baseada no Auth ---
Future<UserProfile> _fetchOrCreateProfile(Ref ref, User firebaseUser) async {
  // Recebe o objeto User inteiro agora

  final repo = ref.read(profileRepositoryProvider);

  try {
    // Tenta buscar no banco/mock
    final profile = await repo.getProfile(firebaseUser.uid);

    if (profile != null) {
      print("Perfil encontrado: ${profile.name}"); // Log mantido original
      return profile;
    } else {
      // Se retornou null, lançamos erro para cair no catch e criar
      // Usando a chave existente "Perfil não encontrado"
      throw Exception(t.profile.not_found);
    }
  } catch (e) {
    print(
        "Perfil não encontrado no banco. Criando com dados do Google..."); // Log mantido

    // AQUI ESTÁ A DINÂMICA: Usamos os dados do Google Login
    final newProfile = UserProfile(
      id: firebaseUser.uid,
      // Fallback traduzido ("Atleta")
      name: firebaseUser.displayName ?? t.profile.default_user,
      email: firebaseUser.email ?? "",
      age: 0,
      heightCm: 0.0,
      weightKg: 0.0,
      goal: '',
      xp: 0,
    );

    // Não salvamos automaticamente aqui, deixamos o usuário completar no Onboarding
    // ou salvamos um esqueleto inicial se preferir:
    // await repo.saveProfile(newProfile);

    return newProfile;
  }
}

// Provider de Leitura (Consumo na UI)
final userProfileProvider = FutureProvider<UserProfile>((ref) async {
  final firebaseUser = await ref.watch(authStateStreamProvider.future);

  if (firebaseUser == null) {
    // "Usuário não autenticado."
    throw Exception(t.common.not_authenticated);
  }

  return _fetchOrCreateProfile(ref, firebaseUser);
});

// Provider de Atualização (Notifier)
class ProfileUpdateNotifier extends AsyncNotifier<UserProfile> {
  @override
  Future<UserProfile> build() async {
    final firebaseUser = await ref.watch(authStateStreamProvider.future);

    if (firebaseUser == null) {
      // "Usuário não autenticado."
      throw Exception(t.common.not_authenticated);
    }

    return _fetchOrCreateProfile(ref, firebaseUser);
  }

  Future<void> save(UserProfile profile) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(profileRepositoryProvider);
      await repo.saveProfile(profile);

      // Atualiza o estado local com o novo perfil
      state = AsyncData(profile);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }
}

final profileUpdateProvider =
    AsyncNotifierProvider<ProfileUpdateNotifier, UserProfile>(
        ProfileUpdateNotifier.new);
