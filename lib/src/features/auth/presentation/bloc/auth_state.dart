part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthStatus? status;
  final String? number;

  const AuthState({this.status, this.number});

  AuthState copyWith({
    AuthStatus? status,
    String? number,
  }) {
    return AuthState(
      status: status ?? this.status,
      number: number ?? this.number,
    );
  }

  @override
  List<Object?> get props => [
    status,
    number,
  ];
}

enum AuthStatus {
  initial,
  failure,
  success,
  loading
}
