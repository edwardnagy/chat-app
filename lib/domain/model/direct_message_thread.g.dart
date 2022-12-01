// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_message_thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectMessageThread _$DirectMessageThreadFromJson(Map<String, dynamic> json) =>
    DirectMessageThread(
      id: json['id'] as String,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      participants: Map<String, bool>.from(json['participants'] as Map),
    );

Map<String, dynamic> _$DirectMessageThreadToJson(
        DirectMessageThread instance) =>
    <String, dynamic>{
      'id': instance.id,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
      'participants': instance.participants,
    };
