import 'dart:convert';

import 'package:delivery/constants/enviroment.dart' as constants;
import 'package:delivery/prefs/shared_preferences.dart';
import 'package:delivery/utils/util.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final _prefs = new UserPreferents();

  void setSession(String token, int expiresIn, String userId) {
    final date = new DateTime.now();
    final expirationToken = new DateTime(
            date.year, date.month, date.day, date.hour, date.minute, expiresIn)
        .toString();
    _prefs.expirationToken = expirationToken;
    _prefs.token = 'Bearer $token';
    _prefs.userId = userId;
  }

  Map<String, dynamic> _getAuthData(String email, String password) {
    return {'email': email, 'password': password, 'returnSecureToken': true};
  }

  Future<Map<String, dynamic>> createUser(String email, String password) async {
    final authData = _getAuthData(email, password);

    final url = Uri.https(constants.FIREBASE_AUTH, 'v1/accounts:signUp',
        {'key': constants.PUBLIC_API_KEY});
    final res = await http.post(url, body: jsonEncode(authData));

    Map<String, dynamic> data = json.decode(res.body);

    if (data.containsKey('idToken')) {
      setSession(
          data['idToken'], int.parse(data['expiresIn']), data['localId']);
      return {'ok': true, 'token': data['idToken'], 'userId': data['localId']};
    }
    return {'ok': false, 'message': data['error']['message']};
  }

  Future<Map<String, dynamic>> registerUserData(
      Map<String, dynamic> user, Map payload) async {
    final userId = user['userId'];
    final token = user['token'];

    final url = Uri.https(
      constants.FIRESTORE_HOST,
      '${constants.FIRESTORE_PATH}/users/$userId',
    );
    final res = await http.patch(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(payload));

    Map<String, dynamic> data = json.decode(res.body);

    return data;
  }

  Future<Map<String, dynamic>> loginWithEmailAndPassword(
      String email, String password) async {
    final authData = _getAuthData(email, password);

    try {
      Uri url = Uri.https(constants.FIREBASE_AUTH,
          'v1/accounts:signInWithPassword', {'key': constants.PUBLIC_API_KEY});

      http.Response res = await http.post(url, body: jsonEncode(authData));
      Map<String, dynamic> data = json.decode(res.body);

      if (data.containsKey('idToken')) {
        setSession(
            data['idToken'], int.parse(data['expiresIn']), data['localId']);
        return {
          'ok': true,
          'token': data['idToken'],
          'userId': data['localId']
        };
      }

      return {'ok': false, 'error': data['error']['message']};
    } catch (error) {
      return {'ok': false, 'error': error['error']['message']};
    }
  }

  Future<Map<String, dynamic>> getCurrentUser(token, userId) async {
    try {
      final url = Uri.https(
        constants.FIRESTORE_HOST,
        '${constants.FIRESTORE_PATH}/users/$userId',
      );
      final http.Response res = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });
      Map<String, dynamic> rawData = await json.decode(res.body);
      Map<String, dynamic> data = transforFieldToValues(rawData);
      _prefs.userName = "${data['name']} ${data['lastName']}";
      _prefs.userRoll = data['user'];
      return data;
    } catch (error) {
      print(error);
      return {'ok': false};
    }
  }
}
