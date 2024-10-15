import 'package:chat_web/src/core/utils/local_db_service.dart';
import 'package:chat_web/src/features/auth/data/data_source/auth_data_source.dart';
import 'package:chat_web/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:chat_web/src/features/auth/domain/usecase/create_user_usecase.dart';
import 'package:chat_web/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_web/src/features/auth/presentation/screen/hello_screen.dart';
import 'package:chat_web/src/features/home/presentation/screen/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main(List<String> args)async{
  final Dio dio = Dio();
  final String? uid = await LocalDbService.instance.readData(key: 'uid');
  await Hive.initFlutter();
  await Hive.openBox('userStatus');
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
      ],
      child: ChatWeb(uid: uid),
    ),
  );
}

class ChatWeb extends StatelessWidget {
  final String? uid;
  const ChatWeb({super.key, this.uid});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Telegram',
      theme: ThemeData.light(),
      home: uid == null ? HelloScreen() : HomeScreen(),
    );
  }
}
