// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelThread _$ChannelThreadFromJson(Map<String, dynamic> json) =>
    ChannelThread(
      id: json['id'] as String,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      channelName: json['channelName'] as String,
      ownerUsername: json['ownerUsername'] as String,
    );

Map<String, dynamic> _$ChannelThreadToJson(ChannelThread instance) =>
    <String, dynamic>{
      'id': instance.id,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
      'channelName': instance.channelName,
      'ownerUsername': instance.ownerUsername,
      'participants': instance.participants,
    };
