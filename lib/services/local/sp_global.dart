import 'package:shared_preferences/shared_preferences.dart';

class SPGlobal {
  static final SPGlobal _instance = SPGlobal._();
  SPGlobal._();

  factory SPGlobal() {
    return _instance;
  }

  late SharedPreferences prefs;

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  set fullName(String value) {
    prefs.setString("fullName", value);
  }

  String get fullName => prefs.getString("fullName") ?? "";

  set email(String value) {
    prefs.setString("email", value);
  }

  String get email => prefs.getString("email") ?? "";

  set typeLogin(String value) {
    prefs.setString("typeLogin", value);
  }

  String get typeLogin => prefs.getString("typeLogin") ?? "";

  set isLogin(bool value) {
    prefs.setBool("isLogin", value);
  }

  bool get isLogin => prefs.getBool("isLogin") ?? false;
}
