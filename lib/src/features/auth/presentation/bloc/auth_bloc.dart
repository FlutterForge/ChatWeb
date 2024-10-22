import 'package:chat_web/src/core/model/user_model.dart';
import 'package:chat_web/src/core/utils/local_db_service.dart';
import 'package:chat_web/src/features/auth/domain/usecase/create_user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateUserUsecase createUserUsecase;
  AuthBloc({required this.createUserUsecase}) : super(const AuthState(status: AuthStatus.initial)) {
    on<CreateUserEvent>((event, emit) async {
      final result = await createUserUsecase.call(UserModel(id: UniqueKey().toString(), username: event.username, phoneNumber: event.phoneNumber));
      if (result.isRight) {
        if (result.right[1]) {
          List<UserModel> accounts = await HiveService.instance.readData(key: 'accounts') ?? [];

          accounts.add(result.right[0]);
          HiveService.instance.writeData(key: 'accounts', value: accounts);
          emit(AuthState(status: AuthStatus.authorized));
        } else if (!result.right[1]) {
          emit(AuthState(status: AuthStatus.unauthorized));
        }
      } else {
        print(result.left);
        emit(AuthState(status: AuthStatus.failure));
      }
    });
  }
}
