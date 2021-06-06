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

class FavoritesScreen extends StatefulWidget {
  static const String screenId = 'favorites_screen';

  const FavoritesScreen({Key key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with RouteAware, RouteObserverMixin {
  final String _screenId = FavoritesScreen.screenId;
  int _activeTab = 1;
  List<String> availableFilters = ["isGlutenFree", "isLactoseFree", "isVegan", "isVegetarian"];
  List<String> selectedFilters = [];

  /// Called when the top route has been popped off, and the current route
  /// shows up.
  @override
  void didPopNext() {
    print('didPopNext => Emerges: $_screenId');
    setState(() {
      _activeTab = 1;
    });
  }

  /// Called when the current route has been pushed.
  @override
  void didPush() {
    print('didPush => Arriving to: $_screenId');
    setState(() {
      _activeTab = 1;
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
        // future: foodRecipesData.thoseFavoritesByUserId(1, filtersList: selectedFilters),
        future: Future.wait([foodRecipesData.thoseFavoritesByUserId(1, filtersList: selectedFilters), favoriteFoodRecipesData.byUserId(1)]),
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
                      appTitle: 'Favorite Recipes',
                      innerWidgets: [
                        FeeddyEmptyWidget(
                          packageImage: 1,
                          title: 'We are sorry',
                          subTitle: 'There is no favorite recipes',
                        ),
                      ],
                      objectsLength: 0,
                      objectName: 'recipe',
                      appBarActionIcon: Icons.filter_alt_outlined,
                      iconFAB: FontAwesomeIcons.question,
                      onPressedBarActionIcon: () => _openFilterDialog(context),
                      onPressedFAB: () => _showModalNewFavorite(context),
                    )
                  : FeeddyScaffold(
                      activeIndex: _activeTab,
                      appTitle: 'Favorite Recipes',
                      innerWidgets: [
                        Expanded(
                          flex: 5,
                          child: FoodRecipesList(
                            // foodCategory: _foodCategory,
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
                      onPressedFAB: () => _showModalNewFavorite(context),
                    );
            default:
              return FeeddyScaffold(
                activeIndex: _activeTab,
                appTitle: 'Favorite Recipes',
                innerWidgets: [
                  FeeddyEmptyWidget(
                    packageImage: 1,
                    title: 'We are sorry',
                    subTitle: 'There is no favorite recipes',
                  ),
                ],
                objectsLength: 0,
                objectName: 'recipe',
                appBarActionIcon: Icons.filter_alt_outlined,
                iconFAB: FontAwesomeIcons.question,
                onPressedBarActionIcon: () => _openFilterDialog(context),
                onPressedFAB: () => _showModalNewFavorite(context),
              );
          }
        });
  }

  void _showModalNewFavorite(BuildContext context) {
    SoundHelper().playSmallButtonClick();
    // showModalBottomSheet(
    //   backgroundColor: Colors.transparent,
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (context) => FoodRecipeNewScreen(),
    // );
  }
}
