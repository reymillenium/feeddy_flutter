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

class FoodRecipeShowScreen extends StatefulWidget {
  static const String screenId = 'food_recipe_show_screen';

  // Properties:
  final String appTitle;
  final FoodRecipe foodRecipe;

  const FoodRecipeShowScreen({
    Key key,
    this.appTitle,
    this.foodRecipe,
  }) : super(key: key);

  @override
  _FoodRecipeShowScreenState createState() => _FoodRecipeShowScreenState();
}

class _FoodRecipeShowScreenState extends State<FoodRecipeShowScreen> {
  // State Properties:
  bool _showPortraitOnly = false;
  String _appTitle;
  FoodRecipe _foodRecipe;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appTitle = widget.appTitle;
    _foodRecipe = widget.foodRecipe;
  }

  @override
  Widget build(BuildContext context) {
    FoodRecipesData foodRecipesData = Provider.of<FoodRecipesData>(context, listen: true);

    return FeeddyScaffold(
      appTitle: _foodRecipe.title,
      innerWidgets: [],
      showModal: () => _showModalNewFoodRecipe(context),
      objectsLength: 0,
      objectName: 'thing',
    );
  }

  void _showModalNewFoodRecipe(BuildContext context) {
    SoundHelper().playSmallButtonClick();
    // showModalBottomSheet(
    //   backgroundColor: Colors.transparent,
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (context) => FoodCategoryNewScreen(),
    // );
  }
}

// Argument class to receive the arguments sent on the route settings arguments parameter:
class FoodRecipeShowScreenArguments {
  final FoodRecipe foodRecipe;

  FoodRecipeShowScreenArguments(
    this.foodRecipe,
  );
}
