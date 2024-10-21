import 'package:chat_web/src/core/extension/print_styles.dart';
import 'package:chat_web/src/features/home/presentation/screen/home_screen.dart';

class MessageModel {
  final String id;

  final int sender;

  String message;

  final String dateTime;

  MessageModel({
    required this.id,
    required this.sender,
    required this.message,
    required this.dateTime,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    try {
      return MessageModel(
        id: json['id'] as String,
        sender: json['sender'] as int,
        message: json['message'] as String,
        dateTime: json['dateTime'] as String,
      );
    } catch (e, err) {
      'MessageModel.fromJson error $e $err'.printError();
      return MessageModel(
        id: json['id'] as String,
        sender: json['sender'] as int,
        message: json['message'] as String,
        dateTime: json['dateTime'] as String,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'message': message,
      'dateTime': dateTime,
    };
  }
}
