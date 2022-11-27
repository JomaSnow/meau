import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _localSotrage;

  static const String _userKey = "userId";

  static Future init() async =>
      _localSotrage = await SharedPreferences.getInstance();

  static Future storeUserId(String id) async {
    await _localSotrage?.setString(_userKey, id);
  }

  static String? getUserId() {
    return _localSotrage?.getString(_userKey);
  }

  static Future deleteUserId() async {
    await _localSotrage?.remove(_userKey);
  }
}
