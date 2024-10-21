import 'package:chat_web/src/core/extension/context_text_theme.dart';
import 'package:chat_web/src/core/extension/size_extenstion.dart';
import 'package:chat_web/src/core/utils/local_db_service.dart';
import 'package:chat_web/src/core/utils/save_last_seen.dart';
import 'package:chat_web/src/features/auth/data/model/chat_model.dart';
import 'package:chat_web/src/features/auth/data/model/chatting_model.dart';
import 'package:chat_web/src/features/home/presentation/widget/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:chat_web/src/core/constants/vectors/app_vectors.dart';

class RightSideBar extends StatefulWidget {
  final TextEditingController controller;

  RightSideBar({
    super.key,
    required this.controller,
  });

  @override
  State<RightSideBar> createState() => _RightSideBarState();
}

class _RightSideBarState extends State<RightSideBar> {
  final UserStatusService _userStatusService = UserStatusService();

  bool _isOnline = true;

  String? _lastSeen;

  late final id;

  @override
  void initState() {
    super.initState();
    LocalDbService.instance.readData(key: 'uid').then((value) {
      id = int.tryParse(value!);
    });
    _isOnline = _userStatusService.getUserStatus();
    _lastSeen = _userStatusService.getLastSeenTime();
  }

  void _toggleStatus() {
    setState(() {
      _isOnline = !_isOnline;
      if (!_isOnline) {
        _lastSeen = TimeOfDay.now().format(context);
        _userStatusService.saveLastSeenTime(_lastSeen!);
      } else {
        _lastSeen = null;
      }

      _userStatusService.saveUserStatus(_isOnline);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pickedChat,
        builder: (context, _, __) {
          if (pickedChat.value != null) {
            return Column(
              children: [
                Container(
                  height: 70,
                  color: AppColors.instance.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      child: Text(
                        pickedChat.value!.name.substring(0, 1),
                        style: context.textTheme.titleLarge!.copyWith(
                          color: AppColors.instance.black,
                        ),
                      ),
                    ),
                    title: Text(
                      pickedChat.value!.name,
                      style: context.textTheme.titleLarge,
                    ),
                    subtitle: Row(
                      children: [
                        if (_isOnline)
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Online',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        if (!_isOnline && _lastSeen != null) ...[
                          Text(
                            'Last seen at $_lastSeen',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            color: AppColors.instance.grey,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.call,
                            color: AppColors.instance.grey,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.sidebar_right,
                            color: AppColors.instance.grey,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _toggleStatus();
                          },
                          icon: Icon(
                            Icons.more_vert,
                            color: AppColors.instance.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.instance.blue,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                AppVectors.instance.backgroundPattern),
                          ),
                        ),
                        child: ListView.separated(
                          reverse: false,
                          itemCount: pickedChat.value!.messages.length,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemBuilder: (context, index) => SizedBox(
                              width: double.infinity,
                              child: Align(
                                alignment: id ==
                                        pickedChat.value!.messages[index].sender
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: id ==
                                          pickedChat
                                              .value!.messages[index].sender
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (id !=
                                        pickedChat
                                            .value!.messages[index].sender)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/images/person${(index + 1) % 35}.png'),
                                        ),
                                      ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: id ==
                                                pickedChat.value!
                                                    .messages[index].sender
                                            ? AppColors.instance.green
                                            : AppColors.instance.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        pickedChat
                                            .value!.messages[index].message,
                                      ),
                                    ),
                                    if (id ==
                                        pickedChat
                                            .value!.messages[index].sender)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/images/person${(index + 1) % 35}.png'),
                                        ),
                                      ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        width: context.w * 0.87,
                        child: CustomTextField(index: pickedChatIndex),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.instance.blue,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(AppVectors.instance.backgroundPattern),
                ),
              ),
              child: Center(
                child: SizedBox(
                  height: 30,
                  width: 260,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.instance.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Select a chat to Start Messaging',
                        style: context.textTheme.titleMedium!
                            .copyWith(color: AppColors.instance.white),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}

ValueNotifier<ChatModel?> pickedChat = ValueNotifier(null);
int pickedChatIndex = -1;
