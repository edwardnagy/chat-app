import 'package:json_annotation/json_annotation.dart';
import 'package:mirc_chat/core/model/message.dart';
import 'package:mirc_chat/core/remote/firestore_constants.dart';

part 'direct_messages_holder.g.dart';

@JsonSerializable()
class DirectMessagesHolder {
  final String id;
  @JsonKey(name: FirestoreConstants.participantsMapKey)
  final Map<String, bool> participants;
  @JsonKey(name: FirestoreConstants.messagesKey)
  final List<Message> messages;

  const DirectMessagesHolder({
    required this.id,
    required this.participants,
    required this.messages,
  });

  factory DirectMessagesHolder.fromJson(Map<String, dynamic> json) =>
      _$DirectMessagesHolderFromJson(json);

  Map<String, dynamic> toJson() => _$DirectMessagesHolderToJson(this);
}
