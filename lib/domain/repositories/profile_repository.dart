import 'package:vigorbloom/domain/entities/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile> getProfile(String uid); 
  Future<void> saveProfile(UserProfile profile); 
}
