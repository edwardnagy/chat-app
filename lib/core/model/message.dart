import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final String id;
  final String senderUsername;
  final String text;
  final DateTime creationDate;

  const Message({
    required this.id,
    required this.senderUsername,
    required this.text,
    required this.creationDate,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
