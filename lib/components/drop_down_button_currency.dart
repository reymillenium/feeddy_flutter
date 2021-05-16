// Packages:
import 'package:flutter/material.dart';

// Utilities:

class DropDownButtonCurrency extends StatelessWidget {
  final int selectedCurrencyValue;
  final Function onChanged;
  // final List<String> itemsList;
  final List<Map> itemsList;

  DropDownButtonCurrency({
    this.selectedCurrencyValue,
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
    List<DropdownMenuItem<int>> dropDownItems = itemsList.asMap().entries.map<DropdownMenuItem<int>>((entry) {
      int index = entry.key;
      Map value = entry.value;

      return DropdownMenuItem<int>(
        value: index,
        child: Text(value['name']),
      );
    }).toList();

    return DropdownButton<int>(
      value: selectedCurrencyValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
          // color: Colors.deepPurple,
          ),
      underline: Container(
        height: 2,
        // color: Colors.deepPurpleAccent,
      ),
      onChanged: (int newValue) {
        onChanged(newValue);
      },
      items: dropDownItems,
    );
  }
}
