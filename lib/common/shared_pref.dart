import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const _isUserLoggedIn = "is_user_logged_in_the_app";

  static setHasUserLoggedIn(bool loggedInValue) async {
    SharedPreferences instance = await SharedPreferences.getInstance();

    await instance.setBool(_isUserLoggedIn, loggedInValue);
  }

  static Future<bool> getHasUserLoggedIn() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    final isLoggedIn = instance.getBool(_isUserLoggedIn) ?? false;
    return isLoggedIn;
  }

  static clearAllData() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.clear();
  }
}
