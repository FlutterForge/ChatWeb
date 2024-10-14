import 'dart:async';

import 'package:chat_web/src/core/constants/vectors/app_vectors.dart';
import 'package:chat_web/src/core/extension/size_extenstion.dart';
import 'package:chat_web/src/core/utils/teddy_animation.dart';
import 'package:chat_web/src/features/auth/presentation/screen/otp_screen.dart';
import 'package:chat_web/src/features/auth/presentation/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:chat_web/src/core/extension/context_text_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

class NumberLoginScreen extends StatefulWidget {
  const NumberLoginScreen({super.key});

  @override
  State<NumberLoginScreen> createState() => _NumberLoginScreenState();
}

class _NumberLoginScreenState extends State<NumberLoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();

  List<String> animations = [
    TeddyAnimation.idle.name
  ];

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton.filled(
        padding: const EdgeInsets.all(20),
        onPressed: () {
          if (_phoneNumberController.text.length == 17) {
            setState(() {
              animations = [
                TeddyAnimation.success.name
              ];
            });
            Timer(
              const Duration(milliseconds: 1500),
              () {
                String data = _phoneNumberController.text;
                data = data.replaceAll(RegExp(r'[-() ]'), '');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtpScreen(
                      phoneNumber: data,
                    ),
                  ),
                );
              },
            );
          } else {
            setState(() {
              animations = [
                TeddyAnimation.fail.name
              ];
            });
          }
        },
        icon: SvgPicture.asset(
          colorFilter: ColorFilter.mode(AppColors.instance.white, BlendMode.srcIn),
          AppVectors.instance.send,
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.instance.blue,
        centerTitle: false,
        title: Text(
          'Your Phone',
          style: context.textTheme.titleLarge!.copyWith(color: AppColors.instance.white),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: context.w * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 43),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: 'Your phone number\n',
                  style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
                  children: <InlineSpan>[
                    TextSpan(
                      text: """Please confirm your country code
and enter your phone number.""",
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.instance.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              SizedBox(
                width: context.w * 0.5,
                child: CustomTextField(phoneNumberController: _phoneNumberController),
              ),
              SizedBox(
                height: 400,
                width: context.w * 350,
                child: RiveAnimation.asset(
                  AppVectors.instance.authTeddy,
                  animations: animations,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
