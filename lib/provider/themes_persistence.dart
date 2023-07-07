import 'package:shared_preferences/shared_preferences.dart';

class DarkThemPersistence {
  //that is ke for value
  static const themeStatus = "THEMESTATUS";

  setDarkTheme(bool value) async {
    SharedPreferences perfs = await SharedPreferences.getInstance();
    perfs.setBool(themeStatus, value);
  }

  Future<bool> getDarkTheme() async {
    SharedPreferences perfs = await SharedPreferences.getInstance();
    return perfs.getBool(themeStatus) ?? false;
  }
}
