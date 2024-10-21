import 'dart:typed_data';
import 'package:chat_web/src/features/home/presentation/widget/selected_file_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:chat_web/src/core/constants/vectors/app_vectors.dart';
import 'package:flutter/foundation.dart' as foundation;

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;

  const CustomTextField({super.key, required this.controller});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  List<Uint8List?> selectedFiles = []; 

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.infinity,
      color: AppColors.instance.white,
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles(
                allowMultiple: true, 
                type: FileType.any, 
              );
              if (result != null && result.files.isNotEmpty) {
                selectedFiles.clear();
                for (var file in result.files) {
                  if (file.bytes != null) {
                    selectedFiles.add(file.bytes);
                  }
                }

                showDialog(
                  context: context,
                  builder: (_) => FileDialog(
                    fileBytes: selectedFiles,
                  ),
                );
              }
            },
            icon: SvgPicture.asset( AppVectors.instance.attachFile
                ),
          ),

          Expanded(
            child: CupertinoTextField(
              placeholder: 'Message',
              padding: const EdgeInsets.symmetric(horizontal: 10),
              controller: widget.controller,
              onChanged: (value) {
                if (widget.controller.text.length == 1 ||
                    widget.controller.text.isEmpty) {
                  setState(() {});
                }
              },
              decoration: BoxDecoration(
                color: AppColors.instance.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
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
                          onEmojiSelected: (category, emoji) {
                            setState(() {
                              widget.controller.text += emoji.emoji; 
                              widget.controller.selection = TextSelection.fromPosition(
                                TextPosition(offset: widget.controller.text.length), 
                              );
                            });
                          },
                          config: Config(
                            height: 256,
                            checkPlatformCompatibility: true,
                            emojiViewConfig: EmojiViewConfig(
                              emojiSizeMax: 28 *
                                  (foundation.defaultTargetPlatform ==
                                          TargetPlatform.iOS
                                      ? 1.20
                                      : 1.0),
                            ),
                            viewOrderConfig: const ViewOrderConfig(
                              top: EmojiPickerItem.categoryBar,
                              middle: EmojiPickerItem.emojiView,
                              bottom: EmojiPickerItem.searchBar,
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            },
            icon: SvgPicture.asset(AppVectors.instance.stickers), 
          ),
          Padding(
            padding: const EdgeInsets.only(right: 205),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(widget.controller.text.isEmpty
                ? AppVectors.instance.microphone
                : AppVectors.instance.send),
            ),
          ),
        ],
      ),
    );
  }
}
