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

class FoodRecipesList extends StatelessWidget {
  // Properties:
  final _listViewScrollController = ScrollController();
  final foodCategory;

  // Constructor:
  FoodRecipesList({
    Key key,
    this.foodCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FoodRecipesData foodRecipesData = Provider.of<FoodRecipesData>(context, listen: true);
    // List<FoodRecipe> foodRecipes = foodRecipesData.foodRecipes;
    List<FoodRecipe> foodRecipes = foodCategory.foodRecipes;
    // print(foodRecipes.first.id);

    return Container(
      child: foodRecipes.isEmpty
          ? FeeddyEmptyWidget(
              packageImage: 1,
              title: 'We are sorry',
              subTitle: 'There is no recipes',
            )
          : ListView.custom(
              padding: const EdgeInsets.only(left: 0, top: 0, right: 0),
              controller: _listViewScrollController,
              childrenDelegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return FoodRecipeTile(
                    key: ValueKey(foodRecipes[index].id),
                    id: foodRecipes[index].id,
                    index: index,
                    foodRecipe: foodRecipes[index],
                  );
                },
                childCount: foodRecipes.length,

                // This callback method is what allows to preserve the state:
                findChildIndexCallback: (Key key) => findChildIndexCallback(key, foodRecipes),
              ),
            ),
    );
  }

  // This callback method is what allows to preserve the state:
  int findChildIndexCallback(Key key, List<FoodRecipe> foodRecipes) {
    final ValueKey valueKey = key as ValueKey;
    final int id = valueKey.value;
    // final int id = int.parse(foodRecipeWidgetID.substring(0, 12));
    FoodRecipe foodRecipe;
    try {
      foodRecipe = foodRecipes.firstWhere((foodRecipe) => id == foodRecipe.id);
    } catch (e) {
      return null;
    }
    return foodRecipes.indexOf(foodRecipe);
  }
}
