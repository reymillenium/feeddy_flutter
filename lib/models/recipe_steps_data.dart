// Packages:

import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Screens:

// Models:
import 'package:feeddy_flutter/models/_models.dart';

// Components:
import 'package:feeddy_flutter/components/_components.dart';

// Helpers:
import 'package:feeddy_flutter/helpers/_helpers.dart';

// Utilities:
import 'package:feeddy_flutter/utilities/_utilities.dart';

class RecipeStepsData with ChangeNotifier {
  // Properties:
  static const sqliteTable = {
    'table_plural_name': 'recipe_steps',
    'table_singular_name': 'recipe_step',
    'fields': [
      {
        'field_name': 'id',
        'field_type': 'INTEGER',
      },
      {
        'field_name': 'description',
        'field_type': 'TEXT',
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
  List<RecipeStep> _recipeSteps = [];
  DBHelper dbHelper;

  // Constructor:
  RecipeStepsData() {
    dbHelper = DBHelper();
    refresh();
    // _generateDummyData();
  }

  get recipeSteps {
    return _recipeSteps;
  }

  // SQLite DB CRUD:
  Future<RecipeStep> _create(RecipeStep recipeStep, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    recipeStep.id = await dbClient.insert(table['table_plural_name'], recipeStep.toMap());
    return recipeStep;
  }

  Future<List<dynamic>> _index(Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    List<Map> tableFields = table['fields'];
    List<Map> recipeStepsMaps = await dbClient.query(table['table_plural_name'], columns: tableFields.map<String>((field) => field['field_name']).toList());

    List<RecipeStep> recipeStepsList = [];
    if (recipeStepsMaps.length > 0) {
      for (int i = 0; i < recipeStepsMaps.length; i++) {
        RecipeStep recipeStep;
        recipeStep = RecipeStep.fromMap(recipeStepsMaps[i]);
        // Adding the FoodIngredient object to the list:
        recipeStepsList.add(recipeStep);
      }
    }
    return recipeStepsList;
  }

  Future<List<RecipeStep>> byFoodRecipe(FoodRecipe foodRecipe) async {
    var dbClient = await dbHelper.dbPlus();
    List<RecipeStep> recipeStepsList = [];

    Map<String, Object> recipeStepsTable = RecipeStepsData.sqliteTable;
    String recipeStepsTableName = recipeStepsTable['table_plural_name'];
    List<Map> recipeStepsTableFields = recipeStepsTable['fields'];
    List<Map> recipeStepsMaps = await dbClient.query(recipeStepsTableName, columns: recipeStepsTableFields.map<String>((field) => field['field_name']).toList(), where: 'food_recipe_id = ?', whereArgs: [foodRecipe.id]);

    // Conversion into RecipeStep objects:
    if (recipeStepsMaps.length > 0) {
      for (int i = 0; i < recipeStepsMaps.length; i++) {
        RecipeStep recipeStep = RecipeStep.fromMap(recipeStepsMaps[i]);
        recipeStepsList.add(recipeStep);
      }
    }
    return recipeStepsList;
  }

  Future<int> _destroy(int id, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    return await dbClient.delete(table['table_plural_name'], where: 'id = ?', whereArgs: [id]);
  }

  Future<int> _update(RecipeStep recipeStep, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    return await dbClient.update(table['table_plural_name'], recipeStep.toMap(), where: 'id = ?', whereArgs: [recipeStep.id]);
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

  Future<void> generateDummyDataByFoodRecipeId(int foodRecipeId, int amount) async {
    for (int j = 0; j < amount; j++) {
      try {
        RecipeStep recipeStep = await addRecipeStep(
          description: faker.lorem.sentence(),
          foodRecipeId: foodRecipeId,
        );
      } catch (error) {
        print(error);
      }
    }
  }

  void _removeWhere(int id) async {
    await _destroy(id, sqliteTable);
    await refresh();
  }

  // Public methods:
  Future refresh() async {
    try {
      _recipeSteps = await _index(sqliteTable);
    } catch (error) {}
    notifyListeners();
  }

  Future<RecipeStep> addRecipeStep({
    String description,
    int foodRecipeId,
  }) async {
    DateTime now = DateTime.now();

    RecipeStep newRecipeStep = RecipeStep(
      description: description,
      foodRecipeId: foodRecipeId,
      createdAt: now,
      updatedAt: now,
    );
    RecipeStep recipeStep = await _create(newRecipeStep, sqliteTable);
    refresh();
    return recipeStep;
  }

  Future<void> updateRecipeStep(
    int id,
    String description,
  ) async {
    DateTime now = DateTime.now();
    RecipeStep updatingRecipeStep = _recipeSteps.firstWhere((recipeStep) => id == recipeStep.id);

    updatingRecipeStep.description = description;
    updatingRecipeStep.updatedAt = now;

    await _update(updatingRecipeStep, sqliteTable);
    refresh();
  }

  Future<void> deleteRecipeStepWithConfirm(int id, BuildContext context) {
    DialogHelper.showDialogPlus(id, context, () => _removeWhere(id)).then((value) {
      (context as Element).reassemble();
      refresh();
    });
  }

  void deleteRecipeStepWithoutConfirm(int id) {
    _removeWhere(id);
    // refresh();
  }
}
