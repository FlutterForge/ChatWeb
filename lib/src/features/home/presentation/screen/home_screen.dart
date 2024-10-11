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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      drawer: Drawer(
        child: Container(
          width: 300,
          color: Colors.blue,
          child: IconButton(
              onPressed: () {
                _scafoldKey.currentState!.closeDrawer();
              },
              icon: Icon(Icons.one_x_mobiledata)),
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
<<<<<<< HEAD
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
=======
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.instance.blue,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16)),
                  image: const DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1720048170996-40507a45c720?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxfHx8ZW58MHx8fHx8'),
                  )),
>>>>>>> 2760970 (Resolved merge conflict)
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
<<<<<<< HEAD
=======

class ChatUsersWidget extends StatelessWidget {
  const ChatUsersWidget({
    super.key,
    required this.scafoldKey,
    required this.globalContext,
  });

  final GlobalKey<ScaffoldState> scafoldKey;

  final BuildContext globalContext;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
      children: [
        Scrollbar(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 100),
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onDoubleTap: () {
                    RenderBox itemBox = context.findRenderObject() as RenderBox;
                    Offset position = itemBox.localToGlobal(Offset.zero);
                    _showContextMenu(context, position);
                  },
                  onSecondaryTapDown: (details) {},
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      child: Icon(Icons.person),
                    ),
                    title: Text(
                      'John Wick',
                    ),
                    subtitle: Text(
                      "What'st up?",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      "${DateTime.now().day}/${DateTime.now().month}",
                    ),
                  ),
                );
              });
          ),
        ),
        Positioned(
            child: Container(
          color: AppColors.instance.blue,
          child: ListTile(
              title: const Text('Chats'),
              leading: IconButton(
                  onPressed: () {
                    scafoldKey.currentState!.openDrawer();
                  },
                  icon: const Icon(Icons.menu))),
        ))
      ],
    ));
  }
}

// ignore: must_be_immutable
class UserCardWidget extends StatelessWidget {
  UserCardWidget({super.key});

  final ValueNotifier<bool> _isPicked = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.grab,
      onEnter: (event) => _isPicked.value = true,
      onExit: (event) => _isPicked.value = false,
      child: ValueListenableBuilder(
          valueListenable: _isPicked,
          builder: (context, _, __) {
            return AnimatedCfontainer(
              height: _isPicked.value ? 60 : 80,
              duration: const Duration(milliseconds: 500),
              color: _isPicked.value
                  ? AppColors.instance.blue
                  : AppColors.instance.white,
              child: const ListTile(
                title: Text('Username'),
                subtitle: Text('desctiption'),
              ),
            );
          }),
    );
  }
}
>>>>>>> 2760970 (Resolved merge conflict)
