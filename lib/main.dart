// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Screens:
import 'package:feeddy_flutter/screens/food_categories_screen.dart';

// Models:
import 'package:feeddy_flutter/models/_models.dart';

void main() {
  // Disables the Landscape mode:
  // WidgetsFlutterBinding.ensureInitialized(); // Without this it might not work in some devices:
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  // With one single provider:
  // runApp(ChangeNotifierProvider(
  //   create: (context) => AppData(),
  //   // child: MyApp(),
  //   child: InitialSplashScreen(),
  // ));

  // With several providers:
  runApp(MultiProvider(
    providers: [
      // Config about the app:
      ChangeNotifierProvider<AppData>(
        create: (context) => AppData(),
      ),

      // Data related to the FoodCategoriesData objects: (sqlite)
      ChangeNotifierProvider<FoodCategoriesData>(
        create: (context) => FoodCategoriesData(),
      ),
    ],
    // child: MyApp(),
    child: InitialSplashScreen(),
  ));
}

class InitialSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String reymilleniumLocalImage = 'assets/images/feeddy_logo_1024_x_1024.png';
    // String reymilleniumLocalImage = 'assets/images/feeddy_main_icon_only_bigger_1024_x_1024.png';

    return MaterialApp(
      home: SplashScreen(
        seconds: 2,
        navigateAfterSeconds: MyApp(),
        gradientBackground: LinearGradient(colors: [
          Color(0xFFFFFEF1),
          Color(0xFFFFFEF1),
          // Colors.white70,
        ]),
        image: Image.asset(
          reymilleniumLocalImage,
        ),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(),
        title: Text(
          'Reymillenium\nProductions',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Luminari',
            color: Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
        loadingText: Text(
          'Version 1.0.1',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        photoSize: 260,
        onClick: () {},
        loaderColor: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    ThemeData currentThemeData = appData.currentThemeData;
    Map currentThemeFont = appData.currentThemeFont;
    final String appTitle = 'Feeddy';

    return MaterialApp(
      title: appTitle,
      // theme: currentThemeData,
      theme: currentThemeData.copyWith(
        textTheme: currentThemeData.textTheme.copyWith(
          headline6: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontFamily: currentThemeFont['fontFamily'],
            // color: currentThemeData.textTheme.headline6.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: currentThemeData.appBarTheme.copyWith(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // color: Colors.yellow,
                ),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: FoodCategoriesScreen(appTitle: appTitle),
    );
  }
}
