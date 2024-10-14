import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void onKeyEvent(
    KeyEvent event,
    GlobalKey<ScaffoldState> scafoldKey,
    Set<LogicalKeyboardKey> pressedKeys,
    VoidCallback onSuccess,
    VoidCallback navigation) {
  if (pressedKeys.contains(LogicalKeyboardKey.shiftRight) &&
      pressedKeys.contains(LogicalKeyboardKey.arrowUp)) {
    if (!scafoldKey.currentState!.isDrawerOpen) {
      scafoldKey.currentState!.openDrawer();
    }
  }
  if (pressedKeys.contains(LogicalKeyboardKey.shift) &&
      pressedKeys.contains(LogicalKeyboardKey.arrowDown)) {
    print('>>>>>>>>>>>CLOSE DRAWER<<<<<<<<<<<');
    scafoldKey.currentState!.closeDrawer();
  }

  print('PRESSED KEYS $pressedKeys');

  if (pressedKeys.contains(LogicalKeyboardKey.shiftLeft) &&
      pressedKeys.contains(LogicalKeyboardKey.tab) &&
      pressedKeys.contains(LogicalKeyboardKey.keyP)) {
    print('>>>>>>>>>>>>>>> tab bosildi');
    navigation();
  }

  if (pressedKeys.contains(LogicalKeyboardKey.shiftLeft) &&
      pressedKeys.contains(LogicalKeyboardKey.arrowLeft)) {
    onSuccess();
  }
}
