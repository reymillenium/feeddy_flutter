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

class FoodCategoriesFoodRecipesData with ChangeNotifier {
  // Properties:
  static const sqliteTable = {
    'table_plural_name': 'food_categories_food_recipes',
    'table_singular_name': 'food_category_food_recipe',
    'fields': [
      {
        'field_name': 'id',
        'field_type': 'INTEGER',
      },
      {
        'field_name': 'food_category_id',
        'field_type': 'INTEGER',
      },
      {
        'field_name': 'food_recipe_id',
        'field_type': 'INTEGER',
      },
      {
        'field_name': 'createdAt',
        'field_type': 'TEXT',
      },
      {
        'field_name': 'updatedAt',
        'field_type': 'TEXT',
      },
    ],
  };
  final int _maxAmountDummyData = 12;
  List<FoodCategoryFoodRecipe> _foodCategoriesFoodRecipes = [];
  DBHelper dbHelper;

  // Constructor:
  FoodCategoriesFoodRecipesData() {
    dbHelper = DBHelper();
    refresh();
    // _generateDummyData();
  }

  // Getters:
  // static get sqliteTable {
  //   return _sqliteTable;
  // }

  get foodCategoriesFoodRecipes {
    return _foodCategoriesFoodRecipes;
  }

  // SQLite DB CRUD:
  Future<FoodCategoryFoodRecipe> _create(FoodCategoryFoodRecipe foodCategoryFoodRecipe, Map<String, dynamic> tableC, Map<String, dynamic> tableA, Map<String, dynamic> tableB) async {
    // var dbClient = await dbHelper.dbManyToManyTablePlus(tableC, tableA, tableB);
    var dbClient = await dbHelper.dbPlus();
    foodCategoryFoodRecipe.id = await dbClient.insert(tableC['table_plural_name'], foodCategoryFoodRecipe.toMap());
    return foodCategoryFoodRecipe;
  }

  Future<List<dynamic>> _index(Map<String, dynamic> tableC, Map<String, dynamic> tableA, Map<String, dynamic> tableB) async {
    var dbClient = await dbHelper.dbPlus();
    List<Map> tableFields = tableC['fields'];
    List<Map> foodCategoryFoodRecipeMaps = await dbClient.query(tableC['table_plural_name'], columns: tableFields.map<String>((field) => field['field_name']).toList());
    //List<Map> objectMaps = await dbClient.rawQuery("SELECT * FROM $TABLE");

    List<FoodCategoryFoodRecipe> foodCategoriesFoodRecipesList = [];
    if (foodCategoryFoodRecipeMaps.length > 0) {
      for (int i = 0; i < foodCategoryFoodRecipeMaps.length; i++) {
        FoodCategoryFoodRecipe foodCategoryFoodRecipe;
        foodCategoryFoodRecipe = FoodCategoryFoodRecipe.fromMap(foodCategoryFoodRecipeMaps[i]);
        foodCategoriesFoodRecipesList.add(foodCategoryFoodRecipe);
      }
    }
    return foodCategoriesFoodRecipesList;
  }

  Future<int> _destroy(int id, Map<String, dynamic> tableC, Map<String, dynamic> tableA, Map<String, dynamic> tableB) async {
    var dbClient = await dbHelper.dbPlus();
    return await dbClient.delete(tableC['table_plural_name'], where: 'id = ?', whereArgs: [id]);
  }

  Future<int> _update(FoodCategoryFoodRecipe foodCategoryFoodRecipe, Map<String, dynamic> tableC, Map<String, dynamic> tableA, Map<String, dynamic> tableB) async {
    var dbClient = await dbHelper.dbPlus();
    return await dbClient.update(tableC['table_plural_name'], foodCategoryFoodRecipe.toMap(), where: 'id = ?', whereArgs: [foodCategoryFoodRecipe.id]);
  }

  // Private methods:
  void _generateDummyData() async {
    final List<FoodCategoryFoodRecipe> foodCategoriesFoodRecipesList = await _index(sqliteTable, FoodCategoriesData.sqliteTable, FoodRecipesData.sqliteTable);
    final int currentLength = foodCategoriesFoodRecipesList.length;
    if (currentLength < _maxAmountDummyData) {
      for (int i = 0; i < (_maxAmountDummyData - currentLength); i++) {
        // String title = faker.food.dish();
        // // Color color = ColorHelper.randomColor();
        // Color color = ColorHelper.randomMaterialColor();
        // await addFoodCategory(title, color);
      }
    }
  }

  void _removeWhere(int id) async {
    await _destroy(id, sqliteTable, FoodCategoriesData.sqliteTable, FoodRecipesData.sqliteTable);
    await refresh();
  }

  // Public methods:
  Future refresh() async {
    _foodCategoriesFoodRecipes = await _index(sqliteTable, FoodCategoriesData.sqliteTable, FoodRecipesData.sqliteTable);
    notifyListeners();
  }

  Future<void> addFoodCategoryFoodRecipe(int foodCategoryId, int foodRecipeId) async {
    DateTime now = DateTime.now();

    FoodCategoryFoodRecipe newFoodCategoryFoodRecipe = FoodCategoryFoodRecipe(
      foodCategoryId: foodCategoryId,
      foodRecipeId: foodRecipeId,
      createdAt: now,
      updatedAt: now,
    );
    await _create(newFoodCategoryFoodRecipe, sqliteTable, FoodCategoriesData.sqliteTable, FoodRecipesData.sqliteTable);
    refresh();
  }

  Future<void> updateFoodCategoryFoodRecipe(int id, int foodCategoryId, int foodRecipeId) async {
    DateTime now = DateTime.now();
    FoodCategoryFoodRecipe updatingFoodCategoryFoodRecipe = _foodCategoriesFoodRecipes.firstWhere((foodCategoryFoodRecipe) => id == foodCategoryFoodRecipe.id);

    updatingFoodCategoryFoodRecipe.foodCategoryId = foodCategoryId;
    updatingFoodCategoryFoodRecipe.foodRecipeId = foodRecipeId;
    updatingFoodCategoryFoodRecipe.updatedAt = now;

    await _update(updatingFoodCategoryFoodRecipe, sqliteTable, FoodCategoriesData.sqliteTable, FoodRecipesData.sqliteTable);
    refresh();
  }

  Future<void> deleteFoodCategoryFoodRecipeWithConfirm(int id, BuildContext context) {
    DialogHelper.showDialogPlus(id, context, () => _removeWhere(id)).then((value) {
      (context as Element).reassemble();
      refresh();
    });
  }

  void deleteFoodCategoryFoodRecipeWithoutConfirm(int id) {
    _removeWhere(id);
    // refresh();
  }
}
