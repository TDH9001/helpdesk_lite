import 'package:helpdesk_lite/core/utils/local_storage_service/hive_databases.dart';

import 'package:helpdesk_lite/core/utils/shared_models/user_model.dart';

class UserHiveBox extends HiveDatabases {
  static const String _boxName = 'user';
  static Future<UserModel?> getUserData({required String id}) async {
    final target_data = HiveDatabases.userDataBox.get(_boxName);
    if (target_data != null && target_data is Map) {
      return UserModel.fromJson(Map<String, dynamic>.from(target_data));
    }
    return null;
  }

  static Future<void> addUserDataToBox({required UserModel model}) async {
    await HiveDatabases.userDataBox.put(_boxName, model.toJson());
  }

  static Future<void> removeUserDataFromBox() async {
    await HiveDatabases.userDataBox.delete(_boxName);
  }
}
