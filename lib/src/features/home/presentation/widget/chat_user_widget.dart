import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:chat_web/src/core/extension/print_styles.dart';
import 'package:chat_web/src/core/utils/initiat_source.dart';
import 'package:chat_web/src/features/auth/data/model/chat_model.dart';
import 'package:chat_web/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:chat_web/src/features/home/presentation/bloc/home_event.dart';
import 'package:chat_web/src/features/home/presentation/screen/home_screen.dart';
import 'package:chat_web/src/features/home/presentation/widget/right_side_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatUsersWidget extends StatefulWidget {
  final List<ChatModel>? chats;

  const ChatUsersWidget({
    super.key,
    required this.chats,
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
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    'STATE CHATS LENGTH ${widget.chats!.length}'.printWarning();
    return Expanded(
        child: Stack(
      children: [
        Scrollbar(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 60),
            itemCount: widget.chats == null ? 0 : widget.chats!.length,
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
                  onTap: () {
                    context.read<HomeBloc>().add(GetAllChatsEvent());
                    pickedChat.value = widget.chats![index];
                    pickedChatIndex = index;
                    print('after changing $pickedChatIndex');
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
                      title: Text(
                        widget.chats![index].name,
                      ),
                      subtitle: widget.chats![index].messages.isNotEmpty
                          ? Text(widget.chats![index].messages.last.message)
                          : null,
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
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    widget.scafoldKey.currentState!.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: AppColors.instance.white,
                  ),
                ),
                Text(
                  'Chats',
                  style:
                      TextStyle(color: AppColors.instance.white, fontSize: 18),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 30,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search, 
                          color: Colors.white70,
                        ),
                        hintText: 'Search...',
                        hintStyle: TextStyle(
                            color: Colors.white70, fontSize: 15),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.white70,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: AppColors.instance.white,
                            width: 1.0,
                          ),
                        ),
                      ),
                      style: TextStyle(color: AppColors.instance.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ))
      ],
    ));
  }
}
