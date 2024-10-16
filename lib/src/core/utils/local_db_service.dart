import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDbService {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  LocalDbService.init();
  static LocalDbService get instance => _instance;
  static final LocalDbService _instance = LocalDbService.init();

  //! Write value
  void writeData({required String key, required String value}) async {
    await storage.write(key: key, value: value);
    print("wrote $value");
  }

  //! Read value
  Future<String?> readData({required key}) async {
      String? value = await storage.read(key: key);
      print("red ${await storage.read(key: key)}");
      return value;
  }

  //! Delete value
  void deleteData({required String key}) async {
    await storage.delete(key: key);
    print("deleted $key");
  }
}
