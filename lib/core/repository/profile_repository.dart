import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:mirc_chat/core/failure/profile_failure.dart';
import 'package:mirc_chat/core/model/profile.dart';
import 'package:mirc_chat/core/remote/firestore_constants.dart';

@injectable
class ProfileRepository {
  final FirebaseFirestore _firestore;

  ProfileRepository(this._firestore);

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

  Stream<Profile?> getProfile({required String username}) {
    // TODO: Handle document not existing error
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
