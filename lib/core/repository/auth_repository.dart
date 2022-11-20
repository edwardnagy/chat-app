import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mirc_chat/core/failure/auth_failure.dart';
import 'package:mirc_chat/core/model/profile.dart';

@injectable
class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  const AuthRepository(this._firebaseAuth);

  String getUserId() {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      throw AuthFailure.notAuthenticated;
    }

    return currentUser.uid;
  }

  Future<void> updateProfile(Profile profile) {
    return _firebaseAuth.currentUser!.updateDisplayName(profile.username);
  }
}
