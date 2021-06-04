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

class FeeddyScaffold extends StatefulWidget {
  // Properties:
  final bool _showPortraitOnly = false;
  final String appTitle;
  final Function onPressedAdd;
  final String objectName;
  final int objectsLength;
  final List<Widget> innerWidgets;
  final int activeIndex;

  // Constructor:
  const FeeddyScaffold({
    Key key,
    this.appTitle,
    this.onPressedAdd,
    this.objectName,
    this.objectsLength,
    this.innerWidgets,
    this.activeIndex,
  }) : super(key: key);

  @override
  _FeeddyScaffoldState createState() => _FeeddyScaffoldState();
}

class _FeeddyScaffoldState extends State<FeeddyScaffold> {
  final bool _showPortraitOnly = false;
  int _activeIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activeIndex = widget.activeIndex;
  }

  void onTapSelectNavigation(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, FoodCategoryIndexScreen.screenId);
        break;
      case 1:
        Navigator.pushNamed(context, FavoritesScreen.screenId);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Function closeAllThePanels = appData.closeAllThePanels; // Drawer related:
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

    FeeddyAppBar appBar = FeeddyAppBar(
      appTitle: widget.appTitle,
      onPressedAdd: widget.onPressedAdd,
      objectName: widget.objectName,
    );

    return Scaffold(
      appBar: appBar,
      onDrawerChanged: (isOpened) {
        if (!isOpened) {
          // closeAllThePanels();
          // This fixes the error:
          // Flutter setState() or markNeedsBuild() called when widget tree was locked
          WidgetsBinding.instance.addPostFrameCallback((_) {
            closeAllThePanels();
          });

          // This also fixes the ame error:
          // Future.delayed(Duration.zero, () {
          //   closeAllThePanels();
          // });

          // And also this fixes the same error:
          // Timer.run(() {
          //   closeAllThePanels();
          // });
        }
      },

      drawer: FeeddyDrawer(),

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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.innerWidgets,
            ),
          );
        },
      ),

      // Navigation Bar (without nav links)
      // bottomNavigationBar: BottomAppBar(
      //   child: Row(
      //     children: [
      //       IconButton(icon: Icon(null), onPressed: () {}),
      //       Text(
      //         'Total: ${objectName.toPluralFormForQuantity(quantity: objectsLength)}',
      //         style: TextStyle(
      //           fontWeight: FontWeight.bold,
      //           fontStyle: FontStyle.italic,
      //           // fontSize: amountFontSize,
      //           color: Colors.white,
      //         ),
      //       ),
      //       // Spacer(),
      //       // IconButton(icon: Icon(Icons.search), onPressed: () {}),
      //       // IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
      //     ],
      //   ),
      //   shape: CircularNotchedRectangle(),
      //   color: Theme.of(context).primaryColor,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => onTapSelectNavigation(index, context),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
            ),
            label: '',
            activeIcon: Icon(
              Icons.category,
              color: Colors.red,
            ),
            tooltip: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: '',
            activeIcon: Icon(
              Icons.star,
              color: Colors.red,
            ),
            tooltip: 'Favorites',
          ),
        ],
        currentIndex: _activeIndex,
      ),

      // FAB
      floatingActionButton: deviceIsIOS
          ? null
          : FloatingActionButton(
              tooltip: 'Add ${widget.objectName.inCaps}',
              child: Icon(Icons.add),
              onPressed: () => widget.onPressedAdd,
            ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButtonLocation: deviceIsIOS ? null : FloatingActionButtonLocation.endDocked,
    );
  }
}
