// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Screens:
import 'package:feeddy_flutter/screens/edit_food_category_screen.dart';

// Models:
import 'package:feeddy_flutter/models/_models.dart';

// Components:
import 'package:feeddy_flutter/components/_components.dart';

// Helpers:
import 'package:feeddy_flutter/helpers/_helpers.dart';

// Utilities:

class FoodCategoryPanel extends StatelessWidget {
  // Properties:
  final FoodCategory foodCategory;

  FoodCategoryPanel({
    Key key,
    this.foodCategory,
  }) : super(key: key);

  // Runtime constants:
  final DateFormat formatter = DateFormat().add_yMMMMd();
  final currencyFormat = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Map currentCurrency = appData.currentCurrency;

    FoodCategoriesData foodCategoriesData = Provider.of<FoodCategoriesData>(context, listen: true);
    Function onDeleteFoodCategoryHandler = (id, context) => foodCategoriesData.deleteFoodCategoryWithConfirm(id, context);

    final String formattedDate = formatter.format(foodCategory.createdAt);
    // final String amountLabel = '${currentCurrency['symbol']}${currencyFormat.format(transaction.amount)}';
    // final double amountFontSize = (84 / amountLabel.length);
    var foregroundColor = ColorHelper.contrastingColor(foodCategory.color);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            foodCategory.color.withOpacity(0.7),
            foodCategory.color.withOpacity(1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                // SizedBox(
                //   height: 20,
                // ),
                // FoodCategory Title:
                Expanded(
                  flex: 3,
                  child: Container(
                    // color: Colors.green,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        foodCategory.title,
                        // style: TextStyle(
                        //   color: foregroundColor,
                        // ),
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: foregroundColor,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Actions Icons:
          Container(
            // alignment: Alignment.topRight,
            // color: Colors.lightBlue,
            // width: double.infinity,
            // padding: const EdgeInsets.all(0),
            child: Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Tooltip(
                    message: 'Delete',
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: foregroundColor,
                        size: 20,
                      ),
                      onPressed: () => onDeleteFoodCategoryHandler(foodCategory.id, context),
                    ),
                  ),
                  Tooltip(
                    message: 'Edit',
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: foregroundColor,
                        size: 20,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => EditFoodCategoryScreen(
                            id: foodCategory.id,
                            title: foodCategory.title,
                            color: foodCategory.color,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
