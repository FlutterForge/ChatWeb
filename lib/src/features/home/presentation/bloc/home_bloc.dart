import 'package:chat_web/src/core/extension/print_styles.dart';
import 'package:chat_web/src/features/auth/data/model/chat_model.dart';
import 'package:chat_web/src/features/home/data/data_source/home_data_soure.dart';
import 'package:chat_web/src/features/home/domain/create_group_use_case.dart';
import 'package:chat_web/src/features/home/domain/get_user_info_usecase.dart';
import 'package:chat_web/src/features/home/presentation/bloc/home_event.dart';
import 'package:chat_web/src/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserInfoUsecase getUserInfoUsecase;
  final CreateGroupUseCase createGroupUseCase;
  HomeBloc({required this.createGroupUseCase, required this.getUserInfoUsecase})
      : super(HomeState(status: HomeStatus.initial)) {
    on<GetUserInfoEvent>((event, emit) async {
      try {
        final result = await getUserInfoUsecase.call(event.id);
        if (result.isRight) {
          'SUCCESS CAME ${result.right.toJson()}'.printError();
          emit(state.copyWith(
            status: HomeStatus.success,
            userModel: result.right,
          ));
          add(GetAllChatsEvent());
          'AFTER EMIT WORKED ${state.status}'.printWarning();
        } else {
          print('EXCEPTION CAME');
          throw Exception(result.left);
        }
      } catch (e) {
        print('$e');
        emit(state.copyWith(status: HomeStatus.error));
      }
    });
    on<CreateGroupEvent>((event, emit) async {
      isLoadingToCreate.value = true;
      try {
        final result = await createGroupUseCase.call(event.data);
        if (result.isRight) {
          'Success created group ${state.status}'.printError();
        } else {
          'EXCEPTION CAME'.printError();
          throw Exception(result.left);
        }
      } catch (e) {
        print('$e');
      } finally {
        event.onEnd();
        isLoadingToCreate.value = false;
      }
    });
    on<GetAllChatsEvent>((event, emit) async {
      final resul1 = await HomeDataSourceImpl.instance.getChats();
      if (resul1.runtimeType == List<ChatModel>) {
        emit(state.copyWith(status: HomeStatus.success, chats: resul1));
      } else {
        throw Exception();
      }
    });
  }
}

// ! create group
ValueNotifier<bool> isLoadingToCreate = ValueNotifier(false);
