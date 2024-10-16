part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends AuthEvent {
  final String username;
  final String phoneNumber;

  const CreateUserEvent({required this.username, required this.phoneNumber});

  @override
  List<Object> get props => [
        username,
        phoneNumber
      ];
}
