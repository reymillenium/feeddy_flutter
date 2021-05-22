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
    print('Inside dbPlus');
    if (_db != null) {
      return _db;
    }
    _db = await initDbPlus();
    return _db;
  }

  // Future<Database> dbManyToManyTablePlus(Map<String, dynamic> tableC, Map<String, dynamic> tableA, Map<String, dynamic> tableB) async {
  //   if (_db != null) {
  //     return _db;
  //   }
  //   _db = await initDbManyToManyTablePlus(tableC, tableA, tableB);
  //   return _db;
  // }

  initDbPlus() async {
    print('Inside initDbPlus');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    // deleteDatabase(path);
    // var db = await openDatabase(path, version: 1, onCreate: (Database db, int version) => _onCreatePlus(db, version));
    var db = await openDatabase(path, version: 1, onCreate: _onCreatePlus);
    return db;
  }

  // initDbManyToManyTablePlus(Map<String, dynamic> tableC, Map<String, dynamic> tableA, Map<String, dynamic> tableB) async {
  //   Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   String path = join(documentsDirectory.path, DB_NAME);
  //   // deleteDatabase(path);
  //   var db = await openDatabase(path, version: 1, onCreate: (Database db, int version) => _onCreateManyToManyTablePlus(db, version, tableC, tableA, tableB));
  //   return db;
  // }

  _onCreatePlus(Database db, int version) async {
    print('Inside _onCreatePlus');
    // food_categories table:
    Map<String, Object> foodCategoriesTable = FoodCategoriesData.sqliteTable;
    List<Map> fields = foodCategoriesTable['fields'];
    String tableFieldsString = '';
    fields.forEach((field) {
      // tableFieldsString += "${field['field_name'] == 'id' ? '' : ', '}${field['field_name']} ${field['field_name'] == 'id' ? 'PRIMARY KEY' : ''}${field['field_type']}";
      String fieldName = field['field_name'];
      String fieldType = field['field_type'];
      tableFieldsString += "${fieldName == 'id' ? 'id INTEGER PRIMARY KEY' : ', '}${fieldName == 'id' ? '' : '$fieldName $fieldType'}";
    });
    print('Inside _onCreatePlus Before creating the foodCategoriesTable');
    print("CREATE TABLE IF NOT EXISTS ${foodCategoriesTable['table_plural_name']} ($tableFieldsString)");
    await db.execute("CREATE TABLE IF NOT EXISTS ${foodCategoriesTable['table_plural_name']} ($tableFieldsString)");

    // food_recipes table:
    Map<String, Object> foodRecipesTable = FoodRecipesData.sqliteTable;
    List<Map> foodRecipesFields = foodRecipesTable['fields'];
    String foodRecipesTableFieldsString = '';
    foodRecipesFields.forEach((foodRecipesField) {
      // foodRecipesTableFieldsString += "${foodRecipesField['field_name'] == 'id' ? '' : ', '}${foodRecipesField['field_name']} ${foodRecipesField['field_name'] == 'id' ? 'PRIMARY KEY' : ''} ${foodRecipesField['field_type']}";
      String fieldName = foodRecipesField['field_name'];
      String fieldType = foodRecipesField['field_type'];
      foodRecipesTableFieldsString += "${fieldName == 'id' ? 'id INTEGER PRIMARY KEY' : ', '}${fieldName == 'id' ? '' : '$fieldName $fieldType'}";
    });
    print("CREATE TABLE IF NOT EXISTS ${foodRecipesTable['table_plural_name']} ($foodRecipesTableFieldsString)");
    await db.execute("CREATE TABLE IF NOT EXISTS ${foodRecipesTable['table_plural_name']} ($foodRecipesTableFieldsString)");

    // food_categories_food_recipes table:
    Map<String, Object> foodCategoriesFoodRecipesTable = FoodCategoriesFoodRecipesData.sqliteTable;
    await _onCreateManyToManyTablePlus(db, 1, foodCategoriesFoodRecipesTable, foodCategoriesTable, foodRecipesTable);
  }

  _onCreateManyToManyTablePlus(Database db, int version, Map<String, dynamic> tableC, Map<String, dynamic> tableA, Map<String, dynamic> tableB) async {
    print('I am here inside _onCreateManyToManyTablePlus');
    await db.execute("""
            CREATE TABLE IF NOT EXISTS ${tableC['table_plural_name']} (
              id INTEGER PRIMARY KEY, 
              ${tableA['table_singular_name']}_id INTEGER NOT NULL,
              ${tableB['table_singular_name']}_id INTEGER NOT NULL,
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
