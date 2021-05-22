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

  initDbPlus() async {
    print('Inside initDbPlus');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    // deleteDatabase(path);
    // var db = await openDatabase(path, version: 1, onCreate: (Database db, int version) => _onCreatePlus(db, version));
    var db = await openDatabase(path, version: 1, onCreate: _onCreatePlus);
    return db;
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
    print('Final sentence => $finalSQLSentence');
    await db.execute(finalSQLSentence);
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
