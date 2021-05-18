// Packages:

import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Screens:

// Models:

// Components:

// Helpers:

// Utilities:

class AppData extends ChangeNotifier {
  // Properties:
  ThemeData _currentThemeData;
  int _themeColorIndex = 0;
  List<Map> _availableThemeColors = [
    {
      'name': 'Purple',
      'theme': {
        'primarySwatch': Colors.deepPurple,
        'primaryColor': Colors.deepPurple,
        'accentColor': Colors.purpleAccent,
      },
    },
    {
      'name': 'Indigo',
      'theme': {
        'primarySwatch': Colors.indigo,
        'primaryColor': Colors.indigo,
        'accentColor': Colors.indigoAccent,
      },
    },
    {
      'name': 'Blue',
      'theme': {
        'primarySwatch': Colors.blue,
        'primaryColor': Colors.blue,
        'accentColor': Colors.blueAccent,
      },
    },
    {
      'name': 'Orange',
      'theme': {
        'primarySwatch': Colors.deepOrange,
        'primaryColor': Colors.deepOrange,
        'accentColor': Colors.orangeAccent,
      },
    },
    {
      'name': 'Pink',
      'theme': {
        'primarySwatch': Colors.pink,
        'primaryColor': Colors.pink,
        'accentColor': Colors.pinkAccent,
      },
    },
    {
      'name': 'Teal',
      'theme': {
        'primarySwatch': Colors.teal,
        'primaryColor': Colors.teal,
        'accentColor': Colors.tealAccent,
      },
    },
    {
      'name': 'Green',
      'theme': {
        'primarySwatch': Colors.green,
        'primaryColor': Colors.green,
        'accentColor': Colors.greenAccent,
      },
    },
    {
      'name': 'Cyan',
      'theme': {
        'primarySwatch': Colors.cyan,
        'primaryColor': Colors.cyan,
        'accentColor': Colors.cyanAccent,
      },
    },
  ];

  int _themeFontIndex = 0;
  List<Map> _availableThemeFonts = [
    {
      'name': 'RobotoCondensed',
      'fontFamily': 'RobotoCondensed',
    },
    {
      'name': 'Raleway',
      'fontFamily': 'Raleway',
    },
    {
      'name': 'Roboto',
      'fontFamily': 'Roboto',
    },
    {
      'name': 'Luminari',
      'fontFamily': 'Luminari',
    },
    {
      'name': 'SourceSansPro',
      'fontFamily': 'SourceSansPro',
    },
    {
      'name': 'OpenSans',
      'fontFamily': 'OpenSans',
    },
    {
      'name': 'Quicksand',
      'fontFamily': 'Quicksand',
    },
  ];

  int _currencyIndex = 0;
  List<Map> _availableCurrencies = [
    {
      'name': 'USA Dollar',
      'code': 'USD',
      'symbol': '\$',
      'icon': FontAwesomeIcons.dollarSign,
    },
    {
      'name': 'Euro',
      'code': 'EUR',
      'symbol': '€',
      'icon': FontAwesomeIcons.euroSign,
    },
    {
      'name': 'British Pound',
      'code': 'GBP',
      'symbol': '£',
      'icon': FontAwesomeIcons.poundSign,
    },
    {
      'name': 'Indian Rupee',
      'code': 'INR',
      'symbol': '₹',
      'icon': FontAwesomeIcons.rupeeSign,
    },
    {
      'name': 'Japanese Yen',
      'code': 'JPY',
      'symbol': '¥',
      'icon': FontAwesomeIcons.yenSign,
    },
    {
      'name': 'Russian Ruble',
      'code': 'RUB',
      'symbol': '₽',
      'icon': FontAwesomeIcons.rubleSign,
    },
  ];

  // Drawer Information:
  List<Map> _expansionPanelListStatus = [
    {'isOpened': false},
    {'isOpened': false},
    {'isOpened': false},
    {'isOpened': false},
  ];

  int _weeklyChartIndex = 0;
  List<Map> _availableWeeklyCharts = [
    {
      'name': 'Weekly Home made',
      'code': 'weekly_home_made',
      'icon': FontAwesomeIcons.chartBar,
    },
    {
      'name': 'Weekly FL Chart',
      'code': 'weekly_fl_chart',
      'icon': FontAwesomeIcons.chartArea,
    },
  ];

