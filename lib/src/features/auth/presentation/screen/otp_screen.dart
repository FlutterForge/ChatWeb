import 'dart:math';
import 'dart:async';
import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:chat_web/src/core/constants/vectors/app_vectors.dart';
import 'package:chat_web/src/core/extension/context_text_theme.dart';
import 'package:chat_web/src/core/utils/show_notification.dart';
import 'package:chat_web/src/core/utils/teddy_animation.dart';
import 'package:chat_web/src/features/auth/presentation/screen/create_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rive/rive.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int code = Random().nextInt(89999) + 10000;
  final TextEditingController _codeController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  List<String> animations = [
    TeddyAnimation.idle.name
  ];

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 1500),
      () => showNotification(message:  """🔑 *Your Confirmation Code*:

`$code`

Please enter this code to verify your account."""),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.instance.blue,
        title: Text(
          'Phone Number',
          style: context.textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '+${widget.phoneNumber}',
              style: context.textTheme.headlineLarge,
            ),
            Text(
              'We have sent you and SMS with the code',
              style: context.textTheme.headlineSmall,
            ),
            SizedBox(
              height: 400,
              width: 350,
              child: RiveAnimation.asset(
                fit: BoxFit.contain,
                animations: animations,
                AppVectors.instance.authTeddy,
              ),
            ),
            Form(
              key: _globalKey,
              child: Pinput(
                autofocus: true,
                validator: (value) {
                  if (value == code.toString()) {
                    return null;
                  } else {
                    return 'Invalid OTP';
                  }
                },
                length: 5,
                controller: _codeController,
                onChanged: (value) {
                  setState(() {
                    animations = [
                      TeddyAnimation.hands_up_un_show.name
                    ];
                  });
                },
                onCompleted: (value) {
                  if (_globalKey.currentState!.validate()) {
                    animations = [
                      TeddyAnimation.hands_down.name,
                      TeddyAnimation.success.name,
                    ];
                    Timer(
                      const Duration(milliseconds: 1500),
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateUserScreen(
                              phoneNumber: widget.phoneNumber,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    setState(() {
                      animations = [
                        TeddyAnimation.hands_down.name,
                        TeddyAnimation.fail.name,
                      ];
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () {
                code = Random().nextInt(89999) + 10000;
                showNotification(message:  """🔑 *Your Confirmation Code*:

`$code`

Please enter this code to verify your account.""");
              },
              child: Text(
                'Resend SMS code',
                style: context.textTheme.titleMedium!.copyWith(color: AppColors.instance.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
