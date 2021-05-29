// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';
// Screens:

// Models:
import 'package:feeddy_flutter/models/_models.dart';

// Components:
import 'package:feeddy_flutter/components/_components.dart';

// Helpers:
import 'package:feeddy_flutter/helpers/_helpers.dart';
// Utilities:

class FoodRecipeEditScreen extends StatefulWidget {
  static const String screenId = 'food_recipe_edit_screen';

  // Properties:
  final FoodRecipe foodRecipe;
  final Function onUpdateFoodRecipeHandler;

  // Constructor:
  FoodRecipeEditScreen({
    this.foodRecipe,
    this.onUpdateFoodRecipeHandler,
  });

  @override
  _FoodRecipeEditScreenState createState() => _FoodRecipeEditScreenState();
}

class _FoodRecipeEditScreenState extends State<FoodRecipeEditScreen> {
  // State Properties:
  FoodRecipe _foodRecipe;
  String _title;

  // List<FoodCategory> _foodCategories;
  String _imageUrl;

  // List<FoodIngredient> _foodIngredients;
  // List<RecipeStep> _recipeSteps;
  int _duration;
  Complexity _complexity;
  Affordability _affordability;
  bool _isGlutenFree;
  bool _isLactoseFree;
  bool _isVegan;
  bool _isVegetarian;

