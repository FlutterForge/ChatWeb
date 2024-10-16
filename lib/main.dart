import 'package:chat_web/src/core/utils/initiat_source.dart';
import 'package:chat_web/src/features/auth/presentation/screen/hello_screen.dart';
import 'package:chat_web/src/features/home/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main(List<String> args) async {
  await initialSource();
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
