import 'package:json_annotation/json_annotation.dart';
import 'package:mirc_chat/domain/model/message.dart';

abstract class Thread {
  static const messageKey = 'messages';

  final String id;
  @JsonKey(name: messageKey)
  final List<Message> messages;

  const Thread({
    required this.id,
    required this.messages,
  });
}
