import 'package:shared_preferences/shared_preferences.dart';

class PrefManager{
  static const String IS_LOGIN = "isLogin";
  static late SharedPreferences _preferences;

  static Future<SharedPreferences?> init() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }


  static bool getLoginStatus() {
    return _preferences.getBool(IS_LOGIN) ?? false;
  }

  static void updateLoginStatus(bool status) async {
    await _preferences.setBool(IS_LOGIN, status);
  }
}