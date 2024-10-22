import 'dart:typed_data';
import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:chat_web/src/core/constants/vectors/app_vectors.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/foundation.dart' as foundation;

class FileDialog extends StatefulWidget {
  final List<Uint8List?> fileBytes;

  const FileDialog({super.key, required this.fileBytes});

  @override
  State<FileDialog> createState() => _FileDialogState();
}

class _FileDialogState extends State<FileDialog> {
  bool compressImage = false;
  final TextEditingController captionController = TextEditingController();
  final FocusNode captionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      captionFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    captionFocusNode.dispose();
    captionController.dispose();
    super.dispose();
  }

  void deleteImage(int index) {
    setState(() {
      widget.fileBytes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.instance.white,
      content: SizedBox(
        width: 300,
        height: 600,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(captionFocusNode);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.fileBytes.length} images selected',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(captionFocusNode);
                      },
                      icon: const Icon(Icons.more_vert_rounded),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: widget.fileBytes.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            height: 250,
                            width: 250,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(widget.fileBytes[index]!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.instance.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(captionFocusNode);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    child: const Icon(CupertinoIcons.arrow_swap,
                                        color: Colors.grey, size: 12),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: () {
                                    deleteImage(index);
                                    FocusScope.of(context)
                                        .requestFocus(captionFocusNode);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    child: const Icon(Icons.delete,
                                        color: Colors.grey, size: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.grey,
                      disabledColor: Colors.blue,
                    ),
                    child: Checkbox(
                      value: compressImage,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          compressImage = value!;
                          FocusScope.of(context).requestFocus(captionFocusNode);
                        });
                      },
                    ),
                  ),
                  const Text('Compress the image'),
                ],
              ),
              TextField(
                controller: captionController,
                focusNode: captionFocusNode,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: 'Caption',
                  labelStyle: const TextStyle(color: Colors.blue),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              content: SizedBox(
                                height: 500,
                                width: 500,
                                child: EmojiPicker(
                                  onEmojiSelected: (category, emoji) {
                                    setState(() {
                                      captionController.text += emoji.emoji;
                                      captionController.selection =
                                          TextSelection.fromPosition(
                                        TextPosition(
                                            offset:
                                                captionController.text.length),
                                      );
                                    });
                                  },
                                  config: Config(
                                    height: 256,
                                    checkPlatformCompatibility: true,
                                    emojiViewConfig: EmojiViewConfig(
                                      backgroundColor: AppColors.instance.white,
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
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Add',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        TextButton(
          onPressed: () {
            // String caption = captionController.text;
            // bool shouldCompress = compressImage;

            Navigator.pop(context);
          },
          child: const Text(
            'Send',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
