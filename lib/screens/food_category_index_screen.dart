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

class FoodCategoryIndexScreen extends StatefulWidget {
  static const String screenId = 'food_category_index_screen';

  // Properties:
  final String appTitle;

  const FoodCategoryIndexScreen({Key key, this.appTitle}) : super(key: key);

  @override
  _FoodCategoryIndexScreenState createState() => _FoodCategoryIndexScreenState();
}

class _FoodCategoryIndexScreenState extends State<FoodCategoryIndexScreen> with RouteAware, RouteObserverMixin {
  final String _screenId = FoodCategoryIndexScreen.screenId;
  int _activeTab = 0;
  List<String> countList = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Tweleve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen", "Twenty"];
  List<String> selectedCountList = [];

  /// Called when the top route has been popped off, and the current route
  /// shows up.
  @override
  void didPopNext() {
    print('didPopNext => Emerges: $_screenId');
    setState(() {
      _activeTab = 0;
    });
  }

  /// Called when the current route has been pushed.
  @override
  void didPush() {
    print('didPush => Arriving to: $_screenId');
    setState(() {
      _activeTab = 0;
    });
  }

  /// Called when the current route has been popped off.
  @override
  void didPop() {
    print('didPop => Popping of: $_screenId');
  }

  /// Called when a new route has been pushed, and the current route is no
  /// longer visible.
  @override
  void didPushNext() {
    print('didPushNext => Covering: $_screenId');
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   print("Back To old Screen");
  //   super.dispose();
  // }

  void _openFilterDialog(BuildContext context) async {
    await FilterListDialog.display<String>(
      context,
      listData: countList,
      selectedListData: selectedCountList,
      height: 480,
      headlineText: "Select Count",
      searchFieldHintText: "Search Here",
      choiceChipLabel: (item) {
        return item.toCamelCase.readable;
      },
      validateSelectedItem: (list, val) {
        return list.contains(val);
      },
      onItemSearch: (list, text) {
        if (list.any((element) => element.toLowerCase().contains(text.toLowerCase()))) {
          return list.where((element) => element.toLowerCase().contains(text.toLowerCase())).toList();
        } else {
          return [];
        }
      },
      onApplyButtonClick: (list) {
        if (list != null) {
          setState(() {
            selectedCountList = List.from(list);
          });
        }
        print(selectedCountList);
        Navigator.pop(context);
        // Navigator.pop(context, true);
      },
      useRootNavigator: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    FoodCategoriesData foodCategoriesData = Provider.of<FoodCategoriesData>(context, listen: true);
    int amountTotalFoodCategories = foodCategoriesData.foodCategories.length;

    return FeeddyScaffold(
      activeIndex: _activeTab,
      appTitle: widget.appTitle,
      innerWidgets: [
        // Food Categories Grid:
        Expanded(
          flex: 5,
          child: FoodCategoriesGrid(),
        ),
      ],
      objectsLength: amountTotalFoodCategories,
      objectName: 'category',
      // onPressedFAB: () => _showModalNewFoodCategory(context),
      onPressedFAB: () => _openFilterDialog(context),
    );
  }

  // It shows the AddTransactionScreen widget as a modal:
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
