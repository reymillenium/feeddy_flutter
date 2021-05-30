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

class FoodIngredientsData with ChangeNotifier {
  // Properties:
  static const sqliteTable = {
    'table_plural_name': 'food_ingredients',
    'table_singular_name': 'food_ingredient',
    'fields': [
      {
        'field_name': 'id',
        'field_type': 'INTEGER',
      },
      {
        'field_name': 'name',
        'field_type': 'TEXT',
      },
      {
        'field_name': 'amount',
        'field_type': 'INTEGER',
      },
      {
        'field_name': 'measurement_unit',
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
  List<FoodIngredient> _foodIngredients = [];
  DBHelper dbHelper;

  // Constructor:
  FoodIngredientsData() {
    dbHelper = DBHelper();
    refresh();
    // _generateDummyData();
  }

  get foodIngredients {
    return _foodIngredients;
  }

  // SQLite DB CRUD:
  Future<FoodIngredient> _create(FoodIngredient foodIngredient, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    foodIngredient.id = await dbClient.insert(table['table_plural_name'], foodIngredient.toMap());
    return foodIngredient;
  }

  Future<List<dynamic>> _index(Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    List<Map> tableFields = table['fields'];
    List<Map> foodIngredientsMaps = await dbClient.query(table['table_plural_name'], columns: tableFields.map<String>((field) => field['field_name']).toList());

    List<FoodIngredient> foodIngredientsList = [];
    if (foodIngredientsMaps.length > 0) {
      for (int i = 0; i < foodIngredientsMaps.length; i++) {
        FoodIngredient foodIngredient;
        foodIngredient = FoodIngredient.fromMap(foodIngredientsMaps[i]);
        // Adding the FoodIngredient object to the list:
        foodIngredientsList.add(foodIngredient);
      }
    }
    return foodIngredientsList;
  }

  Future<List<FoodIngredient>> byFoodRecipe(FoodRecipe foodRecipe) async {
    var dbClient = await dbHelper.dbPlus();
    List<FoodIngredient> foodIngredientsList = [];

    Map<String, Object> foodIngredientsTable = FoodIngredientsData.sqliteTable;
    String foodIngredientsTableName = foodIngredientsTable['table_plural_name'];
    List<Map> foodIngredientsTableFields = foodIngredientsTable['fields'];
    List<Map> foodIngredientsMaps = await dbClient.query(foodIngredientsTableName, columns: foodIngredientsTableFields.map<String>((field) => field['field_name']).toList(), where: 'food_recipe_id = ?', whereArgs: [foodRecipe.id]);

    // Conversion into FoodIngredient objects:
    if (foodIngredientsMaps.length > 0) {
      for (int i = 0; i < foodIngredientsMaps.length; i++) {
        FoodIngredient foodIngredient = FoodIngredient.fromMap(foodIngredientsMaps[i]);
        foodIngredientsList.add(foodIngredient);
      }
    }
    return foodIngredientsList;
  }

  Future<int> _destroy(int id, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    return await dbClient.delete(table['table_plural_name'], where: 'id = ?', whereArgs: [id]);
  }

  Future<int> _update(FoodIngredient foodIngredient, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus();
    return await dbClient.update(table['table_plural_name'], foodIngredient.toMap(), where: 'id = ?', whereArgs: [foodIngredient.id]);
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
        FoodIngredient foodIngredient = await addFoodIngredient(
          name: faker.lorem.word(),
          amount: NumericHelper.randomDoubleInRange(min: 1, max: 10),
          foodRecipeId: foodRecipeId,
          // measurementUnit: EnumToString.fromString(MeasurementUnit.values, ListHelper.randomFromList(EnumToString.toList(MeasurementUnit.values))),
          measurementUnit: ListHelper.randomFromList(MeasurementUnit.values),
        );
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
      _foodIngredients = await _index(sqliteTable);
    } catch (error) {}
    notifyListeners();
  }

  Future<FoodIngredient> addFoodIngredient({
    String name,
    double amount,
    MeasurementUnit measurementUnit,
    int foodRecipeId,
  }) async {
    DateTime now = DateTime.now();

    // TODO: Check that this is fine
    FoodIngredient newIngredient = FoodIngredient(
      name: name,
      amount: amount,
      measurementUnit: measurementUnit,
      foodRecipeId: foodRecipeId,
      createdAt: now,
      updatedAt: now,
    );
    FoodIngredient foodIngredient = await _create(newIngredient, sqliteTable);
    refresh();
    return foodIngredient;
  }

  Future<void> updateFoodIngredient(
    int id,
    String name,
    double amount,
    MeasurementUnit measurementUnit,
    int foodRecipeId,
  ) async {
    DateTime now = DateTime.now();
    FoodIngredient updatingFoodIngredient = _foodIngredients.firstWhere((foodIngredient) => id == foodIngredient.id);

    updatingFoodIngredient.name = name;
    updatingFoodIngredient.amount = amount;
    updatingFoodIngredient.measurementUnit = measurementUnit;
    updatingFoodIngredient.updatedAt = now;

    await _update(updatingFoodIngredient, sqliteTable);
    refresh();
  }

  Future<void> deleteFoodIngredientWithConfirm(int id, BuildContext context) {
    DialogHelper.showDialogPlus(id, context, () => _removeWhere(id)).then((value) {
      (context as Element).reassemble();
      refresh();
    });
  }

  void deleteFoodIngredientWithoutConfirm(int id) {
    _removeWhere(id);
    // refresh();
  }
}
