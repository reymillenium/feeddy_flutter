// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Screens:

// Models:
import 'package:feeddy_flutter/models/_models.dart';

// Components:

// Helpers:

// Utilities:
import 'package:feeddy_flutter/utilities/constants.dart';

class FeeddyAppBar extends StatelessWidget with PreferredSizeWidget {
  // Properties:
  final String title;
  final Function showModalNewDishCategory;

  const FeeddyAppBar({
    Key key,
    this.title,
    this.showModalNewDishCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Map currentThemeFont = appData.currentThemeFont;

    return AppBar(
      title: Text(
        title,
        // style: TextStyle(
        //   fontSize: 24,
        //   fontWeight: FontWeight.bold,
        //   fontFamily: currentThemeFont['fontFamily'],
        // ),
        style: Theme.of(context).appBarTheme.textTheme.headline6.copyWith(
              fontFamily: currentThemeFont['fontFamily'],
            ),
      ),
      actions: [
        IconButton(
          iconSize: 40,
          icon: Icon(Icons.add_rounded),
          tooltip: 'Add Category',
          // onPressed: () => showModalNewTransaction(context),
          onPressed: showModalNewDishCategory,
        ),
      ],
      // bottom: PreferredSize(
      //   preferredSize: Size.fromHeight(100.0),
      // ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolBarHeight);
}
