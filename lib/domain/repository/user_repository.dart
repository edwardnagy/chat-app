import 'package:mirc_chat/domain/model/user.dart';

abstract class UserRepository {
  Future<void> createUser(User user);

  Stream<User?> getUser({required String uid});
}
