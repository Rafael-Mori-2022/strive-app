import 'dart:async';
import 'package:vigorbloom/domain/entities/user_profile.dart';
import 'package:vigorbloom/domain/repositories/profile_repository.dart';

class MockProfileRepository implements ProfileRepository {
  UserProfile? _profile;
  MockProfileRepository() {
    _profile = const UserProfile(id: 'u1', name: 'Alex', age: 27, heightCm: 178, weightKg: 74.5, goal: 'Gain muscle', xp: 1340);
  }
  @override
  Future<UserProfile> getProfile() async => _profile!;

  @override
  Future<void> saveProfile(UserProfile profile) async {
    _profile = profile;
  }
}
