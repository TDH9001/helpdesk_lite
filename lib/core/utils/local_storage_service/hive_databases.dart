import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabases {
  static late Box userDataBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    userDataBox = await Hive.openBox('user');
  }
}
