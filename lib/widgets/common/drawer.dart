import 'dart:ui';
import 'package:delivery/prefs/shared_preferences.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final _prefs = new UserPreferents();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: DrawerHeader(
              child: Text(_prefs.userName),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          ListTile(
            title: Text('Item one'),
            onTap: () => Navigator.pop(context),
          ),
          Expanded(
            child: Container(),
          ),
          ListTile(
            hoverColor: Colors.grey[700],
            leading: Icon(Icons.logout, color: Colors.black),
            title: Text('Cerrar sesión', style: TextStyle(fontSize: 18.0)),
            onTap: () => _logoutSession(context),
          )
        ],
      ),
    );
  }

  static Widget burgerButton() {
    return SafeArea(child: Builder(builder: (context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: IconButton(
            hoverColor: Colors.red,
            icon: Icon(Icons.menu, size: 30.0),
            alignment: Alignment.topRight,
            onPressed: () {
              print('hola mundo');
              Scaffold.of(context).openEndDrawer();
            }),
      );
    }));
  }

  void _logoutSession(BuildContext context) {
    _prefs.token = '';
    _prefs.expirationToken = '';
    _prefs.userId = '';
    _prefs.userName = '';
    _prefs.userRoll = '';
    Navigator.pushNamedAndRemoveUntil(context, 'welcome', (route) => false);
  }
}
