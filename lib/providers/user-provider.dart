import 'dart:convert';

import 'package:delivery/constants/enviroment.dart' as constants;
import 'package:delivery/prefs/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final _prefs = new UserPreferents();

  Future<Map<String, dynamic>> createUser(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(constants.FIREBASE_AUTH,
        'v1/accounts:signUp?key=${constants.PUBLIC_API_KEY}');
    final res = await http.post(url, body: jsonEncode(authData));

    Map<String, dynamic> data = json.decode(res.body);

    if (data.containsKey('idToken')) {
      return {'ok': true, 'token': data['idToken'], 'userId': data['localId']};
    }
    return {'ok': false, 'message': data['error']['message']};
  }

  Future<dynamic> registerUserData(Map user, Map payload) async {
    final userId = user['userId'];
    final token = user['token'];

    final url = Uri.https(constants.FIRESTORE_URL, '/users/$userId', {'auth': token});
    final res = await http.post(url);
    final data = json.decode(res.body);
    return data;
  }
}
