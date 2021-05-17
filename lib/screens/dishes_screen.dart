// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Screens:
import 'package:feeddy_flutter/screens/new_food_category_screen.dart';

// Models:
import 'package:feeddy_flutter/models/_models.dart';

// Components:
import 'package:feeddy_flutter/components/_components.dart';

// Helpers:
import 'package:feeddy_flutter/helpers/_helpers.dart';

// Utilities:

class DishesScreen extends StatefulWidget {
  // Properties:
  final String title;

  // Constructor:
  DishesScreen({Key key, this.title}) : super(key: key);

  @override
  _DishesScreenState createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> with WidgetsBindingObserver {
  // State Properties:
  int touchedIndex;
  bool _showChart = true;
  bool _showPortraitOnly = false;

  void _touchCallbackHandler(BarTouchResponse barTouchResponse) {
    setState(() {
      if (barTouchResponse.spot != null && barTouchResponse.touchInput is! PointerUpEvent && barTouchResponse.touchInput is! PointerExitEvent) {
        touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
      } else {
        touchedIndex = -1;
      }
    });
  }

  // void onSwitchShowChart(bool choice) {
  //   setState(() {
  //     _showChart = choice;
  //   });
  // }

  void onSwitchPortraitOnLy(bool choice) {
    setState(() {
      _showPortraitOnly = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Function closeAllThePanels = appData.closeAllThePanels; // Drawer related:
    bool isWeeklyFlChart = appData.isWeeklyFlChart;
    bool deviceIsIOS = DeviceHelper.deviceIsIOS(context);

    // WidgetsFlutterBinding.ensureInitialized(); // Without this it might not work in some devices:
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
      if (!_showPortraitOnly) ...[
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    ]);

    // TransactionsData transactionsData = Provider.of<TransactionsData>(context, listen: true);
    // int amountTotalTransactions = transactionsData.transactions.length;

    FeeddyAppBar appBar = FeeddyAppBar(
      title: widget.title,
      showModalNewTransaction: () => _showModalNewTransaction(context),
    );

    // double appBarHeight = appBar.preferredSize.height;
    // print('totalVerticalHeight: ${DeviceHelper.totalVerticalHeight(context: context)}');
    // print('statusBarTopPadding: ${DeviceHelper.statusBarTopPadding(context: context)}');
    // print('appBarHeight: $appBarHeight');
    // print('availableHeight: ${DeviceHelper.availableHeight(context: context, appBarHeight: appBarHeight)}');

    return Scaffold(
      appBar: appBar,
      onDrawerChanged: (isOpened) {
        if (!isOpened) {
          closeAllThePanels();
        }
      },

      drawer: FeeddyDrawer(
        showChart: _showChart,
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
                if (_showChart) ...[
                  if (isWeeklyFlChart) ...[
                    // Transactions Bar Chart
                    Expanded(
                      flex: isLandscape ? 4 : 3,
                      // flex: 4,
                      child: TransactionsChart(
                        touchCallbackHandler: _touchCallbackHandler,
                        touchedIndex: touchedIndex,
                        groupedAmountLastWeek: transactionsData.groupedAmountLastWeek(),
                        biggestAmountLastWeek: transactionsData.biggestAmountLastWeek(),
                        orientation: orientation,
                      ),
                    ),
                  ] else ...[
                    // Home Made Transactions Bar Chart
                    Expanded(
                      flex: isLandscape ? 4 : 3,
                      child: TransactionsChartHomeMade(
                        groupedAmountLastWeek: transactionsData.groupedAmountLastWeek(),
                        biggestAmountLastWeek: transactionsData.biggestAmountLastWeek(),
                        orientation: orientation,
                      ),
                    ),
                  ],
                ],

                // Transaction List:
                Expanded(
                  flex: 5,
                  child: TransactionsList(),
                ),
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
              'Total: $amountTotalTransactions transactions',
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
              tooltip: 'Add Dish',
              child: Icon(Icons.add),
              onPressed: () => _showModalNewTransaction(context),
            ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButtonLocation: deviceIsIOS ? null : FloatingActionButtonLocation.endDocked,
    );
  }

  // It shows the AddTransactionScreen widget as a modal:
  void _showModalNewTransaction(BuildContext context) {
    SoundHelper().playSmallButtonClick();
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => NewFoodCategoryScreen(),
    );
  }
}
