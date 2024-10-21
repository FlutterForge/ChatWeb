import 'package:chat_web/src/features/auth/data/model/chat_model.dart';
import 'package:chat_web/src/features/auth/data/model/user_model.dart';
import 'package:chat_web/src/features/home/presentation/widget/add_members.dart';
import 'package:chat_web/src/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({this.userModel, super.key});

  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    List<Color> avaeterBg = [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.yellow,
      Colors.purple,
      Colors.pink
    ];
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
                  backgroundColor: (avaeterBg..shuffle()).first,
                  child: Text(
                    userModel?.username.substring(0, 1) ?? '',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  userModel?.username ?? 'No name',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Set Emoji Status',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('New Group'),
            onTap: () {
              _showNewGroupDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.campaign),
            title: const Text('New Channel'),
            onTap: () {
              _showNewChannelDialog(context);
            },
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
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => SettingsScreen(
                  userModel: userModel,
                ),
              );
            },
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

  void _showNewGroupDialog(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    final TextEditingController controller = TextEditingController();
    bool _isGroupNameValid = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Container(
                    width: 350,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.blue,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Group name',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: _isGroupNameValid
                                          ? Colors.blue
                                          : Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    focusNode: focusNode,
                                    controller: controller,
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: _isGroupNameValid
                                                ? Colors.blue
                                                : Colors.red),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: _isGroupNameValid
                                                ? Colors.blue
                                                : Colors.red),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8),
                                      isDense: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (controller.text.isEmpty) {
                                  setState(() {
                                    _isGroupNameValid = false;
                                  });
                                } else {
                                  setState(() {
                                    _isGroupNameValid = true;
                                  });
                                  Navigator.of(context).pop();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AddMembersDialog(
                                        chatModel: ChatModel(
                                          id: 0,
                                          name: controller.text,
                                          chatType: 'group',
                                          participants: [0, 1, 2, 4],
                                          link:
                                              'https://t.me/${controller.text}',
                                          messages: [],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Text(
                                'Next',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showNewChannelDialog(BuildContext context) {
    final FocusNode nameFocusNode = FocusNode();
    final FocusNode descriptionFocusNode = FocusNode();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      nameFocusNode.requestFocus();
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Container(
                width: 350,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                focusNode: nameFocusNode,
                                controller: nameController,
                                decoration: InputDecoration(
                                  hintText: 'Channel name',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  isDense: true,
                                ),
                                onTap: () {
                                  nameFocusNode.requestFocus();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      focusNode: descriptionFocusNode,
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Description (optional)',
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Create',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
