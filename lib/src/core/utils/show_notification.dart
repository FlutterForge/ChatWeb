import 'package:chat_web/src/core/constants/colors/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showNotification({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    fontSize: 24,
    timeInSecForIosWeb: 5,
    webBgColor: "white",
    webPosition: "center",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    backgroundColor: AppColors.instance.white,
    textColor: AppColors.instance.black,
  );
}
