import 'package:hive/hive.dart';

class UserStatusService {
  final Box userStatusBox = Hive.box('userStatus');

  void saveUserStatus(bool isOnline) {
    userStatusBox.put('isOnline', isOnline);
  }

  bool getUserStatus() {
    return userStatusBox.get('isOnline', defaultValue: true);
  }

  void saveLastSeenTime(String lastSeen) {
    userStatusBox.put('lastSeen', lastSeen);
  }

  String? getLastSeenTime() {
    return userStatusBox.get('lastSeen');
  }
}
