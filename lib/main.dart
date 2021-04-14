import 'package:delivery/pages/home-page.dart';
import 'package:delivery/pages/login-page.dart';
import 'package:delivery/pages/welcome-page.dart';
import 'package:delivery/prefs/shared_preferences.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await new UserPreferents().initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final prefs = new UserPreferents();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Delivery',
        debugShowCheckedModeBanner: false,
        initialRoute: prefs.token != '' ? 'home' : 'welcome',
        routes: {
          'home': (BuildContext _) => HomePage(),
          'login': (BuildContext _) => LoginPage(),
          'welcome': (BuildContext _) => WelcomePage(),
        },
        theme: ThemeData(
          primaryColor: Color(0xFFE8D639)
        ),
    );
  }
}
