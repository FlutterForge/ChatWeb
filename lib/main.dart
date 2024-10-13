import 'package:flutter/material.dart';

import 'package:chat_web/src/features/home/presentation/screen/home_screen.dart';

void main(List<String> args) {
  runApp(const ChatWeb());
}

class ChatWeb extends StatelessWidget {
  const ChatWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Telegram',
      theme: ThemeData.light(),
      home: const HomeScreen(),
    );
  }
}
