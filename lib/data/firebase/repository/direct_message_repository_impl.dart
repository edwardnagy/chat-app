import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:mirc_chat/data/firebase/firestore_constants.dart';
import 'package:mirc_chat/domain/model/direct_message_thread.dart';
import 'package:mirc_chat/domain/model/message.dart';
import 'package:mirc_chat/domain/repository/direct_message_repository.dart';
import 'package:uuid/uuid.dart';

@Injectable(as: DirectMessageRepository)
class DirectMessageRepositoryFirestoreImpl implements DirectMessageRepository {
  final FirebaseFirestore _firestore;

  const DirectMessageRepositoryFirestoreImpl(this._firestore);

  @override
  Stream<List<DirectMessageThread>> getAllMessages(String username) {
    return _firestore
        .collection(FirestoreConstants.directMessagesCollection)
        .where(
          '${DirectMessageThread.participantsFieldKey}.$username',
          isEqualTo: true,
        )
        .snapshots()
        .map(
      (event) {
        final threads = event.docs
            .map((doc) => DirectMessageThread.fromJson(doc.data()))
            .toList();
        if (threads.isEmpty) {
          return [];
        }
        threads.sort(
          (a, b) => b.messages.last.creationDate
              .compareTo(a.messages.last.creationDate),
        );
        return threads;
      },
    );
  }

  @override
  Stream<DirectMessageThread?> getMessagesWithUser(
    String username, {
    required String recipientUsername,
  }) {
    return _firestore
        .collection(FirestoreConstants.directMessagesCollection)
        .where(
          '${DirectMessageThread.participantsFieldKey}.$username',
          isEqualTo: true,
        )
        .where(
          '${DirectMessageThread.participantsFieldKey}.$recipientUsername',
          isEqualTo: true,
        )
        .limit(1)
        .snapshots()
        .map(
      (event) {
        final threads =
            event.docs.map((doc) => DirectMessageThread.fromJson(doc.data()));

        if (threads.isEmpty) {
          return null;
        } else {
          return threads.first;
        }
      },
    );
  }

  @override
  Future<void> sendMessageToUser(
    String username, {
    required String recipientUsername,
    required Message message,
  }) async {
    final existingThread = await getMessagesWithUser(
      username,
      recipientUsername: recipientUsername,
    ).first;

    if (existingThread != null) {
      await _firestore
          .collection(FirestoreConstants.directMessagesCollection)
          .doc(existingThread.id)
          .update({
        DirectMessageThread.participantsFieldKey:
            FieldValue.arrayUnion([message.toJson()])
      });
    } else {
      final newThread = DirectMessageThread(
        id: const Uuid().v1(),
        participants: {username: true, recipientUsername: true},
        messages: [message],
      );

      await _firestore
          .collection(FirestoreConstants.directMessagesCollection)
          .doc(newThread.id)
          .set(newThread.toJson());
    }
  }
}
