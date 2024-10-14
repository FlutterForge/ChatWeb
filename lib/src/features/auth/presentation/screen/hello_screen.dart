import 'package:chat_web/src/core/constants/vectors/app_vectors.dart';
import 'package:chat_web/src/core/extension/context_text_theme.dart';
import 'package:chat_web/src/core/extension/size_extenstion.dart';
import 'package:chat_web/src/features/auth/presentation/screen/number_login_screen.dart';
import 'package:chat_web/src/features/auth/presentation/widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class HelloScreen extends StatelessWidget {
  const HelloScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        title: 'Start Messaging',
        onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NumberLoginScreen()),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              height: context.h * 0.2,
              width: context.w * 0.2,
              AppVectors.instance.icon,
            ),
            const SizedBox(height: 20),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: 'Telegram\n',
                style: context.textTheme.titleLarge,
                children: <InlineSpan>[
                  TextSpan(
                    text: """The world‘s fastest messaging app.
        It is free and secure.""",
                    style: context.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
