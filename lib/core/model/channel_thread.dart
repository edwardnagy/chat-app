import 'package:json_annotation/json_annotation.dart';
import 'package:mirc_chat/core/model/message.dart';
import 'package:mirc_chat/core/model/thread.dart';
import 'package:mirc_chat/core/remote/firestore_constants.dart';

part 'channel_thread.g.dart';

@JsonSerializable()
class ChannelThread extends Thread {
  @JsonKey(name: FirestoreConstants.channelNameField)
  final String channelName;
  final String ownerUsername;
  @JsonKey(name: FirestoreConstants.participantsField)
  final List<String> participants;

  const ChannelThread({
    required super.id,
    required super.messages,
    required this.participants,
    required this.channelName,
    required this.ownerUsername,
  });

  factory ChannelThread.fromJson(Map<String, dynamic> json) =>
      _$ChannelThreadFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelThreadToJson(this);
}
