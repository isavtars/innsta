import 'package:shared_preferences/shared_preferences.dart';

class DarkThemPerstinces {
  //thatis ke for value
  static const themmStatus = "THEMESTATUS";

  setDarkThemeP(bool value) async {
    SharedPreferences perfs = await SharedPreferences.getInstance();
    perfs.setBool(themmStatus, value);
  }

  Future<bool> getDarkThemP() async {
    SharedPreferences perfs = await SharedPreferences.getInstance();
    return perfs.getBool(themmStatus) ?? false;
  }
}
