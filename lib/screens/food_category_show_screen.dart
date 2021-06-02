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

class _FoodCategoryShowScreenState extends State<FoodCategoryShowScreen> {
  // State Properties:
  FoodCategory _foodCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _foodCategory = widget.foodCategory;
  }

  @override
  Widget build(BuildContext context) {
    FoodRecipesData foodRecipesData = Provider.of<FoodRecipesData>(context, listen: true);

    return FutureBuilder(
        future: foodRecipesData.byFoodCategory(_foodCategory),
        builder: (ctx, snapshot) {
          List<FoodRecipe> foodRecipes = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return foodRecipes.isEmpty
                  ? FeeddyScaffold(
                      activeIndex: 0,
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
                      onPressedAdd: () => _showModalNewFoodRecipe(context),
                    )
                  : FeeddyScaffold(
                      activeIndex: 0,
                      appTitle: _foodCategory.title,
                      innerWidgets: [
                        Expanded(
                          flex: 5,
                          child: FoodRecipesList(
                            foodCategory: _foodCategory,
                          ),
                        ),
                      ],
                      objectsLength: foodRecipes.length,
                      objectName: 'recipe',
                      onPressedAdd: () => _showModalNewFoodRecipe(context),
                    );
            default:
              return FeeddyScaffold(
                activeIndex: 0,
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
                onPressedAdd: () => _showModalNewFoodRecipe(context),
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
