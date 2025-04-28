import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageHelper {
  FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();

  write(String value, String key) {
    flutterSecureStorage.write(key: key, value: value);
  }

  Future<String?> readKey(String key) async {
    return await flutterSecureStorage.read(key: key);
  }

  delete(String key) {
    flutterSecureStorage.delete(key: key);
  }

  deleteAll() {
    flutterSecureStorage.deleteAll();
  }
}
