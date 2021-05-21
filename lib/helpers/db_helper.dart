// Packages:

import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Models:

// Helpers:

// Utilities:

class DBHelper {
  static Database _db;
  static const String DB_NAME = 'expensy.db';

  Future<Database> dbPlus(Map<String, dynamic> table) async {
    if (_db != null) {
      return _db;
    }
    _db = await initDbPlus(table);
    return _db;
  }

  Future<Database> dbManyToManyTablePlus(Map<String, dynamic> tableC, Map<String, dynamic> tableA, Map<String, dynamic> tableB) async {
    if (_db != null) {
      return _db;
    }
    _db = await initDbManyToManyTablePlus(tableC, tableA, tableB);
    return _db;
  }

  initDbPlus(Map<String, dynamic> table) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    // deleteDatabase(path);
    var db = await openDatabase(path, version: 1, onCreate: (Database db, int version) => _onCreatePlus(db, version, table));
    return db;
  }

  initDbManyToManyTablePlus(Map<String, dynamic> tableC, Map<String, dynamic> tableA, Map<String, dynamic> tableB) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    // deleteDatabase(path);
    var db = await openDatabase(path, version: 1, onCreate: (Database db, int version) => _onCreateManyToManyTablePlus(db, version, tableC, tableA, tableB));
    return db;
  }

  _onCreatePlus(Database db, int version, Map<String, dynamic> table) async {
    List<Map> fields = table['fields'];
    String tableFieldsString = '';
    fields.forEach((field) {
      tableFieldsString += "${field['field_name'] == 'id' ? '' : ', '}${field['field_name']} ${field['field_name'] == 'id' ? 'PRIMARY KEY' : ''} ${field['field_type']}";
    });
    await db.execute("CREATE TABLE IF NOT EXISTS ${table['table_plural_name']} ($tableFieldsString)");
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

  Future closePlus(Map<String, dynamic> table) async {
    var dbClient = await dbPlus(table);
    dbClient.close();
  }
}
