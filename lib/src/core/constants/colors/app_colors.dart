import 'package:flutter/material.dart';

class AppColors {
  AppColors.init();
  static AppColors get instance => _instance;
  static final AppColors _instance = AppColors.init();

  final Color white = const Color(0xffFFFFFF);
  final Color blue = const Color(0xff0088CC);
  final Color grey = const Color(0xff787878);
  final Color red = const Color(0xffFF0000);
}
