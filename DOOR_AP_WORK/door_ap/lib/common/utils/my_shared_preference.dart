import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {
  static SharedPreferences? _sharedPreferences;
  static MySharedPreference? _mySharedPreference;


  ///*
  ///
  ///
  static Future<MySharedPreference?> getInstance() async {
    _mySharedPreference ??=
        MySharedPreference(); // ?? (_mySharedPreference == null){_mySharedPreference = MySharedPreference()}

    _sharedPreferences ??= await SharedPreferences.getInstance();

    return _mySharedPreference;
  }

  ///*
  ///
  static logout() {
    if (_sharedPreferences != null) {
      _sharedPreferences!.clear();
    }
  }

  ///*
  ///
  static setString(String key, String? value) {
    _sharedPreferences!.setString(key, value!);
  }

  ///*
  ///
  static getString(String key) {
    return _sharedPreferences!.getString(key);
  }

  ///*
  ///
  static setBool(String key, bool value) {
    _sharedPreferences!.setBool(key, value);
  }

  ///*
  ///
  static getBool(String key) {
    return _sharedPreferences!.getBool(key) ?? false;
  }

  ///*
  ///
  static setInt(String key, int? value) {
    _sharedPreferences!.setInt(key, value!);
  }

  ///*
  ///
  static getInt(String key) {
    return _sharedPreferences!.getInt(key);
  }


}