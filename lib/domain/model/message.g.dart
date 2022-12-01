// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as String,
      senderUsername: json['senderUsername'] as String,
      text: json['text'] as String,
      creationDate: DateTime.parse(json['creationDate'] as String),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'senderUsername': instance.senderUsername,
      'text': instance.text,
      'creationDate': instance.creationDate.toIso8601String(),
    };
