import 'package:delivery/providers/ui-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationBottomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      elevation: 0.0,
      onTap: (int i) => uiProvider.selectedMenuOpt = i,
      items: [
        _createItem(Icons.directions, 'Direcciones'),
        _createItem(Icons.map, 'Mapa'),
      ],
    );
  }

  BottomNavigationBarItem _createItem(IconData icon, String title) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: title
    );
  }
}
