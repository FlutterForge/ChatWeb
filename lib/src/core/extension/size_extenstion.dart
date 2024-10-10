import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  double get h => MediaQuery.of(this).size.height;
  double get w => MediaQuery.of(this).size.width;
}
