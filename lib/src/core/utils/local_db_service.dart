import 'package:chat_web/src/core/model/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static late Box box;
  static const chatBox = 'chat_box';

  //! Singleton
  HiveService.init();
  static HiveService get instance => _instance;
  static final HiveService _instance = HiveService.init();

  //! init
  Future<void> createBox() async {
    box = await Hive.openBox(chatBox);
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(UserModelAdapter());
    }
  }

  //! write
  Future<void> writeData({required key, required value}) async {
    await box.put(key, value);
    print('write ${[
      key,
      value
    ]}');
  }

  //! read
  Future<dynamic>? readData({required key}) {
    print(box.get(key));
    return box.get(key, defaultValue: null);
  }

  //! read all
  Map get readAllData {
    return box.toMap();
  }

  //! delete
  void deleteData({required key}) {
    box.delete(key);
    print('Deleted $key');
  }
}
