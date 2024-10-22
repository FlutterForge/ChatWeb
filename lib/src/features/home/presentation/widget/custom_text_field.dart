import 'dart:typed_data';
import 'package:chat_web/src/core/model/message_model.dart';
import 'package:chat_web/src/core/utils/local_db_service.dart';
import 'package:chat_web/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:chat_web/src/features/home/presentation/bloc/home_event.dart';
import 'package:chat_web/src/features/home/presentation/widget/selected_file_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:chat_web/src/core/constants/vectors/app_vectors.dart';
import 'package:flutter/foundation.dart' as foundation;

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key, required this.index});

  final int index;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  List<Uint8List?> selectedFiles = [];

  final TextEditingController controller = TextEditingController();

  late final int uid;

  @override
  void initState() {
    super.initState();
    HiveService.instance.readData(key: 'uid')!.then((value) {
      uid = int.tryParse(value!) ?? 0;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
            icon: SvgPicture.asset(AppVectors.instance.attachFile),
          ),
          Expanded(
            child: CupertinoTextField(
              placeholder: 'Message',
              padding: const EdgeInsets.symmetric(horizontal: 10),
              controller: controller,
              onChanged: (value) {
                if (controller.text.length == 1 || controller.text.isEmpty) {
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
                              controller.text += emoji.emoji;
                              controller.selection = TextSelection.fromPosition(
                                TextPosition(offset: controller.text.length),
                              );
                            });
                          },
                          config: Config(
                            height: 256,
                            checkPlatformCompatibility: true,
                            emojiViewConfig: EmojiViewConfig(
                              emojiSizeMax: 28 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.20 : 1.0),
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
              onPressed: () {
                BlocProvider.of<HomeBloc>(context, listen: false).add(
                  SendMesasgeEvent(
                    index: widget.index,
                    data: MessageModel(
                      id: UniqueKey().toString(),
                      sender: uid,
                      message: controller.text,
                      dateTime: DateTime.now().toString(),
                    ),
                  ),
                );
              },
              icon: SvgPicture.asset(controller.text.isEmpty ? AppVectors.instance.microphone : AppVectors.instance.send),
            ),
          ),
        ],
      ),
    );
  }
}
