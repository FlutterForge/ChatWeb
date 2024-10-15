import 'package:chat_web/src/core/extension/context_text_theme.dart';
import 'package:chat_web/src/core/extension/size_extenstion.dart';
import 'package:chat_web/src/core/utils/save_last_seen.dart';
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
    return Column(
      children: [
        Container(
          height: 70,
          color: AppColors.instance.white,
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/images/jamol.png'),
            ),
            title: Text(
              'Jamol Kholmirzaev',
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
                  onPressed: () {
                  },
                  icon: Icon(
                    Icons.search,
                    color: AppColors.instance.grey,
                  ),
                ),
                IconButton(
                  onPressed: () {                  },
                  icon: Icon(
                    Icons.call,
                    color: AppColors.instance.grey,
                  ),
                ),
                IconButton(
                  onPressed: () {                  },
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
              ),
              Positioned(
                  bottom: 0,
                  width: context.w * 0.87,
                  child: CustomTextField(controller: widget.controller)),
            ],
          ),
        ),
      ],
    );
  }
}
