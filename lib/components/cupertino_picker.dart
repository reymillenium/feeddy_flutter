// Packages:
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Utilities:

class CupertinoPickerCustom extends StatelessWidget {
  final Function onSelectedItemChanged;
  final int initialIndex;
  final List<dynamic> itemsList;

  CupertinoPickerCustom({
    this.onSelectedItemChanged,
    this.initialIndex,
    this.itemsList,
  });

  @override
  Widget build(BuildContext context) {
    // List<Text> cupertinoPickerChildren = itemsList.map<Text>((String value) {
    //   return Text(value);
    // }).toList();
    List<Text> cupertinoPickerChildren = itemsList.map((value) {
      return Text(value);
    }).toList();

    return CupertinoPicker(
      // useMagnifier: false,
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        onSelectedItemChanged(selectedIndex);
      },
      scrollController: FixedExtentScrollController(initialItem: initialIndex),
      children: cupertinoPickerChildren,
    );
  }
}
