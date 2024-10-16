import 'package:chat_web/src/core/utils/local_db_service.dart';
import 'package:chat_web/src/features/auth/data/model/user_model.dart';
import 'package:chat_web/src/features/auth/domain/usecase/create_user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateUserUsecase createUserUsecase;
  AuthBloc({required this.createUserUsecase}) : super(const AuthState(status: AuthStatus.initial)) {
    on<CreateUserEvent>((event, emit) async {
      final result = await createUserUsecase.call(UserModel(username: event.username, phoneNumber: event.phoneNumber));
      if (result.isRight) {
        LocalDbService.instance.writeData(key: 'uid', value: result.right.toString());
        emit(state.copyWith(status: AuthStatus.success));
      } else {
        emit(state.copyWith(status: AuthStatus.failure));
      }
    });
  }
}
