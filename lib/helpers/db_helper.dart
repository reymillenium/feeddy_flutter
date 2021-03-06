// Packages:

import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Models:
import 'package:feeddy_flutter/models/_models.dart';

// Helpers:

// Utilities:

class DBHelper {
  static Database _db;
  static const String DB_NAME = 'expensy.db';

  Future<Database> dbPlus() async {
    if (_db != null) {
      return _db;
    }
    _db = await initDbPlus();
    return _db;
  }

  initDbPlus() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    // deleteDatabase(path);
    // var db = await openDatabase(path, version: 1, onCreate: (Database db, int version) => _onCreatePlus(db, version));
    var db = await openDatabase(path, version: 1, onCreate: _onCreatePlus);
    return db;
  }

  deleteDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    deleteDatabase(path);
  }

  _onCreatePlus(Database db, int version) async {
    // food_categories table:
    Map<String, Object> foodCategoriesTable = FoodCategoriesData.sqliteTable;
    await _createTable(db, 1, foodCategoriesTable);

    // food_recipes table:
    Map<String, Object> foodRecipesTable = FoodRecipesData.sqliteTable;
    await _createTable(db, 1, foodRecipesTable);

    // food_categories_food_recipes table:
    Map<String, Object> foodCategoriesFoodRecipesTable = FoodCategoriesFoodRecipesData.sqliteTable;
    await _onCreateManyToManyTablePlus(db, 1, foodCategoriesFoodRecipesTable, foodCategoriesTable, foodRecipesTable);

    // food_ingredients table:
    Map<String, Object> foodIngredientsTable = FoodIngredientsData.sqliteTable;
    await _createTable(db, 1, foodIngredientsTable);

    // recipe_steps table:
    Map<String, Object> recipeStepsTable = RecipeStepsData.sqliteTable;
    await _createTable(db, 1, recipeStepsTable);

    // recipe_steps table:
    Map<String, Object> favoriteFoodRecipesTable = FavoriteFoodRecipesData.sqliteTable;
    await _createTable(db, 1, favoriteFoodRecipesTable);
  }

  _createTable(Database db, int version, Map<String, dynamic> table) async {
    String tableName = table['table_plural_name'];
    List<Map> fields = table['fields'];
    String tableFieldsString = '';
    fields.forEach((field) {
      String fieldName = field['field_name'];
      String fieldType = field['field_type'];
      tableFieldsString += "${fieldName == 'id' ? 'id INTEGER PRIMARY KEY' : ', '}${fieldName == 'id' ? '' : '$fieldName $fieldType'}";
    });
    String finalSQLSentence = "CREATE TABLE IF NOT EXISTS $tableName ($tableFieldsString)";
    await db.execute(finalSQLSentence);
  }

  _onCreateManyToManyTablePlus(Database db, int version, Map<String, dynamic> tableC, Map<String, dynamic> tableA, Map<String, dynamic> tableB) async {
    await db.execute("""
            CREATE TABLE IF NOT EXISTS ${tableC['table_plural_name']} (
              id INTEGER PRIMARY KEY, 
              ${tableA['table_singular_name']}_id INTEGER NOT NULL,
              ${tableB['table_singular_name']}_id INTEGER NOT NULL,
              createdAt TEXT,
              updatedAt TEXT,
              FOREIGN KEY (${tableA['table_singular_name']}_id) REFERENCES ${tableA['table_plural_name']} (id) 
                ON DELETE NO ACTION ON UPDATE NO ACTION,
              FOREIGN KEY (${tableB['table_singular_name']}_id) REFERENCES ${tableB['table_plural_name']} (id) 
                ON DELETE NO ACTION ON UPDATE NO ACTION
            )""");
  }

  Future closePlus() async {
    var dbClient = await dbPlus();
    dbClient.close();
  }
}
