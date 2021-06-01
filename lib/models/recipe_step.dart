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

class RecipeStep {
  // Properties:
  int id;
  String description;
  int foodRecipeId;
  DateTime createdAt;
  DateTime updatedAt;

  // Constructors:
  RecipeStep({
    this.id,
    @required this.description,
    @required this.foodRecipeId,
    @required this.createdAt,
    @required this.updatedAt,
  });

  RecipeStep.fromMap(Map<String, dynamic> recipeStepMap) {
    id = recipeStepMap['id'];
    description = recipeStepMap['description'];
    foodRecipeId = recipeStepMap['food_recipe_id'];

    createdAt = DateTime.parse(recipeStepMap['created_at']);
    updatedAt = DateTime.parse(recipeStepMap['updated_at']);
  }

  Map<String, dynamic> toMap() {
    var recipeStepMap = <String, dynamic>{
      'id': id,
      'description': description,
      'food_recipe_id': foodRecipeId,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
    return recipeStepMap;
  }
}
