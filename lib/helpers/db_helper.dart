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

  initDbPlus(Map<String, dynamic> table) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    // deleteDatabase(path);
    var db = await openDatabase(path, version: 1, onCreate: (Database db, int version) => _onCreatePlus(db, version, table));
    return db;
  }

  _onCreatePlus(Database db, int version, Map<String, dynamic> table) async {
    List<Map> fields = table['fields'];
    String tableFieldsString = '';
    fields.forEach((field) {
      tableFieldsString += "${field['name'] == 'id' ? '' : ', '}${field['name']} ${field['name'] == 'id' ? 'PRIMARY KEY' : ''} ${field['type']}";
    });
    await db.execute("CREATE TABLE IF NOT EXISTS ${table['name']} ($tableFieldsString)");
  }

  Future closePlus(Map<String, dynamic> table) async {
    var dbClient = await dbPlus(table);
    dbClient.close();
  }
}