  // Constructor:
  AppData() {
    ThemeData newThemeData = ThemeData(
      fontFamily: _availableThemeFonts[_themeFontIndex]['fontFamily'],
      primarySwatch: _availableThemeColors[_themeColorIndex]['theme']['primarySwatch'],
      primaryColor: _availableThemeColors[_themeColorIndex]['theme']['primaryColor'],
      accentColor: _availableThemeColors[_themeColorIndex]['theme']['accentColor'],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: _availableThemeColors[_themeColorIndex]['theme']['primaryColor'] == Colors.deepPurple ? Colors.white : Colors.black,
      ),
    );
    _currentThemeData = newThemeData;
  }

  // Getters:
  get currentThemeData {
    return _currentThemeData;
  }

  get themeColorIndex {
    return _themeColorIndex;
  }

  UnmodifiableListView<Map> get availableThemeColors {
    return UnmodifiableListView(_availableThemeColors);
  }

  get currentThemeColors {
    return _availableThemeColors[_themeColorIndex];
  }

  get fontIndex {
    return _themeFontIndex;
  }

  UnmodifiableListView<Map> get availableThemeFonts {
    return UnmodifiableListView(_availableThemeFonts);
  }

  get currentThemeFont {
    return _availableThemeFonts[_themeFontIndex];
  }

  get currencyIndex {
    return _currencyIndex;
  }

  UnmodifiableListView<Map> get availableCurrencies {
    return UnmodifiableListView(_availableCurrencies);
  }

  get currentCurrency {
    return _availableCurrencies[_currencyIndex];
  }

  // Drawer Related:
  get expansionPanelListStatus {
    return _expansionPanelListStatus;
  }

  get weeklyChartIndex {
    return _weeklyChartIndex;
  }

  UnmodifiableListView<Map> get availableWeeklyCharts {
    return UnmodifiableListView(_availableWeeklyCharts);
  }

  get currentWeeklyChart {
    return _availableWeeklyCharts[_weeklyChartIndex];
  }

  get isWeeklyFlChart {
    return _availableWeeklyCharts[_weeklyChartIndex]['code'] == 'weekly_fl_chart';
  }

  // Public methods:
  void setCurrentThemeColor(int themeColorIndex) {
    _themeColorIndex = themeColorIndex;
    ThemeData newThemeData = ThemeData(
      fontFamily: _availableThemeFonts[_themeFontIndex]['fontFamily'],
      primarySwatch: _availableThemeColors[themeColorIndex]['theme']['primarySwatch'],
      primaryColor: _availableThemeColors[themeColorIndex]['theme']['primaryColor'],
      accentColor: _availableThemeColors[themeColorIndex]['theme']['accentColor'],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: _availableThemeColors[_themeColorIndex]['theme']['primaryColor'] == Colors.deepPurple ? Colors.white : Colors.black,
      ),
    );
    _currentThemeData = newThemeData;
    notifyListeners();
  }

  void setCurrentFontFamily(int themeFontIndex) {
    _themeFontIndex = themeFontIndex;
    ThemeData newThemeData = ThemeData(
      fontFamily: _availableThemeFonts[themeFontIndex]['fontFamily'],
      primarySwatch: _availableThemeColors[_themeColorIndex]['theme']['primarySwatch'],
      primaryColor: _availableThemeColors[_themeColorIndex]['theme']['primaryColor'],
      accentColor: _availableThemeColors[themeColorIndex]['theme']['accentColor'],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: _availableThemeColors[_themeColorIndex]['theme']['primaryColor'] == Colors.deepPurple ? Colors.white : Colors.black,
      ),
    );
    _currentThemeData = newThemeData;
    notifyListeners();
  }

  void setCurrentCurrency(int currencyIndex) {
    _currencyIndex = currencyIndex;
    notifyListeners();
  }

  void setCurrentWeeklyChart(int weeklyChartIndex) {
    _weeklyChartIndex = weeklyChartIndex;
    notifyListeners();
  }

  // Drawer Related:
  void closeAllThePanels() {
    for (int i = 0; i < _expansionPanelListStatus.length; i++) {
      _expansionPanelListStatus[i]['isOpened'] = false;
    }
    notifyListeners();
  }

  void openOnePanelAndCloseTheRest(int index, bool isExpanded) {
    for (int i = 0; i < _expansionPanelListStatus.length; i++) {
      if (index == i) {
        _expansionPanelListStatus[index]['isOpened'] = !isExpanded;
      } else {
        _expansionPanelListStatus[i]['isOpened'] = false;
      }
    }
    notifyListeners();
  }
}
