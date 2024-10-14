import 'package:chat_web/src/core/extension/context_text_theme.dart';
import 'package:chat_web/src/core/extension/size_extenstion.dart';
import 'package:chat_web/src/features/home/presentation/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:chat_web/src/core/constants/vectors/app_vectors.dart';
import 'package:rive/rive.dart';

class RightSideBar extends StatelessWidget {
  final TextEditingController controller;
  const RightSideBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          color: AppColors.instance.white,
          child: ListTile(
            leading: const CircleAvatar(
              radius: 25,
              child: Icon(Icons.person),
            ),
            title: Text(
              'David More',
              style: context.textTheme.titleLarge,
            ),
            subtitle: Text(
              'last seen 5 mins ago',
              style: context.textTheme.titleMedium?.copyWith(
                color: AppColors.instance.grey,
              ),
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: RiveAnimation.asset(
                  'assets/images/breathing_animation.riv',
                  fit: BoxFit.cover,
                  onInit: (p0) {
                    print('ON INIT WORKED ${p0.artboard}');
                  },
                  behavior: RiveHitTestBehavior.translucent,
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: AppColors.instance.blue,
              //     image: DecorationImage(
              //       fit: BoxFit.cover,
              //       image: AssetImage(AppVectors.instance.backgroundPattern),
              //     ),
              //   ),
              // ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CustomTextField(controller: controller),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
