import 'package:chat_web/src/core/extension/print_styles.dart';
import 'package:chat_web/src/core/usecase/usecase.dart';
import 'package:chat_web/src/features/auth/data/model/chat_model.dart';
import 'package:chat_web/src/features/home/data/data_source/home_data_soure.dart';
import 'package:chat_web/src/features/home/domain/create_group_use_case.dart';
import 'package:chat_web/src/features/home/domain/get_all_chats_user_case.dart';
import 'package:chat_web/src/features/home/domain/get_user_info_usecase.dart';
import 'package:chat_web/src/features/home/domain/send_message_use_case.dart';
import 'package:chat_web/src/features/home/presentation/bloc/home_event.dart';
import 'package:chat_web/src/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserInfoUsecase getUserInfoUsecase;
  final CreateGroupUseCase createGroupUseCase;
  final GetAllChatsUserCase getAllChatsUserCase;
  final SendMessageUseCase sendMessageUseCase;
  HomeBloc(
      {required this.getAllChatsUserCase,
      required this.createGroupUseCase,
      required this.sendMessageUseCase,
      required this.getUserInfoUsecase})
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
      'GET ALL CHATS WORKED'.printError();
      final resul = await getAllChatsUserCase.call(NoParams());
      if (resul.isRight) {
        'DATA CAME ALL CHATS ${resul.right.length}'.printNormal();
        emit(state.copyWith(status: HomeStatus.success, chats: resul.right));
      } else {
        'ERROR ON GETTING ALL CHATS ${resul.left}'.printError();
        emit(state.copyWith(status: HomeStatus.error));
      }
    });
    on<SendMesasgeEvent>((event, emit) {
      'send data ${event.data.toJson()} | ${event.index}'.printWarning();
      try {
        sendMessageUseCase
            .call([event.data, state.chats[event.index].id]).then((result) {
          if (result.isRight) {
            try {
              List<ChatModel> temp = List.from(state.chats);
              print('ENGLISH ${temp[event.index].toJson()}');
              temp[event.index].messages.add(event.data);
              emit(HomeState(status: HomeStatus.initial));
              emit(HomeState(status: HomeStatus.success, chats: temp));
            } catch (e) {
              print('ERROR FDSFDSFDSFSDFDS $e ');
            }
          } else {
            print('BLOC ERROR ON SEND');
            throw Exception(result.left);
          }
        });
        print('FUNCTION WORKED');
      } catch (e) {
        emit(state.copyWith(status: HomeStatus.error));
      }
    });
  }
}

// ! create group
ValueNotifier<bool> isLoadingToCreate = ValueNotifier(false);
