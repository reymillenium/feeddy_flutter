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
  // int touchedIndex;
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
    bool isWeeklyFlChart = appData.isWeeklyFlChart;
    bool deviceIsIOS = DeviceHelper.deviceIsIOS(context);

    FoodCategoriesData foodCategoriesData = Provider.of<FoodCategoriesData>(context, listen: true);
    int amountTotalFoodCategories = foodCategoriesData.foodCategories.length;

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
      // title: widget.appTitle,
      // title: _foodCategory.title,
      title: '$_appTitle: ${_foodCategory.title}',
      showModalNewDishCategory: () => _showModalNewFoodCategory(context),
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
              'Total: $amountTotalFoodCategories categories',
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
              onPressed: () => _showModalNewFoodCategory(context),
            ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButtonLocation: deviceIsIOS ? null : FloatingActionButtonLocation.endDocked,
    );
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
  final String appTitle;
  final FoodCategory foodCategory;

  FoodCategoryShowScreenArguments(
    this.appTitle,
    this.foodCategory,
  );
}
