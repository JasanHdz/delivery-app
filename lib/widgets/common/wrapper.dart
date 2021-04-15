import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class WrapperWidget extends StatelessWidget {
  WrapperWidget({ @required this.child });
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        // color: Colors.red,
        width: MediaQuery.of(context).size.width * 0.92,
        height: MediaQuery.of(context).size.height * 0.92,        
        child: child,
      ),
    );
  }
}