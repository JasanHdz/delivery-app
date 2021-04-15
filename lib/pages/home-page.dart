import 'package:delivery/widgets/common/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home PAGE')),
      endDrawer: DrawerWidget(),
      body: Container(
        child: Text('Hello world'),
      ),
    );
  }
}