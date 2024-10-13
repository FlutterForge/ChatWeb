import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:chat_web/src/core/extension/size_extenstion.dart';
import 'package:chat_web/src/features/home/presentation/widget/right_side_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  void dispose() {
    _chattingController.dispose();
    super.dispose();
  }

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
              icon: const Icon(CupertinoIcons.xmark)),
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
                      if (details.globalPosition.dx < 260) {
                        return;
                      }
                      _width += details.globalPosition.dx - _lastCursorPosition.dx;
                      _lastCursorPosition = details.globalPosition;
                      setState(() {});
                    },
                    onPanEnd: (details) {
                      isResizable = false;
                      setState(() {});
                    },
                    child: AnimatedContainer(
                      curve: Curves.linear,
                      duration: const Duration(milliseconds: 400),
                      color: isToMakeSmall ? AppColors.instance.grey : Colors.transparent,
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
              controller: _chattingController,
            ),
          )
        ],
      ),
    );
  }
}

void _showContextMenu(BuildContext context, Offset position) async {
  final RenderBox overLay = Overlay.of(context).context.findRenderObject() as RenderBox;

  await showMenu(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    color: AppColors.instance.white,
    context: context,
    shadowColor: AppColors.instance.blue,
    position: RelativeRect.fromLTRB(position.dx + 200, position.dy, overLay.size.width - position.dx, overLay.size.height - position.dy),
    items: [
      const PopupMenuItem(
        mouseCursor: SystemMouseCursors.allScroll,
        textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
        value: 'delete',
        child: Text("Delete"),
      ),
      const PopupMenuItem(
        value: 'pin',
        child: Text("Pin"),
      ),
    ],
  ).then((value) {
    if (value == 'delete') {
    } else {}
  });
}

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
              _showContextMenu(context, position);
            },
            child: Container(
              padding: const EdgeInsets.only(bottom: 7,top: 7),
              decoration: BoxDecoration(
                color: _hoveredIndex == index 
                    ? AppColors.instance.grey.withValues(alpha: 0.4) 
                    : Colors.white
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.instance.blue,
                  child: Icon(Icons.person),
                ),
                title: const Text(
                  'John Wick',
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
            title: const Text('Chats'),
            leading: IconButton(
              onPressed: () {
                widget.scafoldKey.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
          ),
        ))
      ],
    ));
  }
}

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
            color: _isPicked.value ? AppColors.instance.blue : AppColors.instance.white,
            child: const ListTile(
              title: Text('Username'),
              subtitle: Text('desctiption'),
            ),
          );
        },
      ),
    );
  }
}
