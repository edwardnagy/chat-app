import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:mirc_chat/core/model/direct_message_thread.dart';
import 'package:mirc_chat/core/model/message.dart';
import 'package:mirc_chat/core/remote/firestore_constants.dart';
import 'package:uuid/uuid.dart';

@injectable
class DirectMessageRepository {
  final FirebaseFirestore _firestore;

  const DirectMessageRepository(this._firestore);

  Stream<List<DirectMessageThread>> getAllMessages(String username) {
    return _firestore
        .collection(FirestoreConstants.directMessagesCollection)
        .where(
          '${FirestoreConstants.participantsField}.$username',
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

  Stream<DirectMessageThread?> getMessagesWithUser(
    String username, {
    required String recipientUsername,
  }) {
    return _firestore
        .collection(FirestoreConstants.directMessagesCollection)
        .where(
          '${FirestoreConstants.participantsField}.$username',
          isEqualTo: true,
        )
        .where(
          '${FirestoreConstants.participantsField}.$recipientUsername',
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
        FirestoreConstants.messagesField:
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
