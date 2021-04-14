import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  String text;
  Function callback;
  bool fullWidth;
  bool primary;

  ButtonWidget({
    @required this.text, 
    @required this.callback, 
    this.fullWidth = false,
    this.primary = true,
  });

  @override
  Widget build(BuildContext context) {
    if (fullWidth == true) {
      return Container(
        width: MediaQuery.of(context).size.width, 
        child: _createButton(context)
      );
    }
    return _createButton(context);
  }

  Widget _createButton(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        primary: primary ? primaryColor : Colors.white,
        onPrimary: Colors.black,
        shadowColor: primaryColor,
      ),
      onPressed: this.callback,
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
