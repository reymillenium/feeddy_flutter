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
import 'package:feeddy_flutter/screens/food_category_show_screen.dart';
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

  void selectCategory(BuildContext context) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => FoodCategoryShowScreen(
    //       appTitle: 'Feeddy',
    //       foodCategory: foodCategory,
    //     ),
    //   ),
    // );

    //  Named route:
    // Navigator.pushNamed(context, FoodCategoryShowScreen.screenId, arguments: FoodCategoryShowScreenArguments(foodCategory));
    // It can even use a Map instead:
    Navigator.pushNamed(context, FoodCategoryShowScreen.screenId, arguments: {'foodCategory': foodCategory});
  }

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
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                // SizedBox(
                //   height: 24,
                // ),

                // Actions Icons:
                Container(
                  height: 30,
                  // alignment: Alignment.topRight,
                  // color: Colors.grey,
                  // width: double.infinity,
                  // padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Colors.red[500],
                    // ),
                    // color: TinyColor(foodCategory.color).lighten(20).color,
                    color: TinyColor(foodCategory.color).darken(6).color,
                    // color: Colors.blueGrey,
                    // color: Colors.transparent,
                    // border: Border(
                    //   bottom: BorderSide(
                    //     width: 16.0,
                    //     color: Colors.lightBlue.shade900,
                    //   ),
                    // ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      // bottomLeft: Radius.circular(20),
                      // bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.blueGrey,
                      color: Colors.transparent,
                      border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: Colors.black45,
                        ),
                      ),
                    ),
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
                                  builder: (context) => FoodCategoryEditScreen(
                                    id: foodCategory.id,
                                    title: foodCategory.title,
                                    color: foodCategory.color,
                                  ),
                                );
                              },
                            ),
                          ),

                          // Another way:
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 2),
                          //   child: Tooltip(
                          //     message: 'Delete',
                          //     child: GestureDetector(
                          //       onTap: () => onDeleteFoodCategoryHandler(foodCategory.id, context),
                          //       child: Icon(Icons.delete),
                          //     ),
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 2, right: 4),
                          //   child: Tooltip(
                          //       message: 'Edit',
                          //       child: GestureDetector(
                          //         onTap: () {
                          //           showModalBottomSheet(
                          //             backgroundColor: Colors.transparent,
                          //             isScrollControlled: true,
                          //             context: context,
                          //             builder: (context) => FoodCategoryEditScreen(
                          //               id: foodCategory.id,
                          //               title: foodCategory.title,
                          //               color: foodCategory.color,
                          //             ),
                          //           );
                          //         },
                          //         child: Icon(Icons.edit),
                          //       )),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),

                // FoodCategory Title:
                Expanded(
                  flex: 3,
                  child: InkWell(
                    splashColor: Theme.of(context).primaryColor,
                    onTap: () => selectCategory(context),
                    borderRadius: BorderRadius.only(
                      // topLeft: Radius.circular(8),
                      // topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      color: Colors.transparent,
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.center,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
