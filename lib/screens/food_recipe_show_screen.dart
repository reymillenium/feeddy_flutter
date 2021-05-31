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

  const FoodRecipeShowScreen({
    Key key,
    this.appTitle,
    this.foodRecipe,
  }) : super(key: key);

  @override
  _FoodRecipeShowScreenState createState() => _FoodRecipeShowScreenState();
}

class _FoodRecipeShowScreenState extends State<FoodRecipeShowScreen> {
  // State Properties:
  bool _showPortraitOnly = false;
  String _appTitle;
  FoodRecipe _foodRecipe;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appTitle = widget.appTitle;
    _foodRecipe = widget.foodRecipe;
  }

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
                      onPressedAdd: () => _showModalNewFoodRecipe(context),
                    )
                  : FeeddyScaffold(
                      appTitle: _foodRecipe.title,
                      innerWidgets: [
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: [
                              // Recipe Details Header
                              FoodRecipeDetailsHeader(
                                foodRecipe: _foodRecipe,
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

                              // TODO: Still to implement
                              PartialListContainer(
                                innerWidgetList: FoodIngredientsList(
                                  foodRecipe: _foodRecipe,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      objectsLength: foodIngredients.length,
                      objectName: 'ingredient',
                      onPressedAdd: () => _showModalNewFoodRecipe(context),
                    );
            default:
              return FeeddyScaffold(
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
                onPressedAdd: () => _showModalNewFoodRecipe(context),
              );
          }
        });

    return FeeddyScaffold(
      appTitle: _foodRecipe.title,
      innerWidgets: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  _foodRecipe.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                // margin: EdgeInsets.symmetric(vertical: 1),
                child: Text(
                  'Ingredients',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: FoodIngredientsList(
            foodRecipe: _foodRecipe,
          ),
        ),
      ],
      onPressedAdd: () => _showModalNewFoodRecipe(context),
      objectsLength: 0,
      objectName: 'thing',
    );
  }

  void _showModalNewFoodRecipe(BuildContext context) {
    SoundHelper().playSmallButtonClick();
    // showModalBottomSheet(
    //   backgroundColor: Colors.transparent,
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (context) => FoodCategoryNewScreen(),
    // );
  }
}

// Argument class to receive the arguments sent on the route settings arguments parameter:
class FoodRecipeShowScreenArguments {
  final FoodRecipe foodRecipe;

  FoodRecipeShowScreenArguments(
    this.foodRecipe,
  );
}
