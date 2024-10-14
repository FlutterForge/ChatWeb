
class UserModel {
  int id;
  final String username;
  final String phoneNumber;
  final String? profilePicture;
  final String? bio;
  final bool isOnline;
  UserModel({
    this.id = 0,
    required this.username,
    required this.phoneNumber,
    this.profilePicture,
    this.bio,
    this.isOnline = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      username: json['username'] ,
      phoneNumber: json['phoneNumber'] ,
      profilePicture: json['profilePicture'] ,
      bio: json['bio'] ,
      isOnline: json['isOnline'] ?? false,
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
    };
  }
}
