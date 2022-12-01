import 'package:mirc_chat/domain/model/profile.dart';

abstract class ProfileRepository {
  Future<void> createProfile(Profile profile);

  Stream<Profile?> getProfile({required String username});
}
