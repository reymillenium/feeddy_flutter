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
  final Function onPressedFAB;
  final String objectName;
  final int objectsLength;
  final List<Widget> innerWidgets;
  final int activeIndex;
  final bool isAdditionFAB;
  final IconData iconFAB;

  // Constructor:
  const FeeddyScaffold({
    Key key,
    this.appTitle,
    this.onPressedFAB,
    this.objectName,
    this.objectsLength,
    this.innerWidgets,
    this.activeIndex,
    this.isAdditionFAB = true,
    this.iconFAB = FontAwesomeIcons.plus,
  }) : super(key: key);

  @override
  _FeeddyScaffoldState createState() => _FeeddyScaffoldState();
}

class _FeeddyScaffoldState extends State<FeeddyScaffold> {
  final bool _showPortraitOnly = false;
  int _activeIndex;
  // bool _isAdditionFAB;
  // IconData _iconFAB = Icons.add;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activeIndex = widget.activeIndex;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print('didChangeDependencies => widget.iconFAB: ${widget.iconFAB}');

    super.didChangeDependencies();
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
    Color primaryColor = Theme.of(context).primaryColor;
    Color contrastingColor = ColorHelper.contrastingColor(primaryColor);

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
      onPressedAdd: widget.onPressedFAB,
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

      // Version # 1: BottomAppBar (without nav links): Has a good notch but no navigation
      // bottomNavigationBar: BottomAppBar(
      //   child: Row(
      //     children: [
      //       IconButton(icon: Icon(null), onPressed: () {}),
      //       Text(
      //         'Total: ${widget.objectName.toPluralFormForQuantity(quantity: widget.objectsLength)}',
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

      // Version # 2: BottomNavigationBar: Has navigation & works good by activeTab, but no notch
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: (index) => onTapSelectNavigation(index, context),
      //   // backgroundColor: Theme.of(context).primaryColor,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.category,
      //       ),
      //       label: '',
      //       activeIcon: Icon(
      //         Icons.category,
      //         color: Colors.red,
      //       ),
      //       tooltip: 'Categories',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.star,
      //       ),
      //       label: '',
      //       activeIcon: Icon(
      //         Icons.star,
      //         color: Colors.red,
      //       ),
      //       tooltip: 'Favorites',
      //     ),
      //   ],
      //   currentIndex: _activeIndex,
      // ),

      // Version # 3: BottomAppBar + BottomNavigationBar (with nav links): Has navigation & notch, but colors are crazy
      // bottomNavigationBar: BottomAppBar(
      //   child: BottomNavigationBar(
      //     // backgroundColor: Theme.of(context).primaryColor,
      //     backgroundColor: Colors.transparent,
      //     onTap: (index) => onTapSelectNavigation(index, context),
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.category,
      //         ),
      //         label: '',
      //         activeIcon: Icon(
      //           Icons.category,
      //           color: Colors.red,
      //         ),
      //         tooltip: 'Categories',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.star,
      //         ),
      //         label: '',
      //         activeIcon: Icon(
      //           Icons.star,
      //           color: Colors.red,
      //         ),
      //         tooltip: 'Favorites',
      //       ),
      //     ],
      //     currentIndex: _activeIndex,
      //   ),
      //   shape: CircularNotchedRectangle(),
      //   color: Theme.of(context).primaryColor,
      //   // notchMargin: 4,
      //   // clipBehavior: Clip.antiAlias,
      // ),

      // Version # 4: Hybrid with BottomAppBar + Row with BottomNavigationBarItem (without nav links): Has a good notch but no navigation
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              color: _activeIndex == 0 ? Colors.red : contrastingColor,
              icon: Icon(Icons.category),
              tooltip: 'Categories',
              onPressed: () => onTapSelectNavigation(0, context),
            ),
            IconButton(
              color: _activeIndex == 1 ? Colors.red : contrastingColor,
              icon: Icon(Icons.star),
              tooltip: 'favorites',
              onPressed: () => onTapSelectNavigation(1, context),
            ),
            // Spacer(),
          ],
        ),
        shape: CircularNotchedRectangle(),
        color: Theme.of(context).primaryColor,
        // color: Colors.white,
      ),

      // FAB
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        tooltip: '${widget.isAdditionFAB ? 'Add' : 'Delete'} ${widget.objectName.inCaps}',
        // child: Icon(_iconFAB ?? Icons.add),
        // child: Icon(_iconFAB),
        child: Icon(widget.iconFAB),
        onPressed: widget.onPressedFAB,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // floatingActionButtonLocation: deviceIsIOS ? null : FloatingActionButtonLocation.endDocked,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
