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
    foodRecipeId = recipeStepMap['foodRecipeId'];

    createdAt = DateTime.parse(recipeStepMap['createdAt']);
    updatedAt = DateTime.parse(recipeStepMap['updatedAt']);
  }

  Map<String, dynamic> toMap() {
    var recipeStepMap = <String, dynamic>{
      'id': id,
      'description': description,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
    return recipeStepMap;
  }
}
