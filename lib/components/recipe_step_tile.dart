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

class RecipeStepTile extends StatelessWidget {
  // Properties:
  final RecipeStep recipeStep;
  final int index;

  // Constructor:
  RecipeStepTile({
    Key key,
    this.recipeStep,
    this.index,
  }) : super(key: key);

  final DateFormat formatter = DateFormat().add_yMMMMd();
  final currencyFormat = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Map currentCurrency = appData.currentCurrency;

    RecipeStepsData recipeStepsData = Provider.of<RecipeStepsData>(context, listen: true);
    Function onDeleteRecipeStepHandler = (id, context) => recipeStepsData.deleteRecipeStepWithConfirm(id, context);
    Function onUpdateRecipeStepHandler = (id, description) => recipeStepsData.updateRecipeStep(id, description);

    final String formattedDate = formatter.format(recipeStep.createdAt);
    // final String amountLabel = '${currentCurrency['symbol']}${currencyFormat.format(transaction.amount)}';
    // final double amountFontSize = (84 / amountLabel.length);
    Color primaryColor = Theme.of(context).primaryColor;
    // Color accentColor = Theme.of(context).accentColor;
    // String measurementUnit = EnumToString.convertToString(foodIngredient.measurementUnit);

    return InkWell(
      onTap: () {
        // Navigator.of(context).pushNamed(RecipeStepShowScreen.screenId, arguments: {'recipeStep': recipeStep});
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
            // ListTile with data: title, duration and date
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                // visualDensity: VisualDensity.standard,
                leading: CircleAvatar(
                  backgroundColor: primaryColor,
                  radius: 16,
                  child: FittedBox(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        '${index + 1}',
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

                // Description:
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Tooltip(
                      child: Text(
                        recipeStep.description,
                        style: Theme.of(context).textTheme.bodyText1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                      ),
                      message: recipeStep.description,
                    ),
                  ],
                ),

                // Action icons:
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
                        onPressed: () => onDeleteRecipeStepHandler(recipeStep.id, context),
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
