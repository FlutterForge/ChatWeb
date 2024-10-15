import 'package:chat_web/src/features/auth/data/model/user_model.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final UserModel? userModel;
  final HomeStatus status;

  HomeState({this.userModel, required this.status});

  HomeState copyWith({HomeStatus? status, UserModel? userModel}) => HomeState(
      userModel: userModel ?? this.userModel, status: status ?? this.status);

  @override
  List<Object?> get props => [
        userModel,
        status,
      ];
}

enum HomeStatus { initial,loading, error, success }
