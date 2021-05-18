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
  final _sqliteTable = {
    'name': 'food_categories',
    'fields': [
      {
        'name': 'id',
        'type': 'INTEGER',
      },
      {
        'name': 'title',
        'type': 'TEXT',
      },
      {
        'name': 'color',
        'type': 'TEXT',
      },
      {
        'name': 'createdAt',
        'type': 'TEXT',
      },
      {
        'name': 'updatedAt',
        'type': 'TEXT',
      },
    ],
  };
  final int _maxAmountDummyData = 32;
  List<FoodCategory> _foodCategories = [];
  DBHelper dbHelper;

  // Constructor:
  FoodCategoriesData() {
    dbHelper = DBHelper();
    refresh();
    // _generateDummyData();
    // List<Map<String, dynamic>> test = _sqliteTable['fields'].map((field) => field['name']).toList();
    // List<Map<String, dynamic>> fields = _sqliteTable['fields'];
    // List<dynamic> test = fields.map((field) => field['name']).toList();
    // print(test);
  }

  // SQLite Basic

  Future<FoodCategory> save(FoodCategory foodCategory, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus(table);
    foodCategory.id = await dbClient.insert(table['name'], foodCategory.toMap());
    print(table['name']);
    print('on save foodCategory.id = ${foodCategory.id}');
    print(foodCategory.toMap());
    return foodCategory;
  }

  Future<List<dynamic>> load(Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus(table);
    List<Map> fields = table['fields'];

    // List<Map> objectMaps = await dbClient.query(table['name'], columns: table['fields'].map((field) => field['name']).toList());
    List<Map> objectMaps = await dbClient.query(table['name'], columns: fields.map<String>((field) => field['name']).toList());
    //List<Map> monetaryTransactionMaps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<FoodCategory> objectsList = [];
    if (objectMaps.length > 0) {
      for (int i = 0; i < objectMaps.length; i++) {
        objectsList.add(FoodCategory.fromMap(objectMaps[i]));
      }
    }
    return objectsList;
  }

  Future<int> delete(int id, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus(table);
    return await dbClient.delete(table['name'], where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(FoodCategory foodCategory, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus(table);
    return await dbClient.update(table['name'], foodCategory.toMap(), where: 'id = ?', whereArgs: [foodCategory.id]);
  }

  Future refresh() async {
    _foodCategories = await load(_sqliteTable);
    notifyListeners();
  }

  // Getters:
  get foodCategories {
    return _foodCategories;
  }

  // Private methods:
  void _generateDummyData() async {
    // final List<MonetaryTransaction> monetaryTransactions = await dbHelper.getMonetaryTransactions();
    // final int currentLength = monetaryTransactions.length;
    // if (currentLength < _maxAmountDummyData) {
    //   for (int i = 0; i < (_maxAmountDummyData - currentLength); i++) {
    //     String title = faker.food.dish();
    //     double amount = NumericHelper.roundRandomDoubleInRange(min: 0.99, max: 10.00, places: 2);
    //     DateTime executionDate = DateHelper.randomDateTimeOnTheLastWeek();
    //     await addTransaction(title, amount, executionDate);
    //   }
    // }
  }

  void _removeWhere(int id) async {
    // _transactions.removeWhere((element) => element.id == id);
    await delete(id, _sqliteTable);
    await refresh();
  }

  // Future<void> _showDialogPlus(int id, BuildContext context) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // The user must tap the buttons!
  //     // barrierColor: Colors.transparent, // The background color
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Are you sure?'),
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
  //
  //         content: SingleChildScrollView(
  //           child: Container(
  //             padding: EdgeInsets.all(12),
  //             // height: 100,
  //             child: Column(
  //               children: <Widget>[
  //                 Text(
  //                   'This action is irreversible.',
  //                   style: TextStyle(
  //                     color: Theme.of(context).errorColor,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 // Text('Would you like to confirm this message?'),
  //               ],
  //             ),
  //           ),
  //         ),
  //         actions: <Widget>[
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: ElevatedButton(
  //               child: Row(
  //                 children: [
  //                   Text('Confirm'),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   Icon(Icons.delete),
  //                 ],
  //               ),
  //               onPressed: () {
  //                 deleteFoodCategoryWithoutConfirm(id);
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: ElevatedButton(
  //               child: Row(
  //                 children: [
  //                   Text('Cancel'),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   Icon(Icons.cancel),
  //                 ],
  //               ),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Alert createAlert({int id, BuildContext context, String message = ''}) {
  //   return Alert(
  //     context: context,
  //     type: AlertType.warning,
  //     title: "Are you sure?",
  //     // desc: message,
  //     buttons: [
  //       DialogButton(
  //         child: Text(
  //           "OK",
  //           style: TextStyle(color: Colors.white, fontSize: 20),
  //         ),
  //         onPressed: () {
  //           _removeWhere(id);
  //           Navigator.of(context).pop();
  //         },
  //         width: 120,
  //       ),
  //       DialogButton(
  //         child: Text(
  //           "CANCEL",
  //           style: TextStyle(color: Colors.white, fontSize: 20),
  //         ),
  //         onPressed: () => Navigator.pop(context),
  //         width: 120,
  //       ),
  //     ],
  //   );
  // }

  // Public methods:
  Future<void> addFoodCategory(String title, Color color) async {
    DateTime now = DateTime.now();
    FoodCategory newFoodCategory = FoodCategory(
      title: title,
      color: color,
      createdAt: now,
      updatedAt: now,
    );
    await save(newFoodCategory, _sqliteTable);
    refresh();
  }

  Future<void> updateFoodCategory(int id, String title, Color color) async {
    DateTime now = DateTime.now();
    FoodCategory updatingFoodCategory = _foodCategories.firstWhere((foodCategory) => id == foodCategory.id);

    updatingFoodCategory.title = title;
    updatingFoodCategory.color = color;
    updatingFoodCategory.updatedAt = now;

    await update(updatingFoodCategory, _sqliteTable);
    refresh();
  }

  Future<void> deleteFoodCategoryWithConfirm(int id, BuildContext context) {
    // _showDialogPlus(id, context).then((value) {
    DialogHelper.showDialogPlus(id, context, (id) => _removeWhere(id)).then((value) {
      (context as Element).reassemble();
      refresh();
    });
  }

  void deleteFoodCategoryWithoutConfirm(int id) {
    _removeWhere(id);
    // refresh();
  }
}
