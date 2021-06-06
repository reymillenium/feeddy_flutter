// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Screens:
import 'package:feeddy_flutter/screens/_screens.dart';

// Models:
import 'package:feeddy_flutter/models/_models.dart';

// Components:
import 'package:feeddy_flutter/components/_components.dart';

// Helpers:
import 'package:feeddy_flutter/helpers/_helpers.dart';

// Utilities:
import 'package:feeddy_flutter/utilities/_utilities.dart';

class FoodCategoryShowScreen extends StatefulWidget {
  static const String screenId = 'food_category_show_screen';

  // Properties:
  final FoodCategory foodCategory;

  const FoodCategoryShowScreen({
    Key key,
    this.foodCategory,
  }) : super(key: key);

  @override
  _FoodCategoryShowScreenState createState() => _FoodCategoryShowScreenState();
}

class _FoodCategoryShowScreenState extends State<FoodCategoryShowScreen> with RouteAware, RouteObserverMixin {
  // State Properties:
  FoodCategory _foodCategory;
  final String _screenId = FoodCategoryShowScreen.screenId;
  int _activeTab = 0;
  List<String> availableFilters = ["isGlutenFree", "isLactoseFree", "isVegan", "isVegetarian"];
  List<String> selectedFilters = [];

  /// Called when the top route has been popped off, and the current route
  /// shows up.
  @override
  void didPopNext() {
    print('didPopNext => Emerges: $_screenId');
    setState(() {
      _activeTab = 0;
    });
  }

  /// Called when the current route has been pushed.
  @override
  void didPush() {
    print('didPush => Arriving to: $_screenId');
    setState(() {
      _activeTab = 0;
    });
  }

  /// Called when the current route has been popped off.
  @override
  void didPop() {
    print('didPop => Popping of: $_screenId');
  }

  /// Called when a new route has been pushed, and the current route is no
  /// longer visible.
  @override
  void didPushNext() {
    print('didPushNext => Covering: $_screenId');
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   print("Back To old Screen");
  //   super.dispose();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _foodCategory = widget.foodCategory;
  }

  void _openFilterDialog(BuildContext context) async {
    await FilterListDialog.display<String>(
      context,
      listData: availableFilters,
      selectedListData: selectedFilters,
      height: 300,
      headlineText: "Show me the Food Recipes:",
      searchFieldHintText: "Search Here",
      choiceChipLabel: (item) {
        return item.toCamelCase.readable;
      },
      validateSelectedItem: (list, val) {
        return list.contains(val);
      },
      onItemSearch: (list, text) {
        if (list.any((element) => element.toLowerCase().contains(text.toLowerCase().removeWhiteSpaces))) {
          return list.where((element) => element.toLowerCase().contains(text.toLowerCase().removeWhiteSpaces)).toList();
        } else {
          return [];
        }
      },
      onApplyButtonClick: (list) {
        if (list != null) {
          setState(() {
            selectedFilters = List.from(list);
          });
        }
        Navigator.pop(context);
      },
      useRootNavigator: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    FoodRecipesData foodRecipesData = Provider.of<FoodRecipesData>(context, listen: true);
    FavoriteFoodRecipesData favoriteFoodRecipesData = Provider.of<FavoriteFoodRecipesData>(context, listen: true);

    return FutureBuilder(
        // future: foodRecipesData.byFoodCategory(_foodCategory, filtersList: selectedFilters),
        future: Future.wait([foodRecipesData.byFoodCategory(_foodCategory, filtersList: selectedFilters), favoriteFoodRecipesData.byUserId(1)]),
        builder: (ctx, AsyncSnapshot<List<dynamic>> snapshot) {
          List<FoodRecipe> foodRecipes;
          List<FavoriteFoodRecipe> favoriteFoodRecipes;
          if (snapshot.data != null) {
            foodRecipes = snapshot.data[0] ?? [];
            favoriteFoodRecipes = snapshot.data[1] ?? [];
          }

          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return foodRecipes.isEmpty
                  ? FeeddyScaffold(
                      activeIndex: _activeTab,
                      appTitle: _foodCategory.title,
                      innerWidgets: [
                        FeeddyEmptyWidget(
                          packageImage: 1,
                          title: 'We are sorry',
                          subTitle: 'There is no recipes',
                        ),
                      ],
                      objectsLength: 0,
                      objectName: 'recipe',
                      appBarActionIcon: Icons.filter_alt_outlined,
                      iconFAB: FontAwesomeIcons.question,
                      onPressedBarActionIcon: () => _openFilterDialog(context),
                      onPressedFAB: () => _showModalNewFoodRecipe(context),
                    )
                  : FeeddyScaffold(
                      activeIndex: _activeTab,
                      appTitle: _foodCategory.title,
                      innerWidgets: [
                        Expanded(
                          flex: 5,
                          child: FoodRecipesList(
                            foodCategory: _foodCategory,
                            selectedFilters: selectedFilters,
                            foodRecipes: foodRecipes,
                            favoriteFoodRecipes: favoriteFoodRecipes,
                          ),
                        ),
                      ],
                      objectsLength: foodRecipes.length,
                      objectName: 'recipe',
                      appBarActionIcon: Icons.filter_alt_outlined,
                      onPressedBarActionIcon: () => _openFilterDialog(context),
                      onPressedFAB: () => _showModalNewFoodRecipe(context),
                    );
            default:
              return FeeddyScaffold(
                activeIndex: _activeTab,
                appTitle: _foodCategory.title,
                innerWidgets: [
                  FeeddyEmptyWidget(
                    packageImage: 1,
                    title: 'We are sorry',
                    subTitle: 'There is no recipes',
                  ),
                ],
                objectsLength: 0,
                objectName: 'recipe',
                appBarActionIcon: Icons.filter_alt_outlined,
                iconFAB: FontAwesomeIcons.question,
                onPressedBarActionIcon: () => _openFilterDialog(context),
                onPressedFAB: () => _showModalNewFoodRecipe(context),
              );
          }
        });
  }

  void _showModalNewFoodRecipe(BuildContext context) {
    SoundHelper().playSmallButtonClick();
    // showModalBottomSheet(
    //   backgroundColor: Colors.transparent,
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (context) => FoodRecipeNewScreen(),
    // );
  }
}

// Argument class to receive the arguments sent on the route settings arguments parameter:
class FoodCategoryShowScreenArguments {
  final FoodCategory foodCategory;

  FoodCategoryShowScreenArguments(
    this.foodCategory,
  );
}
