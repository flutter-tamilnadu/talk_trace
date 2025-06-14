import 'package:get_storage/get_storage.dart';

class Storage {
  static final GetStorage _box = GetStorage();

  static Future<void> init() async {
    await GetStorage.init();
  }

  static void write(String key, dynamic value) {
    _box.write(key, value);
  }

  static T? read<T>(String key) {
    return _box.read<T>(key);
  }

  static void remove(String key) {
    _box.remove(key);
  }

  static void erase() {
    _box.erase();
  }
}