import 'package:delivery/pages/home-page.dart';
import 'package:delivery/pages/login-page.dart';
import 'package:delivery/pages/registry-page.dart';
import 'package:delivery/pages/welcome-page.dart';
import 'package:delivery/prefs/shared_preferences.dart';
import 'package:flutter/material.dart';

void main() async {
  final navigatorKey = GlobalKey<NavigatorState>();
  WidgetsFlutterBinding.ensureInitialized();
  await new UserPreferents().initPrefs();
  runApp(MyApp(navigatorKey: navigatorKey));
}

class MyApp extends StatelessWidget {
  MyApp({@required this.navigatorKey});
  final GlobalKey navigatorKey;
  final prefs = new UserPreferents();
  @override
  Widget build(BuildContext context) {
    print(prefs.token);
    print(prefs.expirationToken);
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Delivery',
      debugShowCheckedModeBanner: false,
      initialRoute: prefs.token != '' ? 'home' : 'welcome',
      routes: {
        'home': (BuildContext _) => HomePage(),
        'login': (BuildContext _) => LoginPage(),
        'registry': (BuildContext _) => RegistryPage(),
        'welcome': (BuildContext _) => WelcomePage(),
      },
      theme: ThemeData(
        primaryColor: Color(0xFFE8D639)
      ),
    );
  }
}
