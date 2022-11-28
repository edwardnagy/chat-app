import 'package:mirc_chat/core/model/profile.dart';

abstract class AuthRepository {
  String getUserId();

  Future<void> updateProfile(Profile profile);
}
