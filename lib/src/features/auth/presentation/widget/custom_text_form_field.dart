import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:chat_web/src/core/extension/context_text_theme.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hinText,
    this.isSecured = false,
    this.textInputAction = TextInputAction.next,
    this.validator,
  });

  final TextEditingController controller;
  final String hinText;
  final bool isSecured;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isSecured;

  @override
  void initState() {
    super.initState();
    isSecured = widget.isSecured;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isSecured,
      style: context.textTheme.titleMedium,
      controller: widget.controller,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        hintText: widget.hinText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        hintStyle: context.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w200, color: AppColors.instance.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }
}