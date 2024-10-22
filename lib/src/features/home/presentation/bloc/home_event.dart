import 'dart:ui';

import 'package:chat_web/src/core/model/chat_model.dart';
import 'package:chat_web/src/core/model/message_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserInfoEvent extends HomeEvent {
  final String id;

  GetUserInfoEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class CreateGroupEvent extends HomeEvent {
  final ChatModel data;
  final VoidCallback onEnd;

  CreateGroupEvent({required this.data, required this.onEnd});
  @override
  List<Object?> get props => [data];
}

class GetAllChatsEvent extends HomeEvent {}

class SendMesasgeEvent extends HomeEvent {
  final int index;
  final MessageModel data;

  SendMesasgeEvent({required this.index, required this.data});

  @override
  List<Object?> get props => [index, data];
}
