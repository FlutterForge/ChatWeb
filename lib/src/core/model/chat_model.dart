import 'package:chat_web/src/core/model/message_model.dart';

class ChatModel {
  String id;

  String name;

  String chatType;

  List<int> participants;

  String link;

  String? description;

  String? picture;

  List<MessageModel> messages;

  ChatModel({
    required this.id,
    required this.name,
    required this.chatType,
    required this.participants,
    required this.link,
    this.description,
    this.picture,
    required this.messages,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] as String,
      name: json['name'] as String,
      chatType: json['chatType'] as String,
      participants: List<int>.from(json['participants'] as List<dynamic>),
      link: json['link'] as String,
      description: json['description'] as String?,
      picture: json['picture'] as String?,
      messages: (json['messages'] as List<dynamic>).map((item) => MessageModel.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'chatType': chatType,
      'participants': participants,
      'link': link,
      'description': description,
      'picture': picture,
      'messages': messages.map((item) => item.toJson()).toList(),
    };
  }
}
