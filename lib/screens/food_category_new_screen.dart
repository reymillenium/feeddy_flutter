// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';
// Screens:

// Models:
import 'package:feeddy_flutter/models/_models.dart';
// Components:

// Helpers:
import 'package:feeddy_flutter/helpers/_helpers.dart';
import 'package:flutter/cupertino.dart';
// Utilities:

class FoodCategoryNewScreen extends StatefulWidget {
  @override
  _FoodCategoryNewScreenState createState() => _FoodCategoryNewScreenState();
}

class _FoodCategoryNewScreenState extends State<FoodCategoryNewScreen> {
  // Local State Properties:
  String _title = '';
  Color _color = Colors.orangeAccent;

  void changeColor(Color color) => setState(() => _color = color);

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);

    FoodCategoriesData foodCategoriesData = Provider.of<FoodCategoriesData>(context, listen: true);
    Function onAddFoodCategoryHandler = (title, color) => foodCategoriesData.addFoodCategory(title, color);

    Color primaryColor = Theme.of(context).primaryColor;
    Color accentColor = Theme.of(context).accentColor;

    var foregroundColor = ColorHelper.contrastingColor(_color);

    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: foregroundColor,
      primary: _color,
      elevation: 3,
      textStyle: TextStyle(
        color: Colors.red,
      ),
      minimumSize: Size(double.infinity, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );

    final ButtonStyle elevatedButtonStyle = ButtonStyle(
      foregroundColor: MaterialStateProperty.all(foregroundColor),
      backgroundColor: MaterialStateProperty.all(_color),
      minimumSize: MaterialStateProperty.all(Size(double.infinity, 36)),
      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 16)),
      elevation: MaterialStateProperty.all(3),
      textStyle: MaterialStateProperty.all(TextStyle(
        color: Colors.red,
      )),
    );

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Container(
          // padding: const EdgeInsets.only(left: 20, top: 0, right: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: [
                Text(
                  'Add Food Category',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 30,
                  ),
                ),

                // Title Input
                TextField(
                  autofocus: true,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          // color: kLightBlueBackground,
                          // width: 30,
                          ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                        width: 4.0,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: accentColor,
                        // color: Colors.red,
                        width: 6.0,
                      ),
                    ),
                  ),
                  style: TextStyle(),
                  onChanged: (String newText) {
                    setState(() {
                      _title = newText;
                    });
                  },
                  onSubmitted: !_hasValidData() ? null : (_) => () => _submitData(context, onAddFoodCategoryHandler),
                ),

                // Color Input:
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ElevatedButton(
                    // elevation: 3.0,
                    style: raisedButtonStyle,
                    // style: elevatedButtonStyle,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            titlePadding: const EdgeInsets.all(0.0),
                            contentPadding: const EdgeInsets.all(0.0),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: _color,
                                onColorChanged: changeColor,
                                colorPickerWidth: 300.0,
                                pickerAreaHeightPercent: 0.7,
                                enableAlpha: true,
                                displayThumbColor: true,
                                showLabel: true,
                                paletteType: PaletteType.hsv,
                                pickerAreaBorderRadius: const BorderRadius.only(
                                  topLeft: const Radius.circular(2.0),
                                  topRight: const Radius.circular(2.0),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      'Color',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        // color: Colors.white,
                      ),
                    ),
                    // color: _color,
                    // textColor: useWhiteForeground(currentColor) ? const Color(0xffffffff) : const Color(0xff000000),
                  ),
                ),

                // Add button:
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: DeviceHelper.deviceIsIOS(context)
                      ? Container(
                          color: Colors.transparent,
                          height: 48.0,
                          width: double.infinity,
                          child: CupertinoButton(
                            color: primaryColor,
                            disabledColor: Colors.grey,
                            onPressed: !_hasValidData() ? null : () => _submitData(context, onAddFoodCategoryHandler),
                            child: Text(
                              'Add',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Material(
                          color: _hasValidData() ? primaryColor : Colors.grey,
                          // borderRadius: BorderRadius.circular(12.0),
                          elevation: 5,
                          child: MaterialButton(
                            disabledColor: Colors.grey,
                            onPressed: !_hasValidData() ? null : () => _submitData(context, onAddFoodCategoryHandler),
                            // minWidth: 300.0,
                            minWidth: double.infinity,
                            height: 42.0,
                            child: Text(
                              'Add',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _hasValidData() {
    bool result = false;
    if (_title.isNotEmpty) {
      result = true;
    }
    return result;
  }

  void _submitData(BuildContext context, Function onAddFoodCategory) {
    if (_title.isNotEmpty) {
      onAddFoodCategory(_title, _color);
    }
    Navigator.pop(context);
  }
}
