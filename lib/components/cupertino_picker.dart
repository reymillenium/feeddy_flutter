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
      // backgroundColor: Colors.red,
      looping: false,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        onSelectedItemChanged(selectedIndex);
      },
      selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
        // background: Colors.transparent,
        // background: CupertinoColors.tertiarySystemFill,
        capLeftEdge: false,
        capRightEdge: false,
      ),
      scrollController: FixedExtentScrollController(initialItem: initialIndex),
      children: cupertinoPickerChildren,
    );
  }
}
