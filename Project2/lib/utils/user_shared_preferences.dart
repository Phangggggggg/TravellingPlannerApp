import 'package:shared_preferences/shared_preferences.dart';
class UserSharedPreference {
  static late SharedPreferences _preferences;

  static const _keyUser = 'user';
  
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

 

  static Future setUser(String userId, String username, String email) async {
    List<String> lst = [userId, username, email]; 
    await _preferences.setStringList(_keyUser, lst);
  }

  static List<String> getUser() {
    if (_preferences.getStringList(_keyUser) != null) {
      return _preferences.getStringList(_keyUser)!;
    }
    return [];
  }

  static void deleteUser() async {
    await _preferences.remove(_keyUser);
  }
}