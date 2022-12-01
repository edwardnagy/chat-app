import 'package:json_annotation/json_annotation.dart';
import 'package:mirc_chat/domain/model/message.dart';
import 'package:mirc_chat/domain/model/thread.dart';

part 'direct_message_thread.g.dart';

@JsonSerializable()
class DirectMessageThread extends Thread {
  static const participantsKey = 'participants';

  @JsonKey(name: participantsKey)
  final Map<String, bool> participants;

  const DirectMessageThread({
    required super.id,
    required super.messages,
    required this.participants,
  });

  factory DirectMessageThread.fromJson(Map<String, dynamic> json) =>
      _$DirectMessageThreadFromJson(json);

  Map<String, dynamic> toJson() => _$DirectMessageThreadToJson(this);
}
