import 'package:json_annotation/json_annotation.dart';
import 'package:mirc_chat/core/model/message.dart';
import 'package:mirc_chat/core/repository/firebase_impl/firestore_constants.dart';

abstract class Thread {
  final String id;
  @JsonKey(name: FirestoreConstants.messagesField)
  final List<Message> messages;

  const Thread({
    required this.id,
    required this.messages,
  });
}
