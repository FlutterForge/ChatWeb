import 'package:flutter/cupertino.dart';

DeviceType checkDeviceWidth(BuildContext context) {
  if (MediaQuery.of(context).size.width > 650) {
    return DeviceType.web;
  } else {
    return DeviceType.mobile;
  }
}

enum DeviceType { mobile, web }

