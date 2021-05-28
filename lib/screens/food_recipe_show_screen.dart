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
    AppData appData = Provider.of<AppData>(context, listen: true);
    Function closeAllThePanels = appData.closeAllThePanels; // Drawer related:
    bool deviceIsIOS = DeviceHelper.deviceIsIOS(context);

    FoodRecipesData foodRecipesData = Provider.of<FoodRecipesData>(context, listen: true);
    int amountTotalFoodRecipes = foodRecipesData.foodRecipes.length;

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
      title: _foodRecipe.title,
      showModalNewDishCategory: () => _showModalNewFoodRecipe(context),
    );

    return Scaffold(
      appBar: appBar,
      onDrawerChanged: (isOpened) {
        if (!isOpened) {
          closeAllThePanels();
        }
      },

      drawer: FeeddyDrawer(
          // showChart: _showChart,
          // showPortraitOnly: _showPortraitOnly,
          // onSwitchShowChart: onSwitchShowChart,
          // onSwitchPortraitOnLy: onSwitchPortraitOnLy,
          ),

      body: NativeDeviceOrientationReader(
        builder: (context) {
          final orientation = NativeDeviceOrientationReader.orientation(context);
          bool safeAreaLeft = DeviceHelper.isLandscapeLeft(orientation);
          bool safeAreaRight = DeviceHelper.isLandscapeRight(orientation);
          bool isLandscape = DeviceHelper.isLandscape(orientation);

          return SafeArea(
            left: safeAreaLeft,
            right: safeAreaRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Food Categories List:
                // Expanded(
                //   flex: 5,
                //   child: FoodCategoriesList(),
                // ),
                // Food Categories Grid:
                // Expanded(
                //   flex: 5,
                //   child: FoodCategoriesGrid(),
                // ),
                // Food Recipes List:
                // Expanded(
                //   flex: 5,
                //   child: FoodRecipesList(
                //     foodCategory: _foodRecipe,
                //   ),
                // ),
              ],
            ),
          );
        },
      ),

      // Navigation Bar (without nav links)
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(icon: Icon(null), onPressed: () {}),
            Text(
              'Total: $amountTotalFoodRecipes recipes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                // fontSize: amountFontSize,
                color: Colors.white,
              ),
            ),
            // Spacer(),
            // IconButton(icon: Icon(Icons.search), onPressed: () {}),
            // IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
        shape: CircularNotchedRectangle(),
        color: Theme.of(context).primaryColor,
      ),

      // FAB
      floatingActionButton: deviceIsIOS
          ? null
          : FloatingActionButton(
              tooltip: 'Add Category',
              child: Icon(Icons.add),
              onPressed: () => _showModalNewFoodRecipe(context),
            ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButtonLocation: deviceIsIOS ? null : FloatingActionButtonLocation.endDocked,
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
