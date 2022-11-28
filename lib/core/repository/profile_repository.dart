import 'package:mirc_chat/core/model/profile.dart';

abstract class ProfileRepository {
  Future<void> createProfile(Profile profile);

  Stream<Profile?> getProfile({required String username});
}
