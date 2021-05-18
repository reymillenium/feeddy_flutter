// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Screens:
import 'package:feeddy_flutter/screens/new_food_category_screen.dart';

// Models:
import 'package:feeddy_flutter/models/_models.dart';

// Components:
import 'package:feeddy_flutter/components/_components.dart';

// Helpers:
import 'package:feeddy_flutter/helpers/_helpers.dart';

// Utilities:

class FoodCategoriesGrid extends StatelessWidget {
  const FoodCategoriesGrid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FoodCategoriesData foodCategoriesData = Provider.of<FoodCategoriesData>(context, listen: true);
    List<FoodCategory> foodCategories = foodCategoriesData.foodCategories;

    return foodCategories.isEmpty
        ? FeeddyEmptyWidget(
            packageImage: 1,
            title: 'We are sorry',
            subTitle: 'There is no categories',
          )
        : GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            padding: EdgeInsets.all(10),
            children: buildFoodCategoryPanels(foodCategories),
          );
  }

  List<FoodCategoryPanel> buildFoodCategoryPanels(List<FoodCategory> foodCategories) {
    return foodCategories
        .map((foodCategory) => FoodCategoryPanel(
              key: ValueKey(foodCategory.id),
              foodCategory: foodCategory,
            ))
        .toList();
  }
}
