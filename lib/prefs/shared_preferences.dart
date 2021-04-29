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
    final dateString = _prefs.getString('expirationToken');
    if (dateString != null && dateString != '') {
      final expirationToken = DateTime.parse(dateString);
      final today = new DateTime.now();
      if (expirationToken.isBefore(today)) {
        _prefs.setString('token', '');
        _prefs.setString('expirationToken', '');
        _prefs.setString('userId', '');
        _prefs.setString('userName', '');
        _prefs.setString('userRoll', '');
      }
    }
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  get expirationToken {
    return _prefs.getString('expirationToken') ?? '';
  }

  set expirationToken(String value) {
    _prefs.setString('expirationToken', value);
  }

  get userId {
    return _prefs.getString('userId') ?? '';
  }

  set userId(String value) {
    _prefs.setString('userId', value);
  }

  get userName {
    return _prefs.getString('userName') ?? '';
  }

  set userName(String value) {
    _prefs.setString('userName', value);
  }
  
  get userRoll {
    return _prefs.getString('userRoll') ?? '';
  }

  set userRoll(String value) {
    _prefs.setString('userRoll', value);
  }
}
