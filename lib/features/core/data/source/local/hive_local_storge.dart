import 'package:hive_flutter/hive_flutter.dart';

import '../constants/hive_constants.dart';

class HiveLocalStorge {
  static bool _initialized = false;

  static Future<void> openBox() async {
    if (!_initialized) {
      await Hive.initFlutter();
      _initialized = true;
    }
    if (!Hive.isBoxOpen(HiveConstants.mainBox)) {
      await Hive.openBox(HiveConstants.mainBox);
    }
  }

  static Box get _box => Hive.box(HiveConstants.mainBox);

  static Future<void> put({required String key, required dynamic value}) async {
    await _box.put(key, value);
  }

  static Future<dynamic> get({required String key}) async {
    return await _box.get(key);
  }

  static Future<void> delete({required String key}) async {
    return await _box.delete(key);
  }

  static Future<int> clear() async {
    return await _box.clear();
  }
}
