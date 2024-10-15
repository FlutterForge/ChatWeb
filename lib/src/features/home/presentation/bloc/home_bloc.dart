import 'package:chat_web/src/features/home/domain/get_user_info_usecase.dart';
import 'package:chat_web/src/features/home/presentation/bloc/home_event.dart';
import 'package:chat_web/src/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserInfoUsecase getUserInfoUsecase;

  HomeBloc({required this.getUserInfoUsecase})
      : super(HomeState(status: HomeStatus.initial)) {
    on<GetUserInfoEvent>((event, emit) async {
      try {
        final result = await getUserInfoUsecase.call(event.id);
        if (result.isRight) {
          print('SUCCESS CAME');
          emit(state.copyWith(
              status: HomeStatus.success, userModel: result.right));
        } else {
          print('EXCEPTION CAME');
          throw Exception(result.left);
        }
      } catch (e) {
        print('$e');
        emit(state.copyWith(status: HomeStatus.error));
      }
    });
  }
}
