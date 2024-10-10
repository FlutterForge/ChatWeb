import 'package:chat_web/src/constants/colors/app_colors.dart';
import 'package:chat_web/src/core/extension/size_extenstion.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isToMakeSmall = false;
  double _width = 400;
  bool _isResizable = false;

  Offset _lastCursorPosition = Offset(0, 0);

  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      drawer: Drawer(
        child: Container(
          child: IconButton(
              onPressed: () {
                _scafoldKey.currentState!.closeDrawer();
              },
              icon: Icon(Icons.one_x_mobiledata)),
          width: 300,
          color: Colors.blue,
        ),
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
                  scafoldKey: _scafoldKey,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.resizeColumn,
                  onEnter: (event) {
                    isToMakeSmall = true;
                    _lastCursorPosition = event.position;
                    setState(() {});
                    print('kirdi');
                  },
                  onExit: (event) {
                    isToMakeSmall = false;
                    setState(() {});
                    print('chiqdi');
                  },
                  child: GestureDetector(
                    onPanStart: (details) {
                      _isResizable = true;
                      setState(() {});
                    },
                    onPanUpdate: (details) {
                      print('CURRENT OFFSET ${details.globalPosition}');
                      if (details.globalPosition.dx < 260) {
                        return;
                      }
                      _width +=
                          details.globalPosition.dx - _lastCursorPosition.dx;
                      _lastCursorPosition = details.globalPosition;
                      setState(() {});
                    },
                    onPanEnd: (details) {
                      _isResizable = false;
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
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.instance.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16)),
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1720048170996-40507a45c720?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxfHx8ZW58MHx8fHx8'),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class ChatUsersWidget extends StatelessWidget {
  const ChatUsersWidget({
    super.key,
    required this.scafoldKey,
  });

  final GlobalKey<ScaffoldState> scafoldKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
      children: [
        Scrollbar(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 100),
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
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
              );
            },
          ),
        ),
        Positioned(
            child: Container(
          color: AppColors.instance.blue,
          child: ListTile(
              title: Text('Chats'),
              leading: IconButton(
                  onPressed: () {
                    scafoldKey.currentState!.openDrawer();
                  },
                  icon: Icon(Icons.menu))),
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
            return AnimatedContainer(
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
