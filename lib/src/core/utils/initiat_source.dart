import 'package:chat_web/main.dart';
import 'package:chat_web/src/core/utils/local_db_service.dart';
import 'package:chat_web/src/features/auth/data/data_source/auth_data_source.dart';
import 'package:chat_web/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:chat_web/src/features/auth/domain/usecase/create_user_usecase.dart';
import 'package:chat_web/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_web/src/features/home/data/data_source/home_data_soure.dart';
import 'package:chat_web/src/features/home/data/repository/home_repository.dart';
import 'package:chat_web/src/features/home/domain/create_group_use_case.dart';
import 'package:chat_web/src/features/home/domain/get_all_chats_user_case.dart';
import 'package:chat_web/src/features/home/domain/get_user_info_usecase.dart';
import 'package:chat_web/src/features/home/domain/send_message_use_case.dart';
import 'package:chat_web/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initialSource() async {
  String? uid;
  await Future.wait([
    Hive.initFlutter(),
    Hive.openBox('userStatus'),
    LocalDbService.instance.readData(key: 'uid').then((value) {
      uid = value;
    })
  ]);
  final Dio dio = Dio();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            createUserUsecase: CreateUserUsecase(
              repository: AuthRepositoryImpl(
                dataSource: AuthDataSourceImpl(dio: dio),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => HomeBloc(
            createGroupUseCase: CreateGroupUseCase(
              repository: HomeRepositoryImpl(
                dataSoure: HomeDataSourceImpl(dio: dio),
              ),
            ),
            getUserInfoUsecase: GetUserInfoUsecase(
              repository: HomeRepositoryImpl(
                dataSoure: HomeDataSourceImpl(dio: dio),
              ),
            ),
            getAllChatsUserCase: GetAllChatsUserCase(
              repository: HomeRepositoryImpl(
                dataSoure: HomeDataSourceImpl(dio: dio),
              ),
            ),
            sendMessageUseCase: SendMessageUseCase(
                repository: HomeRepositoryImpl(
              dataSoure: HomeDataSourceImpl(dio: dio),
            )),
          ),
        )
      ],
      child: ChatWeb(uid: uid),
    ),
  );
}
