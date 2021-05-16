// Packages:

import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Models:
import 'package:feeddy_flutter/models/transaction.dart';

// Helpers:

// Utilities:

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String TITLE = 'title';
  static const String AMOUNT = 'amount';
  static const String EXECUTION_DATE = 'executionDate';
  static const String CREATED_AT = 'createdAt';
  static const String UPDATED_AT = 'updatedAt';

  static const String TABLE = 'transactions';
  static const String DB_NAME = 'expensy.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    // deleteDatabase(path);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $TITLE TEXT, $AMOUNT REAL, $EXECUTION_DATE TEXT, $CREATED_AT TEXT, $UPDATED_AT TEXT)");
    // await db.execute("CREATE TABLE IF NOT EXISTS $TABLE ($ID INTEGER PRIMARY KEY, $TITLE TEXT, $AMOUNT REAL, $EXECUTION_DATE TEXT, $CREATED_AT TEXT, $UPDATED_AT TEXT)");
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

  // MonetaryTransaction Model Related:
  Future<MonetaryTransaction> saveTransaction(MonetaryTransaction transaction) async {
    var dbClient = await db;
    // transaction.id = await dbClient.insert(TABLE, transaction.toMap());
    transaction.id = await dbClient.insert(TABLE, {
      ID: transaction.id,
      TITLE: transaction.title,
      AMOUNT: transaction.amount,
      EXECUTION_DATE: transaction.executionDate.toString(),
      CREATED_AT: transaction.createdAt.toString(),
      UPDATED_AT: transaction.updatedAt.toString(),
    });
    return transaction;

    // await dbClient.transaction((txn) async {
    //   var query = "INSERT INTO $TABLE ($TITLE) VALUES ('" + transaction.title + "')";
    //   return await txn.rawInsert(query);
    // });
  }

  Future<List<MonetaryTransaction>> getMonetaryTransactions() async {
    var dbClient = await db;

    List<Map> monetaryTransactionMaps = await dbClient.query(TABLE, columns: [ID, TITLE, AMOUNT, EXECUTION_DATE, CREATED_AT, UPDATED_AT]);
    //List<Map> monetaryTransactionMaps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<MonetaryTransaction> monetaryTransactions = [];
    if (monetaryTransactionMaps.length > 0) {
      for (int i = 0; i < monetaryTransactionMaps.length; i++) {
        monetaryTransactions.add(MonetaryTransaction.fromMap(monetaryTransactionMaps[i]));
      }
    }
    return monetaryTransactions;
  }

  Future<int> deleteTransaction(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> updateTransaction(MonetaryTransaction monetaryTransaction) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, monetaryTransaction.toMap(), where: '$ID = ?', whereArgs: [monetaryTransaction.id]);
  }
}
