import 'package:json_annotation/json_annotation.dart';
import 'package:mirc_chat/domain/model/message.dart';
import 'package:mirc_chat/domain/model/thread.dart';

part 'channel_thread.g.dart';

@JsonSerializable()
class ChannelThread extends Thread {
  static const channelNameKey = 'channelName';
  static const participantsKey = 'participants';
  static const ownerUsernameKey = 'ownerUsername';

  @JsonKey(name: channelNameKey)
  final String channelName;
  @JsonKey(name: ownerUsernameKey)
  final String ownerUsername;
  @JsonKey(name: participantsKey)
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
