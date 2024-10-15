import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:chat_web/src/features/home/presentation/screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUsersWidget extends StatefulWidget {
  const ChatUsersWidget({
    super.key,
    required this.scafoldKey,
    required this.globalContext,
  });

  final GlobalKey<ScaffoldState> scafoldKey;

  final BuildContext globalContext;

  @override
  State<ChatUsersWidget> createState() => _ChatUsersWidgetState();
}

Color bg = AppColors.instance.white;
int? _hoveredIndex;

class _ChatUsersWidgetState extends State<ChatUsersWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
      children: [
        Scrollbar(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 60),
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
              return MouseRegion(
                onHover: (details) {
                  setState(() {
                    _hoveredIndex = index;
                  });
                },
                onExit: (details) {
                  setState(() {
                    _hoveredIndex = null;
                  });
                },
                child: GestureDetector(
                  onDoubleTap: () {
                    RenderBox itemBox = context.findRenderObject() as RenderBox;
                    Offset position = itemBox.localToGlobal(Offset.zero);
                    showContextMenu(context, position);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 7, top: 7),
                    decoration: BoxDecoration(
                        color: _hoveredIndex == index
                            ? AppColors.instance.grey //.withValues(alpha: 0.4)
                            : Colors.white),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.instance.blue,
                        child: Icon(Icons.person),
                      ),
                      title: const Text(
                        'Jamol Bro',
                      ),
                      subtitle: Row(
                        children: [
                          index % 2 == 0
                              ? const Text('WhatsApp')
                              : Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: AppColors.instance.blue,
                                    borderRadius: BorderRadius.circular(4),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/background_white_pattern.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: _hoveredIndex == index,
                            child: Transform.rotate(
                              angle: 0.7,
                              child: Icon(
                                CupertinoIcons.pin_fill,
                                color: AppColors.instance.blue,
                                size: 17,
                              ),
                            ),
                          ),
                          Text(
                            "${DateTime.now().day}/${DateTime.now().month}",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
            child: Container(
          color: AppColors.instance.blue,
          child: ListTile(
            title: Text(
              'Chats',
              style: TextStyle(color: AppColors.instance.white),
            ),
            leading: IconButton(
              onPressed: () {
                widget.scafoldKey.currentState!.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: AppColors.instance.white,
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.search,
                color: AppColors.instance.white,
              ),
            ),
          ),
        ))
      ],
    ));
  }
}
