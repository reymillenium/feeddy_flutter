// Packages:
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Components:
import 'package:feeddy_flutter/components/drop_down_button_currency.dart';
import 'package:feeddy_flutter/components/cupertino_picker.dart';

// Utilities:

class MultiPlatformSelectBox extends StatelessWidget {
  final Function onSelectedItemChangedIOS;
  final int selectedValueAndroid;
  final Function onChangedAndroid;
  final List<dynamic> itemsList;

  MultiPlatformSelectBox({
    this.onSelectedItemChangedIOS,
    this.selectedValueAndroid,
    this.onChangedAndroid,
    this.itemsList,
  });

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    if (isIOS) {
      return CupertinoPickerCustom(
        onSelectedItemChanged: (selectedIndex) {
          onSelectedItemChangedIOS(selectedIndex);
        },
        itemsList: itemsList,
      );
    } else {
      return DropDownButtonCurrency(
        selectedCurrencyValue: selectedValueAndroid,
        onChanged: (int newValue) {
          onChangedAndroid(newValue);
        },
        itemsList: itemsList,
      );
    }
  }
}
