import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {

  final User? user;
  String userId;
  HiveService(this.user, {this.userId = '0'});

  String get _boxName => 'hiveManager_$userId';

  Future<void> init() async {
    userId = user?.uid.substring(user!.uid.length - 8) ?? '';
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
    await Hive.close();
  }
}
