import 'package:chat_web/src/features/auth/data/model/chatting_model.dart';
import 'package:hive/hive.dart';


@HiveType(typeId: 1)
class ChatModel {
  int id;

  String name;

  String chatType;

  final List<int> participants;

  final String link;

  final String? description;

  final String? picture;

  List<ChattingModel> messages;

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
      id: json['id'] as int,
      name: json['name'] as String,
      chatType: json['chatType'] as String,
      participants: List<int>.from(json['participants'] as List<dynamic>),
      link: json['link'] as String,
      description: json['description'] as String?,
      picture: json['picture'] as String?,
      messages: (json['messages'] as List<dynamic>)
          .map((item) => ChattingModel.fromJson(item as Map<String, dynamic>))
          .toList(), 
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
