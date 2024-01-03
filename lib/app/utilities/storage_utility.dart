import 'package:get_storage/get_storage.dart';

class StorageUtility {
  StorageUtility._();

  static final box = GetStorage();

  static void cleanStorage() {
    // clean cash
   // removeKey(tokenKey);
  }

  static void saveInStorage(String key, String value) {
    box.write(key, value);
  }

  static Future<String?> readFromStorage(String key) async {
    return box.read(key);
  }

  static String? readKey(String key) {
    String? value = box.read(key);

    return value;
  }

  static void removeKey(String key) {
    box.remove(key);
  }
}
