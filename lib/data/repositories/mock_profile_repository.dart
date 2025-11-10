import 'dart:async';
import 'package:strive/domain/entities/user_profile.dart';
import 'package:strive/domain/repositories/profile_repository.dart';

class MockProfileRepository implements ProfileRepository {
  UserProfile? _profile;
  MockProfileRepository() {
    _profile = const UserProfile(
        id: 'u1',
        name: 'Alex',
        age: 27,
        heightCm: 178,
        weightKg: 74.5,
        goal: 'Gain muscle',
        xp: 1340);
  }
  @override
  Future<UserProfile> getProfile(String uid) async {
    await Future.delayed(const Duration(milliseconds: 200));

    if (_profile != null && _profile!.id == uid) {
      return _profile!;
    }

    throw Exception("Mock: Perfil não encontrado para o uid $uid");
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    await Future.delayed(const Duration(milliseconds: 200));

    _profile = profile;
    print("Mock: Perfil salvo -> ${profile.name}");
  }
}
