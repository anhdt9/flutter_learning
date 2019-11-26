import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {

  static const String PREF_ID = "id";
  static const String PREF_NAME = "name";
  static const String PREF_URL = "url";
  static const String PREF_EMAIL = "email";
  static const String PREF_PASSWORD = "password";

  static const String PREF_LOGIN = "login";

  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static Future setString(String key, String value) async =>  (await prefs).setString(key, value);
  static Future setInt(String key, int value) async =>  (await prefs).setInt(key, value);
  static Future setBool(String key, bool value) async =>  (await prefs).setBool(key, value);
  static Future setDouble(String key, double value) async =>  (await prefs).setDouble(key, value);
  static Future setStringList(String key, List<String> value) async =>  (await prefs).setStringList(key, value);

  static Future<String> getString(String key) async =>  (await prefs).getString(key) ?? null;
  static Future<int> getInt(String key) async =>  (await prefs).getInt(key) ?? null;
  static Future<bool> getBool(String key) async =>  (await prefs).getBool(key) ?? null;
  static Future<double> getDouble(String key) async =>  (await prefs).getDouble(key) ?? null;
  static Future<List<String>> getStringList(String key) async =>  (await prefs).getStringList(key) ?? null;

//  static getString(String key) async {
//    var result;
//    await _getString(key).then((value) => {result = value});
//    return result;
//  }
//
//  static getInt(String key) async {
//    var result;
//    await _getInt(key).then((value) => {result = value});
//    return result;
//  }
//
//  static getBool(String key) async {
//    var result;
//    await _getBool(key).then((value) => {result = value});
//    return result;
//  }
//
//  static getDouble(String key) async {
//    var result;
//    await _getDouble(key).then((value) => {result = value});
//    return result;
//  }
//
//  static getStringList(String key) async {
//    var result;
//    await _getStringList(key).then((value) => {result = value});
//    return result;
//  }

  static Future remove(String key) async =>  (await prefs).remove(key);


}
