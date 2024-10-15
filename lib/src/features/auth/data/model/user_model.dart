import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class UserModel {
  int id;
  final String username;
  final String phoneNumber;
  final String? profilePicture;
  final String? bio;
  final bool isOnline;
  final List<dynamic> chats;
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
        chats: (json['chats'] as List<dynamic>?) ?? <dynamic>[],
        bio: json['bio'] ?? '',
        isOnline: json['isOnline'] ?? false,
      );
    } catch (stack, error) {
      print('FROM JSON ERROR $stack $error');
      return UserModel(
        id: json['id'] ?? 0,
        username: json['username'],
        phoneNumber: json['phoneNumber'],
        profilePicture: json['profilePicture'],
        chats: json['chats'] ?? [],
        bio: json['bio'],
        isOnline: json['isOnline'] ?? false,
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
    };
  }
}
