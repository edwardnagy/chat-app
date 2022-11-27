import 'package:json_annotation/json_annotation.dart';

part 'channel.g.dart';

@JsonSerializable()
class Channel {
  final String name;
  final String ownerUsername;

  const Channel({required this.name, required this.ownerUsername});

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Channel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          ownerUsername == other.ownerUsername;

  @override
  int get hashCode => Object.hash(name, ownerUsername);
}
