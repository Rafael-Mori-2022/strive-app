import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigorbloom/di/service_locator.dart';
import 'package:vigorbloom/domain/entities/user_profile.dart';
import 'package:vigorbloom/domain/repositories/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) => sl<ProfileRepository>());

final userProfileProvider = FutureProvider<UserProfile>((ref) async => ref.read(profileRepositoryProvider).getProfile());

class ProfileUpdateNotifier extends AsyncNotifier<UserProfile> {
  @override
  Future<UserProfile> build() async => ref.read(profileRepositoryProvider).getProfile();

  Future<void> save(UserProfile profile) async {
    state = const AsyncLoading();
    await ref.read(profileRepositoryProvider).saveProfile(profile);
    state = AsyncData(profile);
  }
}

final profileUpdateProvider = AsyncNotifierProvider<ProfileUpdateNotifier, UserProfile>(ProfileUpdateNotifier.new);
