import 'package:mirc_chat/core/model/user.dart';

abstract class UserRepository {
  Future<void> createUser(User user);

  Stream<User?> getUser({required String uid});
}
