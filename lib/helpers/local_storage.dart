import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static setBool(String key, value) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getBool(key);
  }

  static setString(String key, value) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString(key, value);
  }

  static setMap(String key, Map value) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString(key, json.encode(value));
  }

  static setList(String key, List value) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString(key, json.encode(value));
  }

  static Future<String?> getString(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString(key);
  }

  static Future<bool?> removeElement(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.remove(key);
  }

  static setInt(String key, int value) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getInt(key) ?? 0;
  }

  static Future<Map?> getMap(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final localData = storage.getString(key);
    if (localData == null) {
      return null;
    }
    Map data = jsonDecode(localData.toString());
    return data;
  }

  static Future<List?> getList(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final localData = storage.getString(key);
    print('local list data --------------------------');
    print(localData);
    if (localData == null) {
      return null;
    }
    List data = jsonDecode(localData.toString());
    print('local list data --------------------------');
    return data;
  }

  static dynamic clear() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return await storage.clear();
  }
}
