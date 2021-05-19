// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Screens:

// Models:
import 'package:feeddy_flutter/models/_models.dart';

// Components:

// Helpers:
import 'package:feeddy_flutter/helpers/_helpers.dart';

// Utilities:

class FoodCategoryEditScreen extends StatefulWidget {
  // Properties:
  final int id;
  // final int index;
  final String title;
  final Color color;
  final Function onUpdateFoodCategoryHandler;

  // Constructor:
  FoodCategoryEditScreen({
    this.id,
    // this.index,
    this.title,
    this.color,
    this.onUpdateFoodCategoryHandler,
  });

  @override
  _FoodCategoryEditScreenState createState() => _FoodCategoryEditScreenState();
}

class _FoodCategoryEditScreenState extends State<FoodCategoryEditScreen> {
  // State Properties:
  int _id;
  // int _index;
  String _title;
  Color _color;

  // Run time constants:
  DateTime now = DateTime.now();
  final _oneHundredYearsAgo = DateHelper.timeAgo(years: 100);
  final _oneHundredYearsFromNow = DateHelper.timeFromNow(years: 100);
  final NumberFormat _currencyFormat = new NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _id = widget.id;
    // _index = widget.index;
    _title = widget.title;
    _color = widget.color;
  }

  void changeColor(Color color) => setState(() => _color = color);

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Map currentCurrency = appData.currentCurrency;

    FoodCategoriesData foodCategoriesData = Provider.of<FoodCategoriesData>(context, listen: true);
    Function onUpdateFoodCategoriesHandler = (id, title, color) => foodCategoriesData.updateFoodCategory(id, title, color);

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
                  'Update Food Category',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 30,
                  ),
                ),

                // Title Input
                TextFormField(
                  initialValue: _title,
                  autofocus: true,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        // color: kLightBlueBackground,
                        color: Colors.red,
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
                  onFieldSubmitted: _hasValidData() ? (_) => () => _updateData(context, onUpdateFoodCategoriesHandler) : null,
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

                // Update button:
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: Material(
                    color: _hasValidData() ? primaryColor : Colors.grey,
                    // borderRadius: BorderRadius.circular(12.0),
                    elevation: 5.0,
                    child: MaterialButton(
                      disabledColor: Colors.grey,
                      onPressed: _hasValidData() ? () => _updateData(context, onUpdateFoodCategoriesHandler) : null,
                      // minWidth: 300.0,
                      minWidth: double.infinity,
                      height: 42.0,
                      child: Text(
                        'Update',
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

  void _updateData(BuildContext context, Function onUpdateFoodCategoriesHandler) {
    if (_title.isNotEmpty) {
      onUpdateFoodCategoriesHandler(_id, _title, _color);
    }
    Navigator.pop(context);
  }
}
