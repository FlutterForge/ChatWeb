import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:chat_web/src/core/constants/vectors/app_vectors.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart' as foundation;

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
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      content: SizedBox(
                        height: 500,
                        width: 600,
                        child: EmojiPicker(
                          onBackspacePressed: () {
                            // Do something when the user taps the backspace button (optional)
                            // Set it to null to hide the Backspace-Button
                          },
                          config: Config(
                            height: 256,
                            checkPlatformCompatibility: true,
                            emojiViewConfig: EmojiViewConfig(
                              // Issue: https://github.com/flutter/flutter/issues/28894
                              emojiSizeMax: 28 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.20 : 1.0),
                            ),
                            viewOrderConfig: const ViewOrderConfig(
                              top: EmojiPickerItem.categoryBar,
                              middle: EmojiPickerItem.emojiView,
                              bottom: EmojiPickerItem.searchBar,
                            ),
                            skinToneConfig: const SkinToneConfig(),
                            categoryViewConfig: const CategoryViewConfig(),
                            bottomActionBarConfig: const BottomActionBarConfig(),
                            searchViewConfig: const SearchViewConfig(),
                          ),
                        ),
                      ),
                    );
                  });
            },
            icon: SvgPicture.asset(AppVectors.instance.stickers),
          ),
          Expanded(
            child: CupertinoTextField(
              placeholder: 'Message',
              padding: const EdgeInsets.symmetric(horizontal: 10),
              suffix: IconButton(
                onPressed: () async {
                  final data = await FilePicker.platform.pickFiles();
                },
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
          Padding(
            padding: const EdgeInsets.only(right: 205),
            child: Visibility(
              visible: widget.controller.text.isEmpty,
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppVectors.instance.microphone),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
