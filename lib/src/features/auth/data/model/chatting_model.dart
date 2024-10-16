class ChattingModel {
  final int sender;

  dynamic message;

  ChattingModel({
    required this.sender,
    required this.message,
  });

  factory ChattingModel.fromJson(Map<String, dynamic> json) {
    return ChattingModel(
      sender: json['sender'] as int,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'message': message,
    };
  }
}
