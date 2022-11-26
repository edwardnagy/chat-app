// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_messages_holder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectMessagesHolder _$DirectMessagesHolderFromJson(
        Map<String, dynamic> json) =>
    DirectMessagesHolder(
      id: json['id'] as String,
      participants: Map<String, bool>.from(json['participants'] as Map),
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DirectMessagesHolderToJson(
        DirectMessagesHolder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'participants': instance.participants,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
    };
