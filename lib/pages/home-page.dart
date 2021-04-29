import 'package:delivery/pages/map-page.dart';
import 'package:delivery/prefs/shared_preferences.dart';
import 'package:delivery/providers/ui-provider.dart';
import 'package:delivery/providers/user-provider.dart';
import 'package:delivery/widgets/common/drawer.dart';
import 'package:delivery/widgets/common/navigation-bottom.dart';
// import 'package:delivery/widgets/common/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userProvider = new UserProvider();
  final _prefs = new UserPreferents();

  @override
  void initState() {
    super.initState();
    if(_prefs.userName == '') {
      userProvider.getCurrentUser(_prefs.token, _prefs.userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_prefs.userName);
    return Scaffold(
      appBar: AppBar(title: Text('Delivery')),
      endDrawer: DrawerWidget(),
      bottomNavigationBar: NavigationBottomWidget(),
      body: _AppBody(),
    );
  }
}

class _AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    switch (currentIndex) {
      case 0:
        return Center(child: Text('Home Page'));
      default:
        return MapPage();
    }
  }
}
