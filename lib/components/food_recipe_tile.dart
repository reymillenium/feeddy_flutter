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

  // Constructor:
  FoodRecipeTile({
    Key key,
    this.foodRecipe,
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

    FoodRecipesData foodRecipesData = Provider.of<FoodRecipesData>(context, listen: true);
    Function onDeleteFoodRecipeHandler = (id, context) => foodRecipesData.deleteFoodRecipeWithConfirm(id, context);
    Function onUpdateFoodRecipeHandler = (id, title, imageUrl, duration, complexity, affordability, isGlutenFree, isLactoseFree, isVegan, isVegetarian) => foodRecipesData.updateFoodRecipe(id, title, imageUrl, duration, complexity, affordability, isGlutenFree, isLactoseFree, isVegan, isVegetarian);

    final String formattedDate = formatter.format(foodRecipe.createdAt);
    // final String amountLabel = '${currentCurrency['symbol']}${currencyFormat.format(transaction.amount)}';
    // final double amountFontSize = (84 / amountLabel.length);

    return InkWell(
      onTap: () {
        print('InkWell onTap');
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

            // Tile with data: Duration, etc
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                // visualDensity: VisualDensity.standard,
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 32,
                  child: FittedBox(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        '${foodRecipe.duration}',
                        style: TextStyle(
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
                    Text(
                      formattedDate,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                subtitle: Text('test'),
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
