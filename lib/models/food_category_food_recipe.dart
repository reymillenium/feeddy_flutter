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

class FoodCategoryFoodRecipe {
  // Properties:
  int id;
  int foodCategoryId;
  int foodRecipeId;
  DateTime createdAt;
  DateTime updatedAt;

  // Constructors:
  FoodCategoryFoodRecipe({
    this.id,
    @required this.foodCategoryId,
    @required this.foodRecipeId,
    @required this.createdAt,
    @required this.updatedAt,
  });

  FoodCategoryFoodRecipe.fromMap(Map<String, dynamic> recipeStepMap) {
    id = recipeStepMap['id'];
    // foodCategoryId = recipeStepMap['foodCategoryId'];
    foodCategoryId = recipeStepMap['food_category_id'];
    // foodRecipeId = recipeStepMap['foodRecipeId'];
    foodRecipeId = recipeStepMap['food_recipe_id'];

    createdAt = DateTime.parse(recipeStepMap['createdAt']);
    updatedAt = DateTime.parse(recipeStepMap['updatedAt']);
  }

  Map<String, dynamic> toMap() {
    var recipeStepMap = <String, dynamic>{
      'id': id,
      // 'foodCategoryId': foodCategoryId,
      'food_category_id': foodCategoryId,
      // 'foodRecipeId': foodRecipeId,
      'food_recipe_id': foodRecipeId,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
    return recipeStepMap;
  }
}
