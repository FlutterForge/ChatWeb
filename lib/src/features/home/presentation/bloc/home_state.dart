import 'package:chat_web/src/features/auth/data/model/chat_model.dart';
import 'package:chat_web/src/features/auth/data/model/user_model.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final UserModel? userModel;
  final HomeStatus status;
  final List<ChatModel> chats;

  HomeState({this.userModel, required this.status, this.chats = const []});

  HomeState copyWith(
          {List<ChatModel>? chats, HomeStatus? status, UserModel? userModel}) =>
      HomeState(
          userModel: userModel ?? this.userModel,
          status: status ?? this.status,
          chats: chats ?? this.chats);

  @override
  List<Object?> get props => [
        userModel,
        status,
        chats,
        
      ];
}

enum HomeStatus { initial, loading, error, success }
