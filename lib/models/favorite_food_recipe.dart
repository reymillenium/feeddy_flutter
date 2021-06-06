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

class FavoriteFoodRecipe {
  // Properties:
  int id;
  int userId;
  int foodRecipeId;
  DateTime updatedAt;
  DateTime createdAt;

  // Constructors:
  FavoriteFoodRecipe({
    this.id,
    @required this.userId,
    @required this.foodRecipeId,
    @required this.createdAt,
    @required this.updatedAt,
  });

  FavoriteFoodRecipe.fromMap(Map<String, dynamic> favoriteFoodRecipeMap) {
    id = favoriteFoodRecipeMap['id'];
    userId = favoriteFoodRecipeMap['user_id'];
    foodRecipeId = favoriteFoodRecipeMap['food_recipe_id'];

    createdAt = DateTime.parse(favoriteFoodRecipeMap['created_at']);
    updatedAt = DateTime.parse(favoriteFoodRecipeMap['updated_at']);
  }

  Map<String, dynamic> toMap() {
    var favoriteFoodRecipeMap = <String, dynamic>{
      'id': id,
      'user_id': userId,
      'food_recipe_id': foodRecipeId,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
    return favoriteFoodRecipeMap;
  }

  dynamic getProp(String key) => <String, dynamic>{
        'id': id,
        'userId': userId,
        'foodRecipeId': foodRecipeId,
        'updatedAt': updatedAt,
        'createdAt': createdAt,
      }[key];
}
