import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery/widgets/common/drawer.dart';
import 'package:delivery/widgets/common/wrapper.dart';
import 'package:delivery/providers/ui-provider.dart';

class DecoratorWidget extends StatelessWidget {
  final Widget title;
  DecoratorWidget(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title),
      endDrawer: DrawerWidget(),
      body: WrapperWidget(
        child: _DecoratorBody(),
      ),
    );
  }
}

class _DecoratorBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    switch (currentIndex) {
      case 0:
        return Center(child: Text('Home Page'));
      default:
        return Center(child: Text('Not found page'));
    }
  }
}
