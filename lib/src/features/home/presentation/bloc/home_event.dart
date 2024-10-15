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
