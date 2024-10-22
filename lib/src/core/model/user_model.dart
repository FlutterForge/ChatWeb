import 'package:chat_web/src/core/model/chat_model.dart';
import 'package:hive/hive.dart';

part "user_model.g.dart";

@HiveType(typeId: 3)
class UserModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String phoneNumber;
  @HiveField(3)
  final String? profilePicture;
  @HiveField(4)
  final String? bio;
  @HiveField(5)
  bool isOnline;
  @HiveField(6)
  List<UserModel> chats;

  UserModel({
    required this.id,
    required this.username,
    required this.phoneNumber,
    this.profilePicture,
    this.bio,
    this.isOnline = false,
    this.chats = const <UserModel>[],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
      bio: json['bio'],
      isOnline: json['isOnline'] ?? false,
      chats: (json['chats'] as List<dynamic>?)
              ?.map((item) => item is Map<String, dynamic> ? UserModel.fromJson(item) : null) 
              .where((item) => item != null) 
              .cast<UserModel>()
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'bio': bio,
      'isOnline': isOnline,
      'chats': chats.map((item) => item is ChatModel ? item.toJson() : item).toList(),
    };
  }
}
