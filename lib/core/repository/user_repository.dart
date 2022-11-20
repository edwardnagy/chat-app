import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:mirc_chat/core/model/user.dart';
import 'package:mirc_chat/core/remote/firestore_constants.dart';

@injectable
class UserRepository {
  final FirebaseFirestore _firestore;

  const UserRepository(this._firestore);

  Future<void> createUser(User user) async {
    await _firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(user.uid)
        .set(user.toJson());
  }

  Stream<User?> getUser({required String uid}) {
    // TODO: Handle document not existing error
    return _firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(uid)
        .snapshots()
        .map((snapshot) =>
            snapshot.exists ? User.fromJson(snapshot.data()!) : null);
  }
}
