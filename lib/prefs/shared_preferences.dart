import 'package:shared_preferences/shared_preferences.dart';

class UserPreferents {
  static final UserPreferents _instance = new UserPreferents.internal();

  factory UserPreferents() {
    return _instance;
  }

  UserPreferents.internal();
  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // Methods GET and SET
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  get userName {
    return _prefs.getString('userName') ?? '';
  }

   set userName(String value) {
    _prefs.setString('userName', value);
  }
}
