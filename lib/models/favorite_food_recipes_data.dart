// Packages:

import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Screens:

// Models:
import 'package:feeddy_flutter/models/_models.dart';

// Components:

// Helpers:
import 'package:feeddy_flutter/helpers/_helpers.dart';

// Utilities:
import 'package:feeddy_flutter/utilities/_utilities.dart';

class FavoriteFoodRecipesData with ChangeNotifier {
  // Properties:
  static const sqliteTable = {
    'table_plural_name': 'favorite_food_recipes',
    'table_singular_name': 'favorite_food_recipe',
    'fields': [
      {
        'field_name': 'id',
        'field_type': 'INTEGER',
      },
      {
        'field_name': 'user_id',
        'field_type': 'INTEGER',
      },
      {
        'field_name': 'food_recipe_id',
        'field_type': 'INTEGER',
      },
      {
        'field_name': 'created_at',
        'field_type': 'TEXT',
      },
      {
        'field_name': 'updated_at',
        'field_type': 'TEXT',
      },
    ],
  };
  final int _maxAmountDummyData = 12;
  List<FavoriteFoodRecipe> _favoriteFoodRecipes = [];
  DBHelper dbHelper;

  // Constructor:
  FavoriteFoodRecipesData() {
    dbHelper = DBHelper();
    refresh();
    // _generateDummyData();
  }

  get favoriteFoodRecipes {
    return _favoriteFoodRecipes;
  }

  // SQLite DB CRUD:
  Future<FavoriteFoodRecipe> _create(FavoriteFoodRecipe favoriteFoodRecipe, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    favoriteFoodRecipe.id = await dbClient.insert(table['table_plural_name'], favoriteFoodRecipe.toMap());
    return favoriteFoodRecipe;
  }

  Future<List<dynamic>> _index(Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    List<Map> tableFields = table['fields'];
    List<Map> favoriteFoodRecipesMaps = await dbClient.query(table['table_plural_name'], columns: tableFields.map<String>((field) => field['field_name']).toList());

    List<FavoriteFoodRecipe> favoriteFoodRecipesList = [];
    if (favoriteFoodRecipesMaps.length > 0) {
      for (int i = 0; i < favoriteFoodRecipesMaps.length; i++) {
        FavoriteFoodRecipe favoriteFoodRecipe;
        favoriteFoodRecipe = FavoriteFoodRecipe.fromMap(favoriteFoodRecipesMaps[i]);
        favoriteFoodRecipesList.add(favoriteFoodRecipe);
      }
    }
    return favoriteFoodRecipesList;
  }

  Future<List<FavoriteFoodRecipe>> byUserId(int userId, {List<String> filtersList}) async {
    var dbClient = await dbHelper.dbPlus();
    List<FavoriteFoodRecipe> favoriteFoodRecipesList = [];
    filtersList = filtersList ?? [];
    String filteringString = (filtersList.isEmpty) ? '' : "(${filtersList.map((e) => "$e = 1").join(' OR ')}) AND ";

    // Gathering of the FavoriteFoodRecipe Maps based on the given userId:
    Map<String, Object> favoriteFoodRecipesTable = FavoriteFoodRecipesData.sqliteTable;
    String favoriteFoodRecipesTableName = favoriteFoodRecipesTable['table_plural_name'];
    List<Map> favoriteFoodRecipesTableFields = favoriteFoodRecipesTable['fields'];
    List<Map> favoriteFoodRecipesMaps = await dbClient.query(favoriteFoodRecipesTableName, columns: favoriteFoodRecipesTableFields.map<String>((field) => field['field_name']).toList(), where: 'user_id = ?', whereArgs: [userId]);

    // Conversion into FavoriteFoodRecipe objects:
    if (favoriteFoodRecipesMaps.length > 0) {
      for (int i = 0; i < favoriteFoodRecipesMaps.length; i++) {
        FavoriteFoodRecipe favoriteFoodRecipe = FavoriteFoodRecipe.fromMap(favoriteFoodRecipesMaps[i]);
        favoriteFoodRecipesList.add(favoriteFoodRecipe);
      }
    }
    return favoriteFoodRecipesList;
  }

  Future<int> _destroy(int userId, int foodRecipeId, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    return await dbClient.delete(table['table_plural_name'], where: 'user_id = ? AND food_recipe_id = ?', whereArgs: [userId, foodRecipeId]);
  }

  Future<int> _update(FavoriteFoodRecipe favoriteFoodRecipe, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    return await dbClient.update(table['table_plural_name'], favoriteFoodRecipe.toMap(), where: 'id = ?', whereArgs: [favoriteFoodRecipe.id]);
  }

  // Private methods:

  Future<void> _removeWhere(int userId, int foodRecipeId) async {
    await _destroy(userId, foodRecipeId, sqliteTable);
    // TODO: Add destruction of all the FoodCategoryFoodRecipe objects with matching food_recipe_id
    await refresh();
  }

  // Public methods:
  Future refresh() async {
    try {
      _favoriteFoodRecipes = await _index(sqliteTable);
    } catch (error) {}
    notifyListeners();
  }

  Future<FavoriteFoodRecipe> addFavoriteFoodRecipe({
    int userId,
    int foodRecipeId,
  }) async {
    DateTime now = DateTime.now();

    // TODO: Check that this is fine
    FavoriteFoodRecipe newFavoriteFoodRecipe = FavoriteFoodRecipe(
      userId: userId,
      foodRecipeId: foodRecipeId,
      createdAt: now,
      updatedAt: now,
    );
    FavoriteFoodRecipe favoriteFoodRecipe = await _create(newFavoriteFoodRecipe, sqliteTable);
    await refresh();
    return favoriteFoodRecipe;
  }

  Future<void> updateFavoriteFoodRecipe(
    int id,
    int userId,
    int foodRecipeId,
  ) async {
    DateTime now = DateTime.now();
    FavoriteFoodRecipe updatingFavoriteFoodRecipe = _favoriteFoodRecipes.firstWhere((favoriteFoodRecipe) => id == favoriteFoodRecipe.id);

    updatingFavoriteFoodRecipe.userId = userId;
    updatingFavoriteFoodRecipe.foodRecipeId = foodRecipeId;
    updatingFavoriteFoodRecipe.updatedAt = now;

    await _update(updatingFavoriteFoodRecipe, sqliteTable);
    refresh();
  }

  Future<void> deleteFavoriteFoodRecipeWithConfirm(int userId, int foodRecipeId, BuildContext context) {
    DialogHelper.showDialogPlus(foodRecipeId, context, () => _removeWhere(userId, foodRecipeId)).then((value) {
      // This commenting, fixes an exception when deleting
      // (context as Element).reassemble();
      refresh();
    });
  }

  Future<void> deleteFavoriteFoodRecipeWithoutConfirm(int userId, int foodRecipeId) {
    _removeWhere(userId, foodRecipeId);
    refresh();
  }
}
