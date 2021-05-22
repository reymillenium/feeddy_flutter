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

class FoodCategoriesData with ChangeNotifier {
  // Properties:
  static const sqliteTable = {
    'table_plural_name': 'food_categories',
    'table_singular_name': 'food_category',
    'fields': [
      {
        'field_name': 'id',
        'field_type': 'INTEGER',
      },
      {
        'field_name': 'title',
        'field_type': 'TEXT',
      },
      {
        'field_name': 'color',
        'field_type': 'TEXT',
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
  List<FoodCategory> _foodCategories = [];
  DBHelper dbHelper;

  // Constructor:
  FoodCategoriesData() {
    dbHelper = DBHelper();
    refresh();
    print(Complexity.challenging.toString());
    _generateDummyData();
  }

  // Getters:
  // static get sqliteTable {
  //   return _sqliteTable;
  // }

  get foodCategories {
    return _foodCategories;
  }

  // SQLite DB CRUD:
  Future<FoodCategory> _create(FoodCategory foodCategory, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    foodCategory.id = await dbClient.insert(table['table_plural_name'], foodCategory.toMap());
    return foodCategory;
  }

  Future<List<dynamic>> _index(Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    List<Map> tableFields = table['fields'];
    List<Map> foodCategoriesMaps = await dbClient.query(table['table_plural_name'], columns: tableFields.map<String>((field) => field['field_name']).toList());
    //List<Map> objectMaps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    // var dbClientJoinedTables = await dbHelper.dbManyToManyTablePlus(FoodCategoriesFoodRecipesData.sqliteTable, table, FoodRecipesData.sqliteTable);

    List<FoodCategory> foodCategoriesList = [];
    if (foodCategoriesMaps.length > 0) {
      for (int i = 0; i < foodCategoriesMaps.length; i++) {
        FoodCategory foodCategory;
        foodCategory = FoodCategory.fromMap(foodCategoriesMaps[i]);
        // Declaration of temporal empty lists:
        List<FoodCategoryFoodRecipe> foodCategoriesFoodRecipesList = [];
        List<FoodRecipe> foodRecipesList = [];

        try {
          // Gathering on the join table (food_categories_food_recipes) by the foodCategoryId:
          List<Map> foodCategoriesFoodRecipesTableFields = FoodCategoriesFoodRecipesData.sqliteTable['fields'];
          String foodCategoriesFoodRecipesTableName = FoodCategoriesFoodRecipesData.sqliteTable['table_plural_name'];

          List<Map> foodCategoriesFoodRecipesMaps = await dbClient.query(foodCategoriesFoodRecipesTableName, columns: foodCategoriesFoodRecipesTableFields.map<String>((field) => field['field_name']).toList(), where: 'food_category_id = ?', whereArgs: [foodCategory.id]);
          if (foodCategoriesFoodRecipesMaps.length > 0) {
            // If the FoodCategory object has at least one associated FoodRecipe...
            for (int j = 0; j < foodCategoriesFoodRecipesMaps.length; j++) {
              FoodCategoryFoodRecipe foodCategoryFoodRecipe;
              foodCategoryFoodRecipe = FoodCategoryFoodRecipe.fromMap(foodCategoriesFoodRecipesMaps[j]);
              // Adding the FoodCategoryFoodRecipe object to the temporal list:
              foodCategoriesFoodRecipesList.add(foodCategoryFoodRecipe);
            }

            List<int> foodRecipesIdsList = foodCategoriesFoodRecipesList.map((foodCategoryFoodRecipe) => foodCategoryFoodRecipe.foodRecipeId).toList();
            // Gathering of its FoodRecipe objects based on then possibly gathered FoodCategoryFoodRecipe objects:
            List<Map> foodRecipesTableFields = FoodRecipesData.sqliteTable['fields'];
            List<Map> foodRecipesMaps = await dbClient.query(FoodRecipesData.sqliteTable['table_plural_name'], columns: foodRecipesTableFields.map<String>((field) => field['field_name']).toList(), where: 'id = ?', whereArgs: foodRecipesIdsList);

            for (int k = 0; k < foodRecipesMaps.length; k++) {
              FoodRecipe foodRecipe;
              foodRecipe = FoodRecipe.fromMap(foodRecipesMaps[k]);
              // Adding the FoodCategoryFoodRecipe object to the temporal list:
              foodRecipesList.add(foodRecipe);
            }
          }
        } catch (error) {
          // No rows on the join table or there is any other error there.
          print(error);
        }

        foodCategory.foodRecipes = foodRecipesList;
        // Adding the FoodCategory object with everything inside to the list:
        foodCategoriesList.add(foodCategory);
      }
    }
    return foodCategoriesList;
  }

  Future<int> _destroy(int id, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    return await dbClient.delete(table['table_plural_name'], where: 'id = ?', whereArgs: [id]);
  }

  Future<int> _update(FoodCategory foodCategory, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    return await dbClient.update(table['table_plural_name'], foodCategory.toMap(), where: 'id = ?', whereArgs: [foodCategory.id]);
  }

  // Private methods:
  void _generateDummyData() async {
    final List<FoodCategory> foodCategories = await _index(sqliteTable);
    final int currentLength = foodCategories.length;
    if (currentLength < _maxAmountDummyData) {
      FoodRecipesData foodRecipesData = FoodRecipesData();
      FoodCategoriesFoodRecipesData foodCategoriesFoodRecipesData = FoodCategoriesFoodRecipesData();
      for (int i = 0; i < (_maxAmountDummyData - currentLength); i++) {
        String title = faker.food.cuisine();
        Color color = ColorHelper.randomMaterialColor();
        FoodCategory foodCategory = await addFoodCategory(title, color);

        for (int j = 0; j < 5; j++) {
          try {
            print('trying beginning');
            FoodRecipe foodRecipe = await foodRecipesData.addFoodRecipe(
              title: faker.food.dish(),
              imageUrl: 'dfvdfvdf',
              duration: 2,
              complexity: Complexity.simple,
              affordability: Affordability.affordable,
              isGlutenFree: false,
              isLactoseFree: false,
              isVegan: false,
              isVegetarian: false,
            );
            print('foodRecipe.id: ${foodRecipe.id}');
            await foodCategoriesFoodRecipesData.addFoodCategoryFoodRecipe(foodCategory.id, foodRecipe.id);
          } catch (error) {
            print(error);
          }
        }
      }
    }
  }

  void _removeWhere(int id) async {
    await _destroy(id, sqliteTable);
    await refresh();
  }

  // Public methods:
  Future refresh() async {
    _foodCategories = await _index(sqliteTable);
    notifyListeners();
  }

  Future<FoodCategory> addFoodCategory(String title, Color color) async {
    DateTime now = DateTime.now();
    FoodCategory newFoodCategory = FoodCategory(
      title: title,
      color: color,
      createdAt: now,
      updatedAt: now,
    );
    FoodCategory foodCategory = await _create(newFoodCategory, sqliteTable);
    refresh();
    return foodCategory;
  }

  Future<void> updateFoodCategory(int id, String title, Color color) async {
    DateTime now = DateTime.now();
    FoodCategory updatingFoodCategory = _foodCategories.firstWhere((foodCategory) => id == foodCategory.id);

    updatingFoodCategory.title = title;
    updatingFoodCategory.color = color;
    updatingFoodCategory.updatedAt = now;

    await _update(updatingFoodCategory, sqliteTable);
    refresh();
  }

  Future<void> deleteFoodCategoryWithConfirm(int id, BuildContext context) {
    DialogHelper.showDialogPlus(id, context, () => _removeWhere(id)).then((value) {
      (context as Element).reassemble();
      refresh();
    });
  }

  void deleteFoodCategoryWithoutConfirm(int id) {
    _removeWhere(id);
    // refresh();
  }
}
