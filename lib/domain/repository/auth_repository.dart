import 'package:mirc_chat/domain/model/profile.dart';

abstract class AuthRepository {
  String getUserId();

  Future<void> updateProfile(Profile profile);
}
