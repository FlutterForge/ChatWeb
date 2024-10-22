import 'package:chat_web/src/core/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.userModel}) : super(key: key);
  final UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    List<Color> avaeterBg = [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.pink,
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              CupertinoIcons.xmark,
              color: Colors.grey,
            ),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Column(
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
                userModel?.username ?? '',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text('last seen today at 12:01 PM',
                  style: TextStyle(color: Colors.grey)),
            ],
          ),
          Divider(
            thickness: 12,
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: Colors.black,
            ),
            title: Text(userModel?.phoneNumber ?? '',),
            subtitle: Text('Mobile'),
          ),
          ListTile(
            title: Text(
                'Flutter Dev 🚀 | Building beautiful, cross-platform apps'),
            subtitle: Text('Bio'),
          ),
          ListTile(
            title: Text(
              '@${userModel?.username.replaceAll(' ', '') ?? ''}',
              style: TextStyle(color: Colors.blue),
            ),
            subtitle: Text('Username'),
            trailing: Icon(
              Icons.qr_code_rounded,
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Apr 22, 2002 (22 years old)'),
            subtitle: Text('Date of birth'),
          ),
          SwitchListTile(
            value: true,
            onChanged: (bool value) {
              value = !value;
            },
            title: Text('Notifications'),
            secondary: Icon(Icons.notifications),
          ),
          Divider(
            thickness: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 10),
                          child: Icon(CupertinoIcons.play_circle),
                        ),
                        Text('42 posts',
                            style: TextStyle(
                              fontSize: 18,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 10),
                          child: Icon(CupertinoIcons.photo),
                        ),
                        Text('122 photos',
                            style: TextStyle(
                              fontSize: 18,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 10),
                          child: Icon(CupertinoIcons.videocam),
                        ),
                        Text('39 videos',
                            style: TextStyle(
                              fontSize: 18,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 10),
                          child: Icon(Icons.file_present_outlined),
                        ),
                        Text('51 files',
                            style: TextStyle(
                              fontSize: 18,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 10),
                          child: Icon(Icons.link),
                        ),
                        Text(
                          '11 shared links',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
