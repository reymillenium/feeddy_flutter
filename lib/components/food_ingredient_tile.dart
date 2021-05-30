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

class FoodIngredientTile extends StatelessWidget {
  // Properties:
  final FoodIngredient foodIngredient;
  final int id;
  final int index;

  // Constructor:
  FoodIngredientTile({
    Key key,
    this.foodIngredient,
    this.id,
    this.index,
  }) : super(key: key);

  // Runtime constants:
  final DateFormat formatter = DateFormat().add_yMMMMd();
  final currencyFormat = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Map currentCurrency = appData.currentCurrency;

    FoodIngredientsData foodIngredientsData = Provider.of<FoodIngredientsData>(context, listen: true);
    Function onDeleteFoodIngredientHandler = (id, context) => foodIngredientsData.deleteFoodIngredientWithConfirm(id, context);
    Function onUpdateFoodIngredientHandler = (id, name, amount, measurementUnit, foodRecipeId) => foodIngredientsData.updateFoodIngredient(id, name, amount, measurementUnit, foodRecipeId);

    final String formattedDate = formatter.format(foodIngredient.createdAt);
    // final String amountLabel = '${currentCurrency['symbol']}${currencyFormat.format(transaction.amount)}';
    // final double amountFontSize = (84 / amountLabel.length);
    Color primaryColor = Theme.of(context).primaryColor;
    // Color accentColor = Theme.of(context).accentColor;
    String measurementUnit = EnumToString.convertToString(foodIngredient.measurementUnit);

    return InkWell(
      onTap: () {
        // Navigator.of(context).pushNamed(FoodRecipeShowScreen.screenId, arguments: {'foodRecipe': foodIngredient});
      },
      child: Card(
        // shadowColor: Colors.purpleAccent,
        elevation: 2,
        color: Colors.white70,
        // margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          // side: BorderSide(color: Colors.red, width: 1),
          // borderRadius: BorderRadius.circular(10),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // FoodRecipe Image
            // Stack(
            //   children: [
            //     ClipRRect(
            //       borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(10),
            //         topRight: Radius.circular(10),
            //       ),
            //       child: Image.network(
            //         foodIngredient.imageUrl,
            //         height: 250,
            //         width: double.infinity,
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //     if (foodIngredient.hasDietQuirks) ...[
            //       Positioned(
            //         bottom: 20,
            //         right: 10,
            //         child: Container(
            //           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            //           decoration: BoxDecoration(
            //             color: Colors.black45,
            //             borderRadius: BorderRadius.all(Radius.circular(10)),
            //           ),
            //           child: Row(
            //             children: [
            //               if (foodIngredient.isGlutenFree) ...[
            //                 Tooltip(
            //                   child: Icon(
            //                     AppIcons.gluten_free,
            //                     color: Colors.white,
            //                   ),
            //                   message: 'Gluten free',
            //                 ),
            //               ],
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               if (foodIngredient.isLactoseFree) ...[
            //                 Tooltip(
            //                   child: Icon(
            //                     AppIcons.lactose_free,
            //                     color: Colors.white,
            //                   ),
            //                   message: 'Lactose free',
            //                 ),
            //               ],
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               if (foodIngredient.isVegan) ...[
            //                 Tooltip(
            //                   child: Icon(
            //                     AppIcons.vegan,
            //                     color: Colors.white,
            //                   ),
            //                   message: 'Vegan',
            //                 ),
            //               ],
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               if (foodIngredient.isVegetarian) ...[
            //                 Tooltip(
            //                   child: Icon(
            //                     AppIcons.vegetarian,
            //                     color: Colors.white,
            //                   ),
            //                   message: 'Vegetarian',
            //                 ),
            //               ],
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ],
            // ),

            // Tile with data: Duration, etc
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                // visualDensity: VisualDensity.standard,
                leading: CircleAvatar(
                  backgroundColor: primaryColor,
                  radius: 32,
                  child: FittedBox(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        '${foodIngredient.amount} $measurementUnit',
                        style: TextStyle(
                          color: ColorHelper.contrastingColor(primaryColor),
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),

                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      foodIngredient.name,
                      style: Theme.of(context).textTheme.headline6,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),

                    // Row with complexity & affordability:
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Row(
                    //       children: [
                    //         Icon(
                    //           Icons.work,
                    //           size: 18,
                    //           color: Colors.black54,
                    //         ),
                    //         Padding(
                    //           padding: const EdgeInsets.only(left: 6),
                    //           child: Text(
                    //             EnumToString.convertToString(foodIngredient.complexity, camelCase: true),
                    //             style: TextStyle(
                    //               color: Colors.black54,
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     Row(
                    //       children: [
                    //         Icon(
                    //           FontAwesomeIcons.dollarSign,
                    //           // Icons.attach_money,
                    //           size: 18,
                    //           color: Colors.black54,
                    //         ),
                    //         Padding(
                    //           padding: const EdgeInsets.only(left: 2),
                    //           child: Text(
                    //             EnumToString.convertToString(foodIngredient.affordability, camelCase: true),
                    //             style: TextStyle(
                    //               color: Colors.black54,
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
                subtitle: Text(formattedDate),
                // subtitle: Text('testing'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Tooltip(
                      message: 'Delete',
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                        onPressed: () => onDeleteFoodIngredientHandler(foodIngredient.id, context),
                      ),
                    ),
                    Tooltip(
                      message: 'Edit',
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // showModalBottomSheet(
                          //   backgroundColor: Colors.transparent,
                          //   isScrollControlled: true,
                          //   context: context,
                          //   builder: (context) => FoodRecipeEditScreen(
                          //     foodIngredient: foodIngredient,
                          //     onUpdateFoodRecipeHandler: onUpdateFoodIngredientHandler,
                          //   ),
                          // );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
