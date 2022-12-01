import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:mirc_chat/data/firebase/firestore_constants.dart';
import 'package:mirc_chat/domain/model/user.dart';
import 'package:mirc_chat/domain/repository/user_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryFirestoreImpl implements UserRepository {
  final FirebaseFirestore _firestore;

  const UserRepositoryFirestoreImpl(this._firestore);

  @override
  Future<void> createUser(User user) async {
    await _firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(user.uid)
        .set(user.toJson());
  }

  @override
  Stream<User?> getUser({required String uid}) {
    return _firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(uid)
        .snapshots()
        .map((snapshot) =>
            snapshot.exists ? User.fromJson(snapshot.data()!) : null);
  }
}
