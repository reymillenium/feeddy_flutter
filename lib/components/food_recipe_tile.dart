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

class FoodRecipeTile extends StatelessWidget {
  // Properties:
  final FoodRecipe foodRecipe;
  final int id;
  final int index;
  final bool isFavorite;

  // Constructor:
  FoodRecipeTile({
    Key key,
    this.foodRecipe,
    this.id,
    this.index,
    this.isFavorite,
  }) : super(key: key);

  // Runtime constants:
  final DateFormat formatter = DateFormat().add_yMMMMd();
  final currencyFormat = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Map currentCurrency = appData.currentCurrency;

    FoodRecipesData foodRecipesData = Provider.of<FoodRecipesData>(context, listen: true);
    Function onDeleteFoodRecipeHandler = (id, context) => foodRecipesData.deleteFoodRecipeWithConfirm(id, context);
    Function onUpdateFoodRecipeHandler = (id, title, imageUrl, duration, complexity, affordability, isGlutenFree, isLactoseFree, isVegan, isVegetarian) => foodRecipesData.updateFoodRecipe(id, title, imageUrl, duration, complexity, affordability, isGlutenFree, isLactoseFree, isVegan, isVegetarian);
    Function toggleFavorite = (userId, foodRecipeId) => foodRecipesData.toggleFavorite(userId, foodRecipeId);

    final String formattedDate = formatter.format(foodRecipe.createdAt);
    // final String amountLabel = '${currentCurrency['symbol']}${currencyFormat.format(transaction.amount)}';
    // final double amountFontSize = (84 / amountLabel.length);
    Color primaryColor = Theme.of(context).primaryColor;
    // Color accentColor = Theme.of(context).accentColor;

    return InkWell(
      onTap: () async {
        // Navigator.of(context).pushNamed(FoodRecipeShowScreen.screenId, arguments: {'foodRecipe': foodRecipe});
        var foodRecipeId = await Navigator.of(context).pushNamed(FoodRecipeShowScreen.screenId, arguments: {'foodRecipe': foodRecipe, 'isFavorite': isFavorite});
        if (foodRecipeId != null) {
          onDeleteFoodRecipeHandler(foodRecipeId, context);
        }
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
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    foodRecipe.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (foodRecipe.hasDietQuirks) ...[
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          if (foodRecipe.isGlutenFree) ...[
                            Tooltip(
                              child: Icon(
                                AppIcons.gluten_free,
                                color: Colors.white,
                              ),
                              message: 'Gluten free',
                            ),
                          ],
                          SizedBox(
                            width: 10,
                          ),
                          if (foodRecipe.isLactoseFree) ...[
                            Tooltip(
                              child: Icon(
                                AppIcons.lactose_free,
                                color: Colors.white,
                              ),
                              message: 'Lactose free',
                            ),
                          ],
                          SizedBox(
                            width: 10,
                          ),
                          if (foodRecipe.isVegan) ...[
                            Tooltip(
                              child: Icon(
                                AppIcons.vegan,
                                color: Colors.white,
                              ),
                              message: 'Vegan',
                            ),
                          ],
                          SizedBox(
                            width: 10,
                          ),
                          if (foodRecipe.isVegetarian) ...[
                            Tooltip(
                              child: Icon(
                                AppIcons.vegetarian,
                                color: Colors.white,
                              ),
                              message: 'Vegetarian',
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
                ...[
                  Positioned(
                    top: 20,
                    right: 10,
                    child: IconButton(
                      iconSize: 32,
                      icon: Icon(
                        Icons.star,
                        color: isFavorite ? Colors.red : Colors.black,
                      ),
                      tooltip: 'Favorite',
                      onPressed: () => toggleFavorite(1, foodRecipe.id),
                    ),
                  ),
                ],
              ],
            ),

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
                        '${foodRecipe.duration} min',
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
                      foodRecipe.title,
                      style: Theme.of(context).textTheme.headline6,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),

                    // Row with complexity & affordability:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.work,
                              size: 18,
                              color: Colors.black54,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(
                                EnumToString.convertToString(foodRecipe.complexity, camelCase: true),
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.dollarSign,
                              // Icons.attach_money,
                              size: 18,
                              color: Colors.black54,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Text(
                                EnumToString.convertToString(foodRecipe.affordability, camelCase: true),
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                        onPressed: () => onDeleteFoodRecipeHandler(foodRecipe.id, context),
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
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => FoodRecipeEditScreen(
                              foodRecipe: foodRecipe,
                              onUpdateFoodRecipeHandler: onUpdateFoodRecipeHandler,
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
      ),
    );
  }
}
