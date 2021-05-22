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

enum Complexity {
  verySimple,
  simple,
  medium,
  challenging,
  hard,
  veryHard,
}
enum Affordability {
  veryCheap,
  cheap,
  affordable,
  pricey,
  expensive,
  luxurious,
}

class FoodRecipe {
  // Properties:
  int id;
  String title;
  List<FoodCategory> foodCategories; // Has many relationship
  String imageUrl;
  List<FoodIngredient> foodIngredients; // Has many relationship
  List<RecipeStep> recipeSteps; // Has many relationship
  int duration;
  Complexity complexity;
  Affordability affordability;
  bool isGlutenFree;
  bool isLactoseFree;
  bool isVegan;
  bool isVegetarian;
  DateTime createdAt;
  DateTime updatedAt;

  // Constructors:
  FoodRecipe({
    this.id,
    @required this.title,
    this.foodCategories,
    @required this.imageUrl,
    this.foodIngredients,
    this.recipeSteps,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.isGlutenFree,
    @required this.isLactoseFree,
    @required this.isVegan,
    @required this.isVegetarian,
    @required this.createdAt,
    @required this.updatedAt,
  });

  FoodRecipe.fromMap(Map<String, dynamic> foodRecipeMap) {
    id = foodRecipeMap['id'];
    title = foodRecipeMap['title'];
    // foodCategories = foodRecipeMap['foodCategories']; // TODO: Implement the loading of the foodCategories
    imageUrl = foodRecipeMap['imageUrl'];
    // foodIngredients = foodRecipeMap['foodIngredients']; // TODO: Implement the loading of the foodIngredients from the DB into a FoodRecipe object
    // recipeSteps = foodRecipeMap['recipeSteps']; // TODO: Implement the loading of the recipeSteps from the DB into a FoodRecipe object
    duration = foodRecipeMap['duration'];
    complexity = foodRecipeMap['complexity'];
    affordability = foodRecipeMap['affordability'];
    isGlutenFree = foodRecipeMap['isGlutenFree'] == 1 ? true : false;
    isLactoseFree = foodRecipeMap['isLactoseFree'] == 1 ? true : false;
    isVegan = foodRecipeMap['isVegan'] == 1 ? true : false;
    isVegetarian = foodRecipeMap['isVegetarian'] == 1 ? true : false;

    createdAt = DateTime.parse(foodRecipeMap['createdAt']);
    updatedAt = DateTime.parse(foodRecipeMap['updatedAt']);
  }

  Map<String, dynamic> toMap() {
    var foodRecipeMap = <String, dynamic>{
      'id': id,
      'title': title,
      // 'foodCategories': foodCategories,
      'imageUrl': imageUrl,
      // 'ingredients': foodIngredients,
      // 'recipeSteps': recipeSteps,
      'duration': duration,
      'complexity': complexity.toString(),
      'affordability': affordability.toString(),
      'isGlutenFree': isGlutenFree ? 1 : 0,
      'isLactoseFree': isLactoseFree ? 1 : 0,
      'isVegan': isVegan ? 1 : 0,
      'isVegetarian': isVegetarian ? 1 : 0,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
    return foodRecipeMap;
  }
}
