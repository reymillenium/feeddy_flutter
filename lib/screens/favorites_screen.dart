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

class FavoritesScreen extends StatefulWidget {
  static const String screenId = 'favorites_screen';

  const FavoritesScreen({Key key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return FeeddyScaffold(
      activeIndex: 1,
      appTitle: 'Favorites',
      innerWidgets: [
        // Food Categories Grid:
        Expanded(
          flex: 5,
          child: Text('Favorites'),
        ),
      ],
      objectsLength: 0,
      objectName: 'favorite',
      onPressedAdd: () => _showModalNewFavorite(context),
    );
  }

  void _showModalNewFavorite(BuildContext context) {
    SoundHelper().playSmallButtonClick();
    // showModalBottomSheet(
    //   backgroundColor: Colors.transparent,
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (context) => FoodRecipeNewScreen(),
    // );
  }
}
