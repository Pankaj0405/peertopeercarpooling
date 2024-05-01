import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
  MySharedPreferences._privateConstructor();

  Future<void>  setStringValue(String key, String value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    await myPrefs.setString(key, value);
  }

  Future<void>  setIntValue(String key, int value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    await myPrefs.setInt(key, value);
  }

  Future<void>  setBoolValue(String key, bool value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
  await  myPrefs.setBool(key, value);
  }

  Future<String> getStringValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString(key) ?? "";
  }

  Future<String> getIntValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    int? intValue = myPrefs.getInt(key);
    return intValue?.toString() ?? "";
  }


  Future<bool> containsKey(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.containsKey(key);
  }

  Future<void> removeValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    await myPrefs.remove(key);
  }

  Future<void>  removeAll() async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    await myPrefs.clear();
  }

}