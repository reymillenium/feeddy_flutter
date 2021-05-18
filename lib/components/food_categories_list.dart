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

class FoodCategoriesList extends StatelessWidget {
  // Properties:
  final _listViewScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    FoodCategoriesData foodCategoriesData = Provider.of<FoodCategoriesData>(context, listen: true);
    List<FoodCategory> foodCategories = foodCategoriesData.foodCategories;

    return Container(
      child: foodCategories.isEmpty
          ? FeeddyEmptyWidget(
              packageImage: 1,
              title: 'We are sorry',
              subTitle: 'There is no categories',
            )
          : ListView.custom(
              padding: const EdgeInsets.only(left: 0, top: 0, right: 0),
              controller: _listViewScrollController,
              childrenDelegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
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
