// Packages:
import 'package:feeddy_flutter/helpers/_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Components:
import 'package:feeddy_flutter/components/drop_down_button_currency.dart';
import 'package:feeddy_flutter/components/cupertino_picker.dart';

// Utilities:

class MultiPlatformSelectBox extends StatelessWidget {
  final Function onSelectedItemChangedIOS;
  final int cupertinoInitialIndex;
  final dynamic selectedValueAndroid;
  final Function onChangedAndroid;
  final List<dynamic> itemsList;

  MultiPlatformSelectBox({
    this.onSelectedItemChangedIOS,
    this.cupertinoInitialIndex,
    this.selectedValueAndroid,
    this.onChangedAndroid,
    this.itemsList,
  });

  @override
  Widget build(BuildContext context) {
    bool isIOS = DeviceHelper.deviceIsIOS(context);

    if (isIOS) {
      return CupertinoPickerCustom(
        onSelectedItemChanged: (selectedIndex) {
          onSelectedItemChangedIOS(selectedIndex);
        },
        initialIndex: cupertinoInitialIndex,
        itemsList: itemsList,
      );
    } else {
      return DropDownButtonCurrency(
        selectedValue: selectedValueAndroid,
        onChanged: (dynamic newValue) {
          onChangedAndroid(newValue);
        },
        itemsList: itemsList,
      );
    }
  }
}
