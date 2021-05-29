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

class UnknownScreen extends StatefulWidget {
  static const String screenId = 'unknown_screen';

  // Properties:
  final String appTitle;

  const UnknownScreen({
    Key key,
    this.appTitle,
  }) : super(key: key);

  @override
  _UnknownScreenState createState() => _UnknownScreenState();
}

class _UnknownScreenState extends State<UnknownScreen> {
  // State Properties:
  bool _showPortraitOnly = false;
  String _appTitle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appTitle = widget.appTitle;
  }

  @override
  Widget build(BuildContext context) {
    return FeeddyScaffold(
      appTitle: _appTitle,
      innerWidgets: [
        FeeddyEmptyWidget(
          packageImage: 1,
          title: 'We are sorry',
          subTitle: 'That screen does not exist',
        ),
      ],
      onPressedAdd: () => _showModalNewThing(context),
      objectsLength: 0,
      objectName: 'thing',
    );
  }

  void _showModalNewThing(BuildContext context) {
    SoundHelper().playSmallButtonClick();
    // showModalBottomSheet(
    //   backgroundColor: Colors.transparent,
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (context) => FoodCategoryNewScreen(),
    // );
  }
}
