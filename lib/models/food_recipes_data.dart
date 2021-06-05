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

class FoodRecipesData with ChangeNotifier {
  // Properties:
  static const sqliteTable = {
    'table_plural_name': 'food_recipes',
    'table_singular_name': 'food_recipe',
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
        'field_name': 'imageUrl',
        'field_type': 'TEXT',
      },
      {
        'field_name': 'duration',
        'field_type': 'INTEGER',
      },
      {
        'field_name': 'complexity',
        'field_type': 'TEXT',
      },
      {
        'field_name': 'affordability',
        'field_type': 'TEXT',
      },
      {
        'field_name': 'isGlutenFree',
        'field_type': 'INTEGER',
      },
      {
        'field_name': 'isLactoseFree',
        'field_type': 'INTEGER',
      },
      {
        'field_name': 'isVegan',
        'field_type': 'INTEGER',
      },
      {
        'field_name': 'isVegetarian',
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
  List<FoodRecipe> _foodRecipes = [];
  DBHelper dbHelper;

  // Constructor:
  FoodRecipesData() {
    dbHelper = DBHelper();
    refresh();
    // _generateDummyData();
  }

  // Getters:
  // static get sqliteTable {
  //   return _sqliteTable;
  // }

  get foodRecipes {
    return _foodRecipes;
  }

  // SQLite DB CRUD:
  Future<FoodRecipe> _create(FoodRecipe foodRecipe, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    foodRecipe.id = await dbClient.insert(table['table_plural_name'], foodRecipe.toMap());
    return foodRecipe;
  }

  Future<List<dynamic>> _index(Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    List<Map> tableFields = table['fields'];
    List<Map> foodRecipesMaps = await dbClient.query(table['table_plural_name'], columns: tableFields.map<String>((field) => field['field_name']).toList());

    List<FoodRecipe> foodRecipesList = [];
    if (foodRecipesMaps.length > 0) {
      for (int i = 0; i < foodRecipesMaps.length; i++) {
        FoodRecipe foodRecipe;
        foodRecipe = FoodRecipe.fromMap(foodRecipesMaps[i]);
        // List<Map> foodCategoriesMaps = await dbClient.query(table['table_plural_name'], columns: tableFields.map<String>((field) => field['field_name']).toList());

        // Declaration of temporal empty lists:
        List<FoodCategoryFoodRecipe> foodCategoriesFoodRecipesList = [];
        List<FoodCategory> foodCategoriesList = [];

        // try {
        //   // Gathering on the join table (food_categories_food_recipes) by the foodCategoryId:
        //   List<Map> foodCategoriesFoodRecipesTableFields = FoodCategoriesFoodRecipesData.sqliteTable['fields'];
        //
        //   List<Map> foodCategoriesFoodRecipesMaps = await dbClient.query(FoodCategoriesFoodRecipesData.sqliteTable['table_plural_name'], columns: foodCategoriesFoodRecipesTableFields.map<String>((field) => field['field_name']).toList(), where: 'foodRecipeId = ?', whereArgs: [foodRecipe.id]);
        //   if (foodCategoriesFoodRecipesMaps.length > 0) {
        //     // If the FoodRecipe object belongs to at least one associated FoodCategory...
        //     for (int j = 0; j < foodCategoriesFoodRecipesMaps.length; j++) {
        //       FoodCategoryFoodRecipe foodCategoryFoodRecipe;
        //       foodCategoryFoodRecipe = FoodCategoryFoodRecipe.fromMap(foodCategoriesFoodRecipesMaps[j]);
        //       // Adding the FoodCategoryFoodRecipe object to the temporal list:
        //       foodCategoriesFoodRecipesList.add(foodCategoryFoodRecipe);
        //     }
        //
        //     List<int> foodCategoriesIdsList = foodCategoriesFoodRecipesList.map((foodCategoryFoodRecipe) => foodCategoryFoodRecipe.foodCategoryId).toList();
        //     // Gathering of its FoodCategory objects based on the possibly gathered FoodCategoryFoodRecipe objects:
        //     List<Map> foodCategoriesTableFields = FoodCategoriesData.sqliteTable['fields'];
        //     List<Map> foodCategoriesMaps = await dbClient.query(FoodCategoriesData.sqliteTable['table_plural_name'], columns: foodCategoriesTableFields.map<String>((field) => field['field_name']).toList(), where: 'id = ?', whereArgs: foodCategoriesIdsList);
        //
        //     for (int k = 0; k < foodRecipesMaps.length; k++) {
        //       FoodCategory foodCategory;
        //       foodCategory = FoodCategory.fromMap(foodCategoriesMaps[k]);
        //       // Adding the FoodCategoryFoodRecipe object to the temporal list:
        //       foodCategoriesList.add(foodCategory);
        //     }
        //   }
        // } catch (error) {
        //   // No rows on the join table or there is any other error there.
        // }

        foodRecipe.foodCategories = foodCategoriesList;
        // Adding the FoodRecipe object with everything inside to the list:
        foodRecipesList.add(foodRecipe);
      }
    }
    return foodRecipesList;
  }

  Future<List<FoodRecipe>> byFoodCategory(FoodCategory foodCategory, {List<String> filtersList}) async {
    var dbClient = await dbHelper.dbPlus();
    List<FoodRecipe> foodRecipesList = [];
    filtersList = filtersList ?? [];
    print('filtersList: $filtersList');

    // Gathering on the join table (food_categories_food_recipes) by the food_category_id:
    Map<String, Object> foodCategoriesFoodRecipesTable = FoodCategoriesFoodRecipesData.sqliteTable;
    String foodCategoriesFoodRecipesTableName = foodCategoriesFoodRecipesTable['table_plural_name'];
    List<Map> foodCategoriesFoodRecipesTableFields = foodCategoriesFoodRecipesTable['fields'];
    List<Map> foodCategoriesFoodRecipesMaps = await dbClient.query(foodCategoriesFoodRecipesTableName, columns: foodCategoriesFoodRecipesTableFields.map<String>((field) => field['field_name']).toList(), where: 'food_category_id = ?', whereArgs: [foodCategory.id]);

    if (foodCategoriesFoodRecipesMaps.length > 0) {
      // If some association was found (If the given FoodCategory has at least one FoodRecipe)
      // Conversion into FoodCategoryFoodRecipe objects:
      List<FoodCategoryFoodRecipe> foodCategoriesFoodRecipesList = [];
      for (int j = 0; j < foodCategoriesFoodRecipesMaps.length; j++) {
        FoodCategoryFoodRecipe foodCategoryFoodRecipe;
        foodCategoryFoodRecipe = FoodCategoryFoodRecipe.fromMap(foodCategoriesFoodRecipesMaps[j]);
        // Adding the FoodCategoryFoodRecipe object to the temporal list:
        foodCategoriesFoodRecipesList.add(foodCategoryFoodRecipe);
      }

      // Gathering of the FoodRecipe Maps based on the gathered FoodCategoryFoodRecipe objects:
      List<int> foodRecipesIdsList = foodCategoriesFoodRecipesList.map((foodCategoryFoodRecipe) => foodCategoryFoodRecipe.foodRecipeId).toList();
      Map<String, Object> foodRecipesTable = FoodRecipesData.sqliteTable;
      String foodRecipesTableName = foodRecipesTable['table_plural_name'];
      List<Map> foodRecipesTableFields = foodRecipesTable['fields'];
      // String filteringString = filtersList.isEmpty ? '' : "${filtersList.map((e) => "AND '$e' = 1").join(', ')}";
      // print('filteringString: $filteringString');
      List<Map> foodRecipesMaps = await dbClient.query(foodRecipesTableName, columns: foodRecipesTableFields.map<String>((field) => field['field_name']).toList(), where: 'id IN (${foodRecipesIdsList.map((e) => "'$e'").join(', ')})');

      // Has errors yet:
      // List<Map> foodRecipesMaps = await dbClient.query(foodRecipesTableName, columns: foodRecipesTableFields.map<String>((field) => field['field_name']).toList(), where: 'id IN (${foodRecipesIdsList.map((e) => "'$e'").join(', ')})${filtersList.isEmpty ? "" : " AND ${filtersList.map((e) => "'$e' = 1").join(', ')}"}');
      // Conversion into FoodRecipe objects:
      if (foodRecipesMaps.length > 0) {
        for (int i = 0; i < foodRecipesMaps.length; i++) {
          FoodRecipe foodRecipe = FoodRecipe.fromMap(foodRecipesMaps[i]);
          foodRecipesList.add(foodRecipe);
        }
      }

      // If a filtersList was provided:
      if (filtersList.isNotEmpty) {
        filtersList.forEach((filter) {
          print(filter);
          switch (filter) {
            case 'isGlutenFree':
              // foodRecipesList = foodRecipesList.where((foodRecipe) => foodRecipe.isGlutenFree == true).toList();
              foodRecipesList.removeWhere((foodRecipe) => foodRecipe.isGlutenFree == false);
              break;
            case 'isVegan':
              // foodRecipesList = foodRecipesList.where((foodRecipe) => foodRecipe.isVegan == true).toList();
              foodRecipesList.removeWhere((foodRecipe) => foodRecipe.isVegan == false);
              break;
            case 'isVegetarian':
              // foodRecipesList = foodRecipesList.where((foodRecipe) => foodRecipe.isVegetarian == true).toList();
              foodRecipesList.removeWhere((foodRecipe) => foodRecipe.isVegetarian == false);
              break;
            case 'isLactoseFree':
              // foodRecipesList = foodRecipesList.where((foodRecipe) => foodRecipe.isLactoseFree == true).toList();
              foodRecipesList.removeWhere((foodRecipe) => foodRecipe.isLactoseFree == false);
              break;
          }
        });

        // foodRecipesList = foodRecipesList.map((foodRecipe) {
        //   return foodRecipe; //... finish this
        // }).toList();
      }
    }
    return foodRecipesList;
  }

  Future<int> _destroy(int id, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    return await dbClient.delete(table['table_plural_name'], where: 'id = ?', whereArgs: [id]);
  }

  Future<int> _update(FoodRecipe foodCategory, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    return await dbClient.update(table['table_plural_name'], foodCategory.toMap(), where: 'id = ?', whereArgs: [foodCategory.id]);
  }

  // Private methods:
  void _generateDummyData() async {
    // final List<FoodCategory> foodCategories = await _index(sqliteTable);
    // final int currentLength = foodCategories.length;
    // if (currentLength < _maxAmountDummyData) {
    //   for (int i = 0; i < (_maxAmountDummyData - currentLength); i++) {
    //     String title = faker.food.dish();
    //     // Color color = ColorHelper.randomColor();
    //     Color color = ColorHelper.randomMaterialColor();
    //     await addFoodRecipe(title, color);
    //   }
    // }
  }

  void generateDummyDataByFoodCategoryId(int foodCategoryId, int amount) async {
    FoodCategoriesFoodRecipesData foodCategoriesFoodRecipesData = FoodCategoriesFoodRecipesData();
    FoodIngredientsData foodIngredientsData = FoodIngredientsData();
    RecipeStepsData recipeStepsData = RecipeStepsData();

    for (int j = 0; j < amount; j++) {
      try {
        FoodRecipe foodRecipe = await addFoodRecipe(
          title: faker.food.dish(),
          imageUrl: ListHelper.randomFromList(DUMMY_FOOD_IMAGE_URLS),
          duration: NumericHelper.randomIntegerInRange(min: 20, max: 45),
          complexity: Complexity.simple,
          affordability: Affordability.affordable,
          isGlutenFree: false,
          isLactoseFree: false,
          isVegan: false,
          isVegetarian: false,
        );
        // FoodCategoriesFoodRecipe objects to keep consistency (relations between tables) on the DB containing the dummy data:
        await foodCategoriesFoodRecipesData.addFoodCategoryFoodRecipe(foodCategoryId, foodRecipe.id);
        // FoodIngredient objects as dummy data:
        await foodIngredientsData.generateDummyDataByFoodRecipeId(foodRecipe.id, 12);
        // RecipeStep objects as dummy data:
        await recipeStepsData.generateDummyDataByFoodRecipeId(foodRecipe.id, 12);
      } catch (error) {
        print(error);
      }
    }
  }

  void _removeWhere(int id) async {
    await _destroy(id, sqliteTable);
    // TODO: Add destruction of all the FoodCategoryFoodRecipe objects with matching food_recipe_id
    await refresh();
  }

  // Public methods:
  Future refresh() async {
    try {
      _foodRecipes = await _index(sqliteTable);
    } catch (error) {}
    notifyListeners();
  }

  Future<FoodRecipe> addFoodRecipe({
    String title,
    List<FoodCategory> foodCategories,
    String imageUrl,
    List<FoodIngredient> foodIngredients,
    List<RecipeStep> recipeSteps,
    int duration,
    Complexity complexity,
    Affordability affordability,
    bool isGlutenFree,
    bool isLactoseFree,
    bool isVegan,
    bool isVegetarian,
  }) async {
    DateTime now = DateTime.now();

    // TODO: Check that this is fine
    FoodRecipe newRecipe = FoodRecipe(
      title: title,
      imageUrl: imageUrl,
      duration: duration,
      complexity: complexity,
      affordability: affordability,
      isGlutenFree: isGlutenFree,
      isLactoseFree: isLactoseFree,
      isVegan: isVegan,
      isVegetarian: isVegetarian,
      createdAt: now,
      updatedAt: now,
    );
    FoodRecipe foodRecipe = await _create(newRecipe, sqliteTable);
    refresh();
    return foodRecipe;
  }

  Future<void> updateFoodRecipe(
    int id,
    String title,
    // List<FoodCategory> foodCategories,
    String imageUrl,
    // List<FoodIngredient> foodIngredients,
    // List<RecipeStep> recipeSteps,
    int duration,
    Complexity complexity,
    Affordability affordability,
    bool isGlutenFree,
    bool isLactoseFree,
    bool isVegan,
    bool isVegetarian,
  ) async {
    DateTime now = DateTime.now();
    FoodRecipe updatingFoodRecipe = _foodRecipes.firstWhere((foodRecipe) => id == foodRecipe.id);

    updatingFoodRecipe.title = title;
    updatingFoodRecipe.imageUrl = imageUrl;
    updatingFoodRecipe.duration = duration;
    updatingFoodRecipe.complexity = complexity;
    updatingFoodRecipe.affordability = affordability;
    updatingFoodRecipe.isGlutenFree = isGlutenFree;
    updatingFoodRecipe.isLactoseFree = isLactoseFree;
    updatingFoodRecipe.isVegan = isVegan;
    updatingFoodRecipe.isVegetarian = isVegetarian;
    updatingFoodRecipe.updatedAt = now;

    await _update(updatingFoodRecipe, sqliteTable);
    refresh();
  }

  Future<void> deleteFoodRecipeWithConfirm(int id, BuildContext context) {
    DialogHelper.showDialogPlus(id, context, () => _removeWhere(id)).then((value) {
      // This commenting, fixes an exception when deleting
      // (context as Element).reassemble();
      refresh();
    });
  }

  void deleteFoodRecipeWithoutConfirm(int id) {
    _removeWhere(id);
    // refresh();
  }
}
