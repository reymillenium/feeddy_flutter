// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Screens:
import 'package:feeddy_flutter/screens/_screens.dart';

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

      // Data related to the FoodCategoriesFoodRecipesData objects: (sqlite)
      ChangeNotifierProvider<FoodCategoriesFoodRecipesData>(
        create: (context) => FoodCategoriesFoodRecipesData(),
      ),

      // Data related to the FoodRecipesData objects: (sqlite)
      ChangeNotifierProvider<FoodRecipesData>(
        create: (context) => FoodRecipesData(),
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
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: currentThemeData.textTheme.copyWith(
          headline6: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontFamily: currentThemeFont['fontFamily'],
            // color: currentThemeData.textTheme.headline6.color,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
            fontFamily: currentThemeFont['fontFamily'],
          ),
          bodyText2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
            fontFamily: currentThemeFont['fontFamily'],
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
      // home: FoodCategoryIndexScreen(appTitle: appTitle),
      initialRoute: FoodCategoryIndexScreen.screenId,

      // Named Routes with none or few arguments:
      routes: {
        FoodCategoryIndexScreen.screenId: (context) => FoodCategoryIndexScreen(appTitle: appTitle),
        FoodCategoryNewScreen.screenId: (context) => FoodCategoryNewScreen(),
        FoodCategoryEditScreen.screenId: (context) => FoodCategoryEditScreen(),
      },

      // Named Routes with extra arguments:
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == FoodCategoryShowScreen.screenId) {
          // Cast the arguments to the correct type: FoodCategoryShowScreenArguments.
          // final args = settings.arguments as FoodCategoryShowScreenArguments;
          final args = settings.arguments as Map;

          // Then, extract the required data from the arguments and pass the data to the correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return FoodCategoryShowScreen(
                appTitle: appTitle,
                // foodCategory: args.foodCategory,
                // It can even use a Map instead:
                foodCategory: args['foodCategory'],
              );
            },
          );
        }

        if (settings.name == FoodRecipeShowScreen.screenId) {
          // Cast the arguments to the correct type: FoodRecipeShowScreenArguments.
          // final args = settings.arguments as FoodRecipeShowScreenArguments;
          final args = settings.arguments as Map;

          // Then, extract the required data from the arguments and pass the data to the correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return FoodRecipeShowScreen(
                appTitle: appTitle,
                // foodRecipe: args.foodRecipe,
                // It can even use a Map instead:
                foodRecipe: args['foodRecipe'],
              );
            },
          );
        }

        // The code only supports
        // PassArgumentsScreen.screenId right now.
        // Other values need to be implemented if we
        // add them. The assertion here will help remind
        // us of that higher up in the call stack, since
        // this assertion would otherwise fire somewhere
        // in the framework.
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
