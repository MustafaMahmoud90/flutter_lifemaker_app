import 'package:shared_preferences/shared_preferences.dart';

class CacheNetwork {
  static late SharedPreferences sharedPref;

  static Future cacheInitialization() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  // set - get - delete - clear ( key , value )
  static Future<bool> insertToCache(
      {required String key, required String value}) async {
    return await sharedPref.setString(key, value);
  }

  static Future<String?> getCacheData({required String key}) async {
    return sharedPref.getString(key);
  }

  static Future<bool> deleteCacheItem({required String key}) async {
    return await sharedPref.remove(key);
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPref.get(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPref.setString(key, value);
    if (value is bool) return await sharedPref.setBool(key, value);
    if (value is int) return await sharedPref.setInt(key, value);

    return await sharedPref.setDouble(key, value);
  }

  static Future<bool> removeData({
    required String key,
  }) {
    return sharedPref.remove(key);
  }
}
