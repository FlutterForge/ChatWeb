import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class UserCardWidget extends StatelessWidget {
  UserCardWidget({super.key});

  final ValueNotifier<bool> _isPicked = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.grab,
      onEnter: (event) => _isPicked.value = true,
      onExit: (event) => _isPicked.value = false,
      child: ValueListenableBuilder(
        valueListenable: _isPicked,
        builder: (context, _, __) {
          return AnimatedContainer(
            height: _isPicked.value ? 60 : 80,
            duration: const Duration(milliseconds: 500),
            color: _isPicked.value
                ? AppColors.instance.blue
                : AppColors.instance.white,
            child: const ListTile(
              title: Text('Username'),
              subtitle: Text('desctiption'),
            ),
          );
        },
      ),
    );
  }
}
