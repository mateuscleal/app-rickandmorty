import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  final String? userId;

  HiveService(this.userId);

  String get _boxName => 'hiveManager_$userId';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  Map<dynamic, dynamic> getValue(int key) {
    final box = Hive.box(_boxName);
    return box.get(key) ?? {};
  }

  Future<void> setValue(int key, Map<String, dynamic> value) async {
    final box = Hive.box(_boxName);
    await box.put(key, value);
  }

  Future<void> close() async {
    final box = Hive.box(_boxName);
    await box.close();
  }
}
