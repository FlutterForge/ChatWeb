import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:chat_web/src/core/extension/size_extenstion.dart';
import 'package:chat_web/src/core/utils/key_board_listen_function.dart';
import 'package:chat_web/src/core/utils/local_db_service.dart';
import 'package:chat_web/src/core/utils/show_notification.dart';
import 'package:chat_web/src/features/auth/data/model/user_model.dart';
import 'package:chat_web/src/features/auth/presentation/screen/hello_screen.dart';
import 'package:chat_web/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:chat_web/src/features/home/presentation/bloc/home_event.dart';
import 'package:chat_web/src/features/home/presentation/bloc/home_state.dart';
import 'package:chat_web/src/features/home/presentation/widget/chat_user_widget.dart';
import 'package:chat_web/src/features/home/presentation/widget/right_side_bar_widget.dart';
import 'package:chat_web/src/features/home/presentation/widget/users_side_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isToMakeSmall = false;
  double _width = 400;
  bool isResizable = false;
  final TextEditingController _chattingController = TextEditingController();

  Offset _lastCursorPosition = const Offset(0, 0);

  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();

  final Set<LogicalKeyboardKey> _pressedKeys = {};

  final FocusNode _focusNode = FocusNode();

  bool isShowUserInfo = false;

  @override
  void initState() {
    super.initState();
    LocalDbService.instance.readData(key: 'uid').then(
      (value) {
        BlocProvider.of<HomeBloc>(context)
            .add(GetUserInfoEvent(id: value ?? ''));
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _chattingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      autofocus: true,
      focusNode: _focusNode,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          _pressedKeys.add(event.logicalKey);
          print('KEY DOWN EVENT');
        } else if (event is KeyUpEvent) {
          _pressedKeys.remove(event.logicalKey);
          print('KEY UP EVENT');
        }
        onKeyEvent(event, _scafoldKey, _pressedKeys, () {
          if (_width > 300) {
            _width = 250;
            setState(() {});
          } else {
            _width = 400;
            setState(() {});
          }
        }, () {
          print('SHIFT TAP P BOSILDI');
          Navigator.pushAndRemoveUntil(context,
              CupertinoPageRoute(builder: (_) => HelloScreen()), (_) => false);
        });

        if (_pressedKeys.contains(LogicalKeyboardKey.space)) {
          if (isShowUserInfo) {
            setState(() {
              isShowUserInfo = false;
            });
          } else {
            setState(() {
              isShowUserInfo = true;
            });
          }
        }
      },
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == HomeStatus.error) {
            showNotification(message: 'Internet connection error');
          }
          if (state.status == HomeStatus.success) {
            showNotification(message: 'User data came');
          }
        },
        child: Scaffold(
          key: _scafoldKey,
          drawer: CustomDrawer(
            userModel: context.watch<HomeBloc>().state.userModel,
          ),
          body: Row(
            children: [
              Container(
                color: AppColors.instance.white,
                width: _width,
                height: context.h,
                child: Row(
                  children: [
                    ChatUsersWidget(
                      chats: context.watch<HomeBloc>().state.userModel!.chats,
                      globalContext: context,
                      scafoldKey: _scafoldKey,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.resizeColumn,
                      onEnter: (event) {
                        isToMakeSmall = true;
                        _lastCursorPosition = event.position;
                        setState(() {});
                      },
                      onExit: (event) {
                        isToMakeSmall = false;
                        setState(() {});
                      },
                      child: GestureDetector(
                        onPanStart: (details) {
                          isResizable = true;
                          setState(() {});
                        },
                        onPanUpdate: (details) {
                          double delta = details.globalPosition.dx -
                              _lastCursorPosition.dx;

                          double newWidth = _width + delta;

                          if (newWidth >= 260 && newWidth <= 450) {
                            _width = newWidth;
                            _lastCursorPosition = details.globalPosition;
                            setState(() {});
                          }
                          print('WIDTH $_width');
                        },
                        onPanEnd: (details) {
                          isResizable = false;
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          curve: Curves.linear,
                          duration: const Duration(milliseconds: 400),
                          color: isToMakeSmall
                              ? AppColors.instance.grey
                              : Colors.transparent,
                          height: double.infinity,
                          width: isToMakeSmall ? context.w * 0.005 : 1,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: RightSideBar(
                  model: context.watch<HomeBloc>().state.userModel!.chats[0],
                  controller: _chattingController,
                ),
              ),
              Visibility(
                  visible: isShowUserInfo,
                  child: SizedBox(width: 300,child: ProfilePage())),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final UserModel? userModel;

  const CustomDrawer({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Text(
                    userModel!.username.substring(0, 1),
                    style: TextStyle(fontSize: 24, color: Colors.blue),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  userModel!.username,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Row(
                  children: [
                    Text(
                      userModel!.isOnline ? 'online' : 'offline',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: userModel!.isOnline
                          ? AppColors.instance.green
                          : AppColors.instance.red,
                    )
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('New Group'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.campaign),
            title: const Text('New Channel'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('My Stories'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: const Text('Wallet'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.contacts),
            title: const Text('Contacts'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.call),
            title: const Text('Calls'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Saved Messages'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.nightlight_round),
            title: const Text('Night Mode'),
            trailing: Switch(
              value: false,
              onChanged: (bool value) {},
            ),
          ),
        ],
      ),
    );
  }
}

void showContextMenu(BuildContext context, Offset position) async {
  final RenderBox overLay =
      Overlay.of(context).context.findRenderObject() as RenderBox;

  await showMenu(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    color: AppColors.instance.white,
    context: context,
    shadowColor: AppColors.instance.blue,
    position: RelativeRect.fromLTRB(position.dx + 200, position.dy,
        overLay.size.width - position.dx, overLay.size.height - position.dy),
    items: [
      const PopupMenuItem(
        value: 'delete',
        child: Row(
          children: [
            Icon(Icons.delete, color: Colors.red),
            SizedBox(width: 10),
            Text("Delete",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      const PopupMenuItem(
        value: 'pin',
        child: Row(
          children: [
            Icon(Icons.push_pin, color: Colors.blue),
            SizedBox(width: 10),
            Text("Pin", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    ],
  ).then((value) {
    if (value == 'delete') {
    } else {}
  });
}