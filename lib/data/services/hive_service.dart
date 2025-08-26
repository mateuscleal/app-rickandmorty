import 'package:hive_flutter/hive_flutter.dart';

class HiveManager {
  static const String _boxName = 'hiveManager';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  Map<dynamic, dynamic> getValue(int key) {
    final box = Hive.box(_boxName);
    return box.get(key) ?? {};
  }

  static Future<void> setValue(int key, Map<String, dynamic> value) async {
    final box = Hive.box(_boxName);
    await box.put(key, value);
  }
}
