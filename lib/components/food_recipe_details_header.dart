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

class FoodRecipeDetailsHeader extends StatefulWidget {
  // Properties:
  final FoodRecipe foodRecipe;
  final bool isFavorite;

  // Constructor:
  FoodRecipeDetailsHeader({
    Key key,
    this.foodRecipe,
    this.isFavorite,
  }) : super(key: key);

  @override
  _FoodRecipeDetailsHeaderState createState() => _FoodRecipeDetailsHeaderState();
}

class _FoodRecipeDetailsHeaderState extends State<FoodRecipeDetailsHeader> {
  // State Properties:
  bool _isFavorite;

  // Runtime constants:
  final DateFormat formatter = DateFormat().add_yMMMMd();
  final currencyFormat = new NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void toggleLocallyFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Map currentCurrency = appData.currentCurrency;

    FoodRecipesData foodRecipesData = Provider.of<FoodRecipesData>(context, listen: true);
    // Function onDeleteFoodRecipeHandler = (id, context) => foodRecipesData.deleteFoodRecipeWithConfirm(id, context);
    // Function onUpdateFoodRecipeHandler = (id, title, imageUrl, duration, complexity, affordability, isGlutenFree, isLactoseFree, isVegan, isVegetarian) => foodRecipesData.updateFoodRecipe(id, title, imageUrl, duration, complexity, affordability, isGlutenFree, isLactoseFree, isVegan, isVegetarian);
    Function toggleFavorite = (userId, foodRecipeId) => foodRecipesData.toggleFavorite(userId, foodRecipeId);

    final String formattedDate = formatter.format(widget.foodRecipe.createdAt);
    // final String amountLabel = '${currentCurrency['symbol']}${currencyFormat.format(transaction.amount)}';
    // final double amountFontSize = (84 / amountLabel.length);
    Color primaryColor = Theme.of(context).primaryColor;
    // Color accentColor = Theme.of(context).accentColor;

    return Card(
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
                  widget.foodRecipe.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (widget.foodRecipe.hasDietQuirks) ...[
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
                        if (widget.foodRecipe.isGlutenFree) ...[
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
                        if (widget.foodRecipe.isLactoseFree) ...[
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
                        if (widget.foodRecipe.isVegan) ...[
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
                        if (widget.foodRecipe.isVegetarian) ...[
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
                      color: _isFavorite ? Colors.red : Colors.black,
                    ),
                    tooltip: 'Favorite',
                    // onPressed: () => toggleFavorite(1, widget.foodRecipe.id),
                    onPressed: () {
                      toggleLocallyFavorite();
                      toggleFavorite(1, widget.foodRecipe.id);
                    },
                  ),
                ),
              ],
            ],
          ),

          // Tile with data: Duration, etc
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.foodRecipe.title,
                    style: Theme.of(context).textTheme.headline6,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),

                  // Nested Row with duration, complexity & affordability:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Duration
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 18,
                            color: Colors.black54,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Text(
                              '${widget.foodRecipe.duration} min',
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Complexity
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
                              EnumToString.convertToString(widget.foodRecipe.complexity, camelCase: true),
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Affordability
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
                              EnumToString.convertToString(widget.foodRecipe.affordability, camelCase: true),
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
            ),
          ),
        ],
      ),
    );
  }
}
