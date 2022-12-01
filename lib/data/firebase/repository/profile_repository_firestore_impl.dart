import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:mirc_chat/data/firebase/firestore_constants.dart';
import 'package:mirc_chat/domain/failure/profile_failure.dart';
import 'package:mirc_chat/domain/model/profile.dart';
import 'package:mirc_chat/domain/repository/profile_repository.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryFirestoreImpl implements ProfileRepository {
  final FirebaseFirestore _firestore;

  const ProfileRepositoryFirestoreImpl(this._firestore);

  @override
  Future<void> createProfile(Profile profile) async {
    final isProfileWithSameUsername =
        await _profileDocumentReference(profile.username)
            .get()
            .then((value) => value.exists);
    if (isProfileWithSameUsername) {
      throw ProfileFailure.usernameAlreadyInUse;
    }

    await _profileDocumentReference(profile.username).set(profile.toJson());
  }

  @override
  Stream<Profile?> getProfile({required String username}) {
    return _profileDocumentReference(username).snapshots().map(
          (snapshot) =>
              snapshot.exists ? Profile.fromJson(snapshot.data()!) : null,
        );
  }

  DocumentReference<Map<String, dynamic>> _profileDocumentReference(
      String username) {
    return _firestore
        .collection(FirestoreConstants.profilesCollection)
        .doc(username);
  }
}
