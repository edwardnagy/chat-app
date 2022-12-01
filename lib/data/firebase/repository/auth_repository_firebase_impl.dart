import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mirc_chat/domain/failure/auth_failure.dart';
import 'package:mirc_chat/domain/model/profile.dart';
import 'package:mirc_chat/domain/repository/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryFirebaseImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  const AuthRepositoryFirebaseImpl(this._firebaseAuth);

  @override
  String getUserId() {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      throw AuthFailure.notAuthenticated;
    }

    return currentUser.uid;
  }

  @override
  Future<void> updateProfile(Profile profile) {
    return _firebaseAuth.currentUser!.updateDisplayName(profile.username);
  }
}
