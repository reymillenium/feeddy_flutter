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

class FoodIngredientsList extends StatelessWidget {
  // Properties:
  final _listViewScrollController = ScrollController();
  final foodRecipe;

  // Constructor:
  FoodIngredientsList({
    Key key,
    this.foodRecipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FoodIngredientsData foodIngredientsData = Provider.of<FoodIngredientsData>(context, listen: true);

    return FutureBuilder<List<FoodIngredient>>(
      future: foodIngredientsData.byFoodRecipe(foodRecipe),
      builder: (ctx, snapshot) {
        List<FoodIngredient> foodIngredients = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return foodIngredients.isEmpty
                ? FeeddyEmptyWidget(
                    packageImage: 1,
                    title: 'We are sorry',
                    subTitle: 'There is no ingredients',
                  )
                : ListView.custom(
                    padding: const EdgeInsets.only(left: 0, top: 0, right: 0),
                    controller: _listViewScrollController,
                    childrenDelegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return FoodIngredientTile(
                          key: ValueKey(foodIngredients[index].id),
                          id: foodIngredients[index].id,
                          index: index,
                          foodIngredient: foodIngredients[index],
                        );
                      },
                      childCount: foodIngredients.length,
                      // This callback method is what allows to preserve the state:
                      findChildIndexCallback: (Key key) => findChildIndexCallback(key, foodIngredients),
                    ),
                  );
          default:
            return Container(
              child: FeeddyEmptyWidget(
                packageImage: 1,
                title: 'We are sorry',
                subTitle: 'There is no ingredients',
              ),
            );
        }
      },
    );
  }

  // This callback method is what allows to preserve the state:
  int findChildIndexCallback(Key key, List<FoodIngredient> foodIngredients) {
    final ValueKey valueKey = key as ValueKey;
    final int id = valueKey.value;
    // final int id = int.parse(foodRecipeWidgetID.substring(0, 12));
    FoodIngredient foodIngredient;
    try {
      foodIngredient = foodIngredients.firstWhere((foodIngredient) => id == foodIngredient.id);
    } catch (e) {
      return null;
    }
    return foodIngredients.indexOf(foodIngredient);
  }
}
