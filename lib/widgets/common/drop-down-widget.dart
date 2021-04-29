import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final List<String> items;
  final Function onChanged;
  
  DropDownWidget({@required this.items, @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      value: items[0],
      items: items.map((element) {
        return DropdownMenuItem(
            child: Text(
              element,
              style: TextStyle(fontSize: 13.5),
            ),
            value: element);
      }).toList());
  }
}