  // Run time constants:
  DateTime now = DateTime.now();
  final _oneHundredYearsAgo = DateHelper.timeAgo(years: 100);
  final _oneHundredYearsFromNow = DateHelper.timeFromNow(years: 100);
  final NumberFormat _currencyFormat = new NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _foodRecipe = widget.foodRecipe;
    _title = widget.foodRecipe.title;
    // _foodCategories = widget.foodRecipe.foodCategories;
    _imageUrl = widget.foodRecipe.imageUrl;
    // _foodIngredients = widget.foodRecipe.foodIngredients;
    // _recipeSteps = widget.foodRecipe.recipeSteps;
    _duration = widget.foodRecipe.duration;
    _complexity = widget.foodRecipe.complexity;
    _affordability = widget.foodRecipe.affordability;
    _isGlutenFree = widget.foodRecipe.isGlutenFree;
    _isLactoseFree = widget.foodRecipe.isLactoseFree;
    _isVegan = widget.foodRecipe.isVegan;
    _isVegetarian = widget.foodRecipe.isVegetarian;
  }

  void changeTitle(String title) => setState(() => _title = title);

  void changeDuration(int duration) => setState(() => _duration = duration);

  void changeComplexity(String complexity) => setState(() => _complexity = EnumToString.fromString(Complexity.values, complexity));

  void changeAffordability(String affordability) => setState(() => _affordability = EnumToString.fromString(Affordability.values, affordability));

  void changeIsGlutenFree(bool value) => setState(() => _isGlutenFree = value);

  void changeIsLactoseFree(bool value) => setState(() => _isLactoseFree = value);

  void changeIsVegan(bool value) => setState(() => _isVegan = value);

  void changeIsVegetarian(bool value) => setState(() => _isVegetarian = value);

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Map currentCurrency = appData.currentCurrency;

    FoodRecipesData foodRecipesData = Provider.of<FoodRecipesData>(context, listen: true);
    // Function onUpdateFoodRecipesHandler = (id, title, imageUrl, duration, complexity, affordability, isGlutenFree, isLactoseFree, isVegan, isVegetarian) => foodRecipesData.updateFoodRecipe(id, title, imageUrl, duration, complexity, affordability, isGlutenFree, isLactoseFree, isVegan, isVegetarian);

    Color primaryColor = Theme.of(context).primaryColor;
    Color accentColor = Theme.of(context).accentColor;

    // var foregroundColor = ColorHelper.contrastingColor(_color);
    // final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    //   onPrimary: foregroundColor,
    //   primary: Colors.white,
    //   elevation: 3,
    //   textStyle: TextStyle(
    //     color: Colors.red,
    //   ),
    //   minimumSize: Size(double.infinity, 36),
    //   padding: EdgeInsets.symmetric(horizontal: 16),
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(2)),
    //   ),
    // );

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
                  onFieldSubmitted: _hasValidData() ? (_) => () => _updateData(context, widget.onUpdateFoodRecipeHandler) : null,
                ),

                // Duration Input
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    initialValue: _duration.toString(),
                    autofocus: true,
                    autocorrect: false,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Duration',
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
                    onChanged: (String newValue) {
                      setState(() {
                        _duration = newValue.isNotEmpty ? int.parse(newValue) : 0;
                      });
                    },
                    onFieldSubmitted: _hasValidData() ? (_) => () => _updateData(context, widget.onUpdateFoodRecipeHandler) : null,
                  ),
                ),

                // SelectBox for the complexity:
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: MultiPlatformSelectBox(
                    onSelectedItemChangedIOS: (selectedIndex) async {
                      setState(() {
                        changeComplexity(EnumToString.toList(Complexity.values)[selectedIndex]);
                      });
                    },
                    cupertinoInitialIndex: EnumToString.toList(Complexity.values).indexOf(EnumToString.convertToString(_complexity)),
                    selectedValueAndroid: EnumToString.convertToString(_complexity),
                    onChangedAndroid: (dynamic newValue) async {
                      setState(() {
                        changeComplexity(newValue);
                      });
                    },
                    itemsList: EnumToString.toList(Complexity.values),
                  ),
                ),

                // SelectBox for the affordability:
                MultiPlatformSelectBox(
                  onSelectedItemChangedIOS: (selectedIndex) async {
                    setState(() {
                      changeAffordability(EnumToString.toList(Affordability.values)[selectedIndex]);
                    });
                  },
                  cupertinoInitialIndex: EnumToString.toList(Affordability.values).indexOf(EnumToString.convertToString(_affordability)),
                  selectedValueAndroid: EnumToString.convertToString(_affordability),
                  onChangedAndroid: (dynamic newValue) async {
                    setState(() {
                      changeAffordability(newValue);
                    });
                  },
                  itemsList: EnumToString.toList(Affordability.values),
                ),

                // Switchers: _isGlutenFree & _isLactoseFree
                Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ExpensyDrawerSwitch(
                      switchLabel: 'Gluten free',
                      activeColor: accentColor,
                      switchValue: _isGlutenFree,
                      possibleValues: {
                        'activeText': 'Yes',
                        'inactiveText': 'No',
                      },
                      onToggle: changeIsGlutenFree,
                    ),
                    ExpensyDrawerSwitch(
                      switchLabel: 'Lactose free',
                      activeColor: accentColor,
                      switchValue: _isLactoseFree,
                      possibleValues: {
                        'activeText': 'Yes',
                        'inactiveText': 'No',
                      },
                      onToggle: changeIsLactoseFree,
                    ),
                  ],
                ),

                // Switchers: _isVegan & _isVegetarian
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ExpensyDrawerSwitch(
                      switchLabel: 'Vegan',
                      activeColor: accentColor,
                      switchValue: _isVegan,
                      possibleValues: {
                        'activeText': 'Yes',
                        'inactiveText': 'No',
                      },
                      onToggle: changeIsVegan,
                    ),

                    // Switchers: _isLactoseFree
                    ExpensyDrawerSwitch(
                      switchLabel: 'Vegetarian',
                      activeColor: accentColor,
                      switchValue: _isVegetarian,
                      possibleValues: {
                        'activeText': 'Yes',
                        'inactiveText': 'No',
                      },
                      onToggle: changeIsVegetarian,
                    ),
                  ],
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
                      onPressed: _hasValidData() ? () => _updateData(context, widget.onUpdateFoodRecipeHandler) : null,
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

  void _updateData(BuildContext context, Function onUpdateFoodRecipeHandler) {
    if (_title.isNotEmpty && _imageUrl.isNotEmpty && !_duration.isNegative) {
      onUpdateFoodRecipeHandler(_foodRecipe.id, _title, _imageUrl, _duration, _complexity, _affordability, _isGlutenFree, _isLactoseFree, _isVegan, _isVegetarian);
    }
    Navigator.pop(context);
  }
}
