import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final bool obscureText;
  final Function onChanged;
  final String label;
  final TextInputType type;

  TextFieldWidget({
    @required this.onChanged, 
    this.obscureText = false, 
    this.type = TextInputType.text,
    this.label, 
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration:
          InputDecoration(border: OutlineInputBorder(), labelText: label),
      onChanged: onChanged,
      keyboardType: type,
    );
  }
}
