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
  final List<String> selectedFilters;
  final List<FoodRecipe> foodRecipes;
  final List<FavoriteFoodRecipe> favoriteFoodRecipes;

  // Constructor:
  FoodRecipesList({
    Key key,
    this.foodCategory,
    this.selectedFilters,
    this.foodRecipes,
    this.favoriteFoodRecipes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FoodRecipesData foodRecipesData = Provider.of<FoodRecipesData>(context, listen: true);

    // return FutureBuilder<List<FoodRecipe>>(
    //   future: foodRecipesData.byFoodCategory(foodCategory, filtersList: selectedFilters),
    //   builder: (ctx, snapshot) {
    //     List<FoodRecipe> foodRecipes = snapshot.data;
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.done:
    //         return foodRecipes.isEmpty
    //             ? FeeddyEmptyWidget(
    //                 packageImage: 1,
    //                 title: 'We are sorry',
    //                 subTitle: 'There is no recipes',
    //               )
    //             : ListView.custom(
    //                 padding: const EdgeInsets.only(left: 0, top: 0, right: 0),
    //                 controller: _listViewScrollController,
    //                 childrenDelegate: SliverChildBuilderDelegate(
    //                   (BuildContext context, int index) {
    //                     return FoodRecipeTile(
    //                       key: ValueKey(foodRecipes[index].id),
    //                       id: foodRecipes[index].id,
    //                       index: index,
    //                       foodRecipe: foodRecipes[index],
    //                     );
    //                   },
    //                   childCount: foodRecipes.length,
    //                   // This callback method is what allows to preserve the state:
    //                   findChildIndexCallback: (Key key) => findChildIndexCallback(key, foodRecipes),
    //                 ),
    //               );
    //       default:
    //         return Container(
    //           child: FeeddyEmptyWidget(
    //             packageImage: 1,
    //             title: 'We are sorry',
    //             subTitle: 'There is no recipes',
    //           ),
    //         );
    //     }
    //   },
    // );

    return foodRecipes.isEmpty
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
                var tempFavoriteFoodRecipes = favoriteFoodRecipes ?? [];
                List<int> foodRecipeIdsList = tempFavoriteFoodRecipes.map((favoriteFoodRecipe) => favoriteFoodRecipe.foodRecipeId).toList();
                bool isFavorite = foodRecipeIdsList.contains(foodRecipes[index].id);
                return FoodRecipeTile(
                  key: ValueKey(foodRecipes[index].id),
                  id: foodRecipes[index].id,
                  index: index,
                  foodRecipe: foodRecipes[index],
                  isFavorite: isFavorite,
                );
              },
              childCount: foodRecipes.length,
              // This callback method is what allows to preserve the state:
              findChildIndexCallback: (Key key) => findChildIndexCallback(key, foodRecipes),
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
