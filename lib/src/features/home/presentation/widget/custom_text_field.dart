import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:chat_web/src/core/constants/vectors/app_vectors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;

  const CustomTextField({super.key, required this.controller});

  @override
  State<CustomTextField> createState() => _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.infinity,
      color: AppColors.instance.white,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppVectors.instance.stickers),
          ),
          Expanded(
            child: CupertinoTextField(
              placeholder: 'Message',
              padding: const EdgeInsets.symmetric(horizontal: 10),
              suffix: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(widget.controller.text.isEmpty ? AppVectors.instance.attachFile : AppVectors.instance.send),
              ),
              controller: widget.controller,
              onChanged: (value) {
                if (widget.controller.text.length == 1 || widget.controller.text.isEmpty) {
                  setState(() {});
                }
              },
              decoration: BoxDecoration(
                color: AppColors.instance.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Visibility(
            visible: widget.controller.text.isEmpty,
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppVectors.instance.microphone),
            ),
          ),
        ],
      ),
    );
  }
}
