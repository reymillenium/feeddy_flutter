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

class FoodRecipeShowScreen extends StatefulWidget {
  static const String screenId = 'food_recipe_show_screen';

  // Properties:
  final String appTitle;
  final FoodRecipe foodRecipe;
  final bool isFavorite;

  const FoodRecipeShowScreen({
    Key key,
    this.appTitle,
    this.foodRecipe,
    this.isFavorite,
  }) : super(key: key);

  @override
  _FoodRecipeShowScreenState createState() => _FoodRecipeShowScreenState();
}

class _FoodRecipeShowScreenState extends State<FoodRecipeShowScreen> with RouteAware, RouteObserverMixin {
  // State Properties:
  bool _showPortraitOnly = false;
  String _appTitle;
  FoodRecipe _foodRecipe;
  final String _screenId = FoodRecipeShowScreen.screenId;
  int _activeTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appTitle = widget.appTitle;
    _foodRecipe = widget.foodRecipe;
  }

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
  Widget build(BuildContext context) {
    FoodIngredientsData foodIngredientsData = Provider.of<FoodIngredientsData>(context, listen: true);
    Color primaryColor = Theme.of(context).primaryColor;

    return FutureBuilder(
        future: foodIngredientsData.byFoodRecipe(_foodRecipe),
        builder: (ctx, snapshot) {
          List<FoodIngredient> foodIngredients = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return foodIngredients.isEmpty
                  ? FeeddyScaffold(
                      activeIndex: _activeTab,
                      appTitle: _foodRecipe.title,
                      innerWidgets: [
                        FeeddyEmptyWidget(
                          packageImage: 1,
                          title: 'We are sorry',
                          subTitle: 'There is no ingredients',
                        ),
                      ],
                      objectsLength: 0,
                      objectName: 'ingredient',
                      iconFAB: FontAwesomeIcons.question,
                      onPressedFAB: () {},
                    )
                  : FeeddyScaffold(
                      activeIndex: _activeTab,
                      appTitle: _foodRecipe.title + ' df',
                      innerWidgets: [
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: [
                              // Recipe Details Header
                              FoodRecipeDetailsHeader(
                                foodRecipe: _foodRecipe,
                                isFavorite: widget.isFavorite,
                              ),

                              // Ingredients List Header Text:
                              SimpleListHeader(
                                listHeader: 'Ingredients',
                              ),

                              // Ingredients List:
                              PartialListContainer(
                                innerWidgetList: FoodIngredientsList(
                                  foodRecipe: _foodRecipe,
                                ),
                              ),

                              // Recipe Steps List Header Text:
                              SimpleListHeader(
                                listHeader: 'Recipe Steps',
                              ),

                              // Recipe Steps List:
                              PartialListContainer(
                                innerWidgetList: RecipeStepsList(
                                  foodRecipe: _foodRecipe,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      objectsLength: foodIngredients.length,
                      objectName: 'ingredient',
                      onPressedFAB: () => _showModalNewFoodRecipe(_foodRecipe.id, context),
                      isAdditionFAB: false,
                      iconFAB: Icons.delete,
                    );
            default:
              return FeeddyScaffold(
                activeIndex: _activeTab,
                appTitle: _foodRecipe.title,
                innerWidgets: [
                  FeeddyEmptyWidget(
                    packageImage: 1,
                    title: 'We are sorry',
                    subTitle: 'There is no ingredients',
                  ),
                ],
                objectsLength: 0,
                objectName: 'ingredient',
                // iconFAB: FontAwesomeIcons.question,
                onPressedFAB: () {},
              );
          }
        });
  }

  void _showModalNewFoodRecipe(dynamic foodRecipeId, BuildContext context) {
    SoundHelper().playSmallButtonClick();
    // print('Inside _showModalNewFoodRecipe');
    // showModalBottomSheet(
    //   backgroundColor: Colors.transparent,
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (context) => FoodCategoryNewScreen(),
    // );
    Navigator.of(context).pop(foodRecipeId);
  }
}

// Argument class to receive the arguments sent on the route settings arguments parameter:
class FoodRecipeShowScreenArguments {
  final FoodRecipe foodRecipe;

  FoodRecipeShowScreenArguments(
    this.foodRecipe,
  );
}
