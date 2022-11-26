import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:mirc_chat/core/model/direct_messages_holder.dart';
import 'package:mirc_chat/core/model/message.dart';
import 'package:mirc_chat/core/remote/firestore_constants.dart';
import 'package:uuid/uuid.dart';

@injectable
class DirectMessageRepository {
  final FirebaseFirestore _firestore;

  const DirectMessageRepository(this._firestore);

  Stream<List<DirectMessagesHolder>> getAllMessages(String username) {
    return _firestore
        .collection(FirestoreConstants.directMessagesCollection)
        .where(
          '${FirestoreConstants.participantsMapKey}.$username',
          isEqualTo: true,
        )
        .snapshots()
        .map(
      (event) {
        final messageHolders = event.docs
            .map((doc) => DirectMessagesHolder.fromJson(doc.data()))
            .toList();
        if (messageHolders.isEmpty) {
          return [];
        }
        messageHolders.sort(
          (a, b) => b.messages.last.creationDate
              .compareTo(a.messages.last.creationDate),
        );
        return messageHolders;
      },
    );
  }

  Stream<DirectMessagesHolder?> getMessagesWithUser(
    String username, {
    required String recipientUsername,
  }) {
    return _firestore
        .collection(FirestoreConstants.directMessagesCollection)
        .where(
          '${FirestoreConstants.participantsMapKey}.$username',
          isEqualTo: true,
        )
        .where(
          '${FirestoreConstants.participantsMapKey}.$recipientUsername',
          isEqualTo: true,
        )
        .limit(1)
        .snapshots()
        .map(
      (event) {
        final messageHolders =
            event.docs.map((doc) => DirectMessagesHolder.fromJson(doc.data()));

        if (messageHolders.isEmpty) {
          return null;
        } else {
          return messageHolders.first;
        }
      },
    );
  }

  Future<void> sendMessageToUser(
    String username, {
    required String recipientUsername,
    required Message message,
  }) async {
    final existingMessagesHolder = await getMessagesWithUser(
      username,
      recipientUsername: recipientUsername,
    ).first;

    if (existingMessagesHolder != null) {
      await _firestore
          .collection(FirestoreConstants.directMessagesCollection)
          .doc(existingMessagesHolder.id)
          .update({
        FirestoreConstants.messagesKey:
            FieldValue.arrayUnion([message.toJson()])
      });
    } else {
      final newMessagesHolder = DirectMessagesHolder(
        id: const Uuid().v1(),
        participants: {username: true, recipientUsername: true},
        messages: [message],
      );

      await _firestore
          .collection(FirestoreConstants.directMessagesCollection)
          .doc(newMessagesHolder.id)
          .set(newMessagesHolder.toJson());
    }
  }
}
