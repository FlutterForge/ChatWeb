import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

void showContextMenu({required BuildContext context, required Offset position, required List<PopupMenuItem> items}) async {
  final RenderBox overLay = Overlay.of(context).context.findRenderObject() as RenderBox;

  await showMenu(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    color: AppColors.instance.white,
    context: context,
    shadowColor: AppColors.instance.blue,
    position: RelativeRect.fromLTRB(position.dx, position.dy, overLay.size.width - position.dx, overLay.size.height - position.dy),
    items: items,
  );
}
