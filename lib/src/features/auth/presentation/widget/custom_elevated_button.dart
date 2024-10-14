import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:chat_web/src/core/extension/context_text_theme.dart';
import 'package:chat_web/src/core/extension/size_extenstion.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.title, required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        maximumSize: const WidgetStatePropertyAll(Size(400, 60)),
        fixedSize: WidgetStatePropertyAll(
          Size(context.w * 0.5, 60),
        ),
        backgroundColor: WidgetStatePropertyAll(AppColors.instance.blue),
      ),
      onPressed: onTap,
      child: Text(
        title,
        style: context.textTheme.titleMedium!.copyWith(
          color: AppColors.instance.white,
        ),
      ),
    );
  }
}
