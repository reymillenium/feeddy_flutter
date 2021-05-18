// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';
import 'package:feeddy_flutter/components/food_category_tile.dart';

// Screens:

// Models:
import 'package:feeddy_flutter/models/_models.dart';

// Components:
import 'package:feeddy_flutter/components/_components.dart';

// Helpers:

// Utilities:

class FoodCategoriesList extends StatelessWidget {
  // Properties:
  final _listViewScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    FoodCategoriesData foodCategoriesData = Provider.of<FoodCategoriesData>(context, listen: true);
    List<FoodCategory> foodCategories = foodCategoriesData.foodCategories;
    // print('build foodCategories.first.id = ${foodCategories.first.id}');
    // print('build foodCategories.first.title = ${foodCategories.first.title}');
    // print('build foodCategories.first.color = ${foodCategories.first.color}');
    // print('build foodCategories.first.createdAt = ${foodCategories.first.createdAt}');
    // print('build foodCategories.first.updatedAt = ${foodCategories.first.updatedAt}');

    return Container(
      child: foodCategories.isEmpty
          ? FeeddyEmptyWidget(
              packageImage: 1,
              title: 'We are sorry',
              subTitle: 'There is no categories',
            )

          // Not preserving the local state after an item removal:
          // : ListView.builder(
          //     padding: const EdgeInsets.only(left: 0, top: 0, right: 0),
          //     controller: _listViewScrollController,
          //     itemBuilder: (context, index) {
          //       return TransactionTile(
          //         key: ValueKey(transactions[index].id),
          //         id: transactions[index].id,
          //         index: index,
          //         transaction: transactions[index],
          //       );
          //     },
          //     itemCount: transactions.length,
          //   ),
          //   ),

          // Preserving the local state:
          : ListView.custom(
              padding: const EdgeInsets.only(left: 0, top: 0, right: 0),
              controller: _listViewScrollController,
              childrenDelegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  // print('ListView.custom foodCategories[index].id = ${foodCategories[index].id}');
                  // print('ListView.custom foodCategories[index].title = ${foodCategories[index].title}');
                  return FoodCategoryTile(
                    key: ValueKey(foodCategories[index].id),
                    id: foodCategories[index].id,
                    index: index,
                    foodCategory: foodCategories[index],
                  );
                },
                childCount: foodCategories.length,

                // This callback method is what allows to preserve the state:
                findChildIndexCallback: (Key key) => findChildIndexCallback(key, foodCategories),
              ),
            ),
    );
  }

  // This callback method is what allows to preserve the state:
  int findChildIndexCallback(Key key, List<FoodCategory> foodCategories) {
    final ValueKey valueKey = key as ValueKey;
    final int id = valueKey.value;
    // final int id = int.parse(foodCategoryWidgetID.substring(0, 12));
    FoodCategory foodCategory;
    try {
      foodCategory = foodCategories.firstWhere((foodCategory) => id == foodCategory.id);
    } catch (e) {
      return null;
    }
    return foodCategories.indexOf(foodCategory);
  }
}
