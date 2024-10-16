import 'package:chat_web/src/core/extension/context_text_theme.dart';
import 'package:chat_web/src/core/extension/size_extenstion.dart';
import 'package:chat_web/src/core/utils/save_last_seen.dart';
import 'package:chat_web/src/features/auth/data/model/chat_model.dart';
import 'package:chat_web/src/features/home/presentation/widget/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:chat_web/src/core/constants/vectors/app_vectors.dart';

class RightSideBar extends StatefulWidget {
  final TextEditingController controller;
  final ChatModel? model;

  RightSideBar({
    super.key,
    required this.controller,
    this.model,
  });

  @override
  State<RightSideBar> createState() => _RightSideBarState();
}

class _RightSideBarState extends State<RightSideBar> {
  final UserStatusService _userStatusService = UserStatusService();

  bool _isOnline = true;

  String? _lastSeen;

  @override
  void initState() {
    super.initState();
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
    return widget.model == null
        ? Container(
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
                    color: AppColors.instance.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Select a chat to Start Messaging',
                      style: context.textTheme.titleMedium!.copyWith(color: AppColors.instance.white),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Column(
            children: [
              Container(
                height: 70,
                color: AppColors.instance.white,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    child: Text(
                      widget.model!.name.substring(0, 1),
                    ),
                  ),
                  title: Text(
                    widget.model!.name,
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
                          image: AssetImage(AppVectors.instance.backgroundPattern),
                        ),
                      ),
                      child: ListView.separated(
                        itemCount: widget.model!.messages.length,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        separatorBuilder: (context, index) => const SizedBox(height: 20),
                        itemBuilder: (context, index) => SizedBox(
                          width: double.infinity,
                          child: Align(
                            alignment: widget.model!.id == widget.model!.messages[index].sender ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.instance.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                widget.model!.messages[index].message,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(bottom: 0, width: context.w * 0.87, child: CustomTextField(controller: widget.controller)),
                  ],
                ),
              ),
            ],
          );
  }
}
