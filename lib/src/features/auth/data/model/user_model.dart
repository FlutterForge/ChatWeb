import 'package:chat_web/src/features/auth/data/model/chat_model.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class UserModel {
  int id;
  final String username;
  final String phoneNumber;
  final String? profilePicture;
  final String? bio;
  final bool isOnline;
  final List<ChatModel> chats;
  UserModel({
    this.id = 0,
    required this.username,
    required this.phoneNumber,
    this.profilePicture,
    this.bio,
    this.chats = const [],
    this.isOnline = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      return UserModel(
        id: json['id'] ?? 0,
        username: json['username'] ?? '',
        phoneNumber: json['phoneNumber'] ?? '',
        profilePicture: json['profilePicture'] ?? '',
        bio: json['bio'] ?? '',
        isOnline: json['isOnline'] ?? false,
        chats: (json['chats'] as List<dynamic>?)
                ?.map((chatJson) => ChatModel.fromJson(chatJson))
                .toList() ?? [],
      );
    } catch (error) {
      print('FROM JSON ERROR: $error');
      return UserModel(
        id: json['id'] ?? 0,
        username: json['username'] ?? '',
        phoneNumber: json['phoneNumber'] ?? '',
        profilePicture: json['profilePicture'],
        bio: json['bio'] ?? '',
        isOnline: json['isOnline'] ?? false,
        chats: [], 
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'bio': bio,
      'isOnline': isOnline,
      'chats': chats.map((chat) => chat.toJson()).toList(),
    };
  }
}