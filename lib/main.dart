import 'package:chat_web/src/features/auth/data/data_source/auth_data_source.dart';
import 'package:chat_web/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:chat_web/src/features/auth/domain/usecase/create_user_usecase.dart';
import 'package:chat_web/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_web/src/features/auth/presentation/screen/hello_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
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
      ],
      child: const ChatWeb(),
    ),
  );
}

class ChatWeb extends StatelessWidget {
  const ChatWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Telegram',
      theme: ThemeData.light(),
      home: const HelloScreen(),
    );
  }
}
