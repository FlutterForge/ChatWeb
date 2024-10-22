part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthStatus status;

  const AuthState({required this.status});

  @override
  List<Object?> get props => [
        status,
      ];
}

enum AuthStatus {
  initial,
  loading,
  failure,
  authorized,
  unauthorized,
}
