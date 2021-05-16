// Packages:
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Utilities:

class CupertinoPickerCustom extends StatelessWidget {
  final Function onSelectedItemChanged;
  final List<Map> itemsList;

  CupertinoPickerCustom({
    this.onSelectedItemChanged,
    this.itemsList,
  });

  @override
  Widget build(BuildContext context) {
    // List<Text> cupertinoPickerChildren = itemsList.map<Text>((String value) {
    //   return Text(value);
    // }).toList();
    List<Text> cupertinoPickerChildren = itemsList.map((theme) {
      return Text(theme['name']);
    }).toList();

    return CupertinoPicker(
      // useMagnifier: false,
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        onSelectedItemChanged(selectedIndex);
      },
      children: cupertinoPickerChildren,
    );
  }
}
