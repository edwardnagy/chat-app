import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:mirc_chat/data/firebase/firestore_constants.dart';
import 'package:mirc_chat/domain/model/channel.dart';
import 'package:mirc_chat/domain/model/channel_thread.dart';
import 'package:mirc_chat/domain/model/message.dart';
import 'package:mirc_chat/domain/model/thread.dart';
import 'package:mirc_chat/domain/repository/channel_repository.dart';

@Injectable(as: ChannelRepository)
class ChannelRepositoryFirestoreImpl implements ChannelRepository {
  final FirebaseFirestore _firestore;

  const ChannelRepositoryFirestoreImpl(this._firestore);

  @override
  Stream<List<Channel>> getChannels({String? ownerUsername}) {
    Query<Map<String, dynamic>> query =
        _firestore.collection(FirestoreConstants.channelsCollection);
    if (ownerUsername != null) {
      query = query.where(
        Channel.ownerUsernameKey,
        isEqualTo: ownerUsername,
      );
    }

    return query.snapshots().map(
      (event) {
        final docs = event.docs;
        if (docs.isEmpty) {
          return [];
        } else {
          return docs.map((e) => Channel.fromJson(e.data())).toList();
        }
      },
    );
  }

  @override
  Future<void> createChannel(
    Channel channel, {
    required String password,
  }) async {
    final channelDoc = _firestore
        .collection(FirestoreConstants.channelsCollection)
        .doc(channel.name);
    await channelDoc.set(channel.toJson());

    final threadDoc = channelDoc
        .collection(FirestoreConstants.channelThreadsCollection)
        .doc(password);
    await threadDoc.set(
      ChannelThread(
        id: password,
        participants: [channel.ownerUsername],
        messages: [],
        channelName: channel.name,
        ownerUsername: channel.ownerUsername,
      ).toJson(),
    );
  }

  @override
  Future<void> deleteChannel(String channelName) {
    return _firestore
        .collection(FirestoreConstants.channelsCollection)
        .doc(channelName)
        .delete();
  }

  @override
  Future<void> joinChannel({
    required String username,
    required String channelName,
    required String password,
  }) {
    final threadDoc = _firestore
        .collection(FirestoreConstants.channelsCollection)
        .doc(channelName)
        .collection(FirestoreConstants.channelThreadsCollection)
        .doc(password);

    return threadDoc.update({
      ChannelThread.participantsKey: FieldValue.arrayUnion([username]),
    });
  }

  @override
  Future<void> quitChannel({
    required String username,
    required String channelName,
  }) async {
    final snapshot = await _firestore
        .collection(FirestoreConstants.channelsCollection)
        .doc(channelName)
        .collection(FirestoreConstants.channelThreadsCollection)
        .where(
          ChannelThread.participantsKey,
          arrayContains: username,
        )
        .where(ChannelThread.channelNameKey, isEqualTo: channelName)
        .get();

    for (final threadDoc in snapshot.docs) {
      await threadDoc.reference.update({
        ChannelThread.participantsKey: FieldValue.arrayRemove([username]),
      });
    }
  }

  @override
  Stream<List<ChannelThread>> getJoinedChannelThreads({
    required String username,
  }) {
    return _firestore
        .collectionGroup(FirestoreConstants.channelThreadsCollection)
        .where(
          ChannelThread.participantsKey,
          arrayContains: username,
        )
        .where(
          ChannelThread.ownerUsernameKey,
          isNotEqualTo: username,
        )
        .snapshots()
        .map(
          (event) => event.docs
              .map((doc) => ChannelThread.fromJson(doc.data()))
              .toList(),
        );
  }

  @override
  Stream<ChannelThread?> getChannelThread({
    required String channelName,
    required String username,
  }) {
    return _firestore
        .collectionGroup(FirestoreConstants.channelThreadsCollection)
        .where(
          ChannelThread.participantsKey,
          arrayContains: username,
        )
        .where(ChannelThread.channelNameKey, isEqualTo: channelName)
        .snapshots()
        .map(
      (event) {
        final docs = event.docs;
        if (docs.isEmpty) {
          return null;
        } else {
          return ChannelThread.fromJson(docs.first.data());
        }
      },
    );
  }

  @override
  Future<void> sendMessage({
    required String channelName,
    required Message message,
  }) async {
    final snapshot = await _firestore
        .collection(FirestoreConstants.channelsCollection)
        .doc(channelName)
        .collection(FirestoreConstants.channelThreadsCollection)
        .where(
          ChannelThread.participantsKey,
          arrayContains: message.senderUsername,
        )
        .get();

    await snapshot.docs.first.reference.update({
      Thread.messageKey: FieldValue.arrayUnion([message.toJson()]),
    });
  }
}
