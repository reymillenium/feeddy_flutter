// Packages:
import 'package:flutter/material.dart';

// Utilities:

class DropDownButtonCurrency extends StatelessWidget {
  final dynamic selectedValue;
  final Function onChanged;
  // final List<String> itemsList;
  final List<dynamic> itemsList;

  DropDownButtonCurrency({
    this.selectedValue,
    this.onChanged,
    this.itemsList,
  });

  @override
  Widget build(BuildContext context) {
    // List<DropdownMenuItem<String>> dropDownItems = itemsList.map<DropdownMenuItem<String>>((Map theme) {
    //   return DropdownMenuItem<String>(
    //     value: theme['theme'],
    //     child: Text(theme['name']),
    //   );
    // }).toList();
    List<DropdownMenuItem<dynamic>> dropDownItems = itemsList.asMap().entries.map<DropdownMenuItem<dynamic>>((entry) {
      int index = entry.key;
      String value = entry.value;

      return DropdownMenuItem<dynamic>(
        value: value,
        child: Text(value),
      );
    }).toList();

    return DropdownButton<dynamic>(
      value: selectedValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
        color: Colors.deepPurple,
      ),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (dynamic newValue) {
        onChanged(newValue);
      },
      items: dropDownItems,
    );
  }
}
