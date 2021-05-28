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

class FoodCategoryShowScreen extends StatefulWidget {
  static const String screenId = 'food_category_show_screen';

  // Properties:
  final String appTitle;
  final FoodCategory foodCategory;

  const FoodCategoryShowScreen({
    Key key,
    this.appTitle,
    this.foodCategory,
  }) : super(key: key);

  @override
  _FoodCategoryShowScreenState createState() => _FoodCategoryShowScreenState();
}

class _FoodCategoryShowScreenState extends State<FoodCategoryShowScreen> {
  // State Properties:
  bool _showChart = false;
  bool _showPortraitOnly = false;
  String _appTitle;
  FoodCategory _foodCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appTitle = widget.appTitle;
    _foodCategory = widget.foodCategory;
  }

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Function closeAllThePanels = appData.closeAllThePanels; // Drawer related:
    bool deviceIsIOS = DeviceHelper.deviceIsIOS(context);

    // FoodCategoriesData foodCategoriesData = Provider.of<FoodCategoriesData>(context, listen: true);
    // int amountTotalFoodCategories = foodCategoriesData.foodCategories.length;
    FoodRecipesData foodRecipesData = Provider.of<FoodRecipesData>(context, listen: true);

    // WidgetsFlutterBinding.ensureInitialized(); // Without this it might not work in some devices:
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
      if (!_showPortraitOnly) ...[
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    ]);

    FeeddyAppBar appBar = FeeddyAppBar(
      title: '${_foodCategory.title}',
      showModalNewDishCategory: () => _showModalNewFoodCategory(context),
    );

    return FutureBuilder(
        future: foodRecipesData.byFoodCategory(_foodCategory),
        builder: (ctx, snapshot) {
          List<FoodRecipe> foodRecipes = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return foodRecipes.isEmpty
                  ? FeeddyScaffold(
                      appTitle: _foodCategory.title,
                      innerWidgets: [
                        FeeddyEmptyWidget(
                          packageImage: 1,
                          title: 'We are sorry',
                          subTitle: 'There is no recipes',
                        ),
                      ],
                      objectsLength: 0,
                      objectsName: 'recipes',
                    )
                  : FeeddyScaffold(
                      appTitle: _foodCategory.title,
                      innerWidgets: [
                        Expanded(
                          flex: 5,
                          child: FoodRecipesList(
                            foodCategory: _foodCategory,
                          ),
                        ),
                      ],
                      objectsLength: foodRecipes.length,
                      objectsName: 'recipes',
                      showModal: () => _showModalNewFoodCategory(context),
                    );
            default:
              return FeeddyScaffold(
                appTitle: _foodCategory.title,
                innerWidgets: [
                  FeeddyEmptyWidget(
                    packageImage: 1,
                    title: 'We are sorry',
                    subTitle: 'There is no recipes',
                  ),
                ],
                objectsLength: 0,
                objectsName: 'recipes',
              );
          }
        });
  }

  void _showModalNewFoodCategory(BuildContext context) {
    SoundHelper().playSmallButtonClick();
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => FoodCategoryNewScreen(),
    );
  }
}

// Argument class to receive the arguments sent on the route settings arguments parameter:
class FoodCategoryShowScreenArguments {
  final FoodCategory foodCategory;

  FoodCategoryShowScreenArguments(
    this.foodCategory,
  );
}
