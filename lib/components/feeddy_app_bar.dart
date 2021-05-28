// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Screens:

// Models:
import 'package:feeddy_flutter/models/_models.dart';

// Components:
import 'package:feeddy_flutter/components/_components.dart';

// Helpers:
import 'package:feeddy_flutter/helpers/_helpers.dart';

// Utilities:
import 'package:feeddy_flutter/utilities/constants.dart';

class FeeddyAppBar extends StatelessWidget with PreferredSizeWidget {
  // Properties:
  final String appTitle;
  final Function onPressedAdd;
  final String objectName;

  const FeeddyAppBar({
    Key key,
    this.appTitle,
    this.onPressedAdd,
    this.objectName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Map currentThemeFont = appData.currentThemeFont;

    return AppBar(
      title: Text(
        appTitle,
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
          tooltip: 'Add ${objectName.inCaps}',
          onPressed: onPressedAdd,
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
