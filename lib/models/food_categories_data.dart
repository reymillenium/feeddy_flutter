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
  final int _maxAmountDummyData = 3;
  List<FoodCategory> _foodCategories = [];
  DBHelper dbHelper;

  // Constructor:
  FoodCategoriesData() {
    dbHelper = DBHelper();
    refresh();
    _generateDummyData();
  }

  // Getters:
  get foodCategories {
    return _foodCategories;
  }

  // SQLite DB CRUD:
  Future<FoodCategory> _save(FoodCategory foodCategory, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus(table);
    foodCategory.id = await dbClient.insert(table['name'], foodCategory.toMap());
    return foodCategory;
  }

  Future<List<dynamic>> _load(Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus(table);
    List<Map> fields = table['fields'];
    List<Map> objectMaps = await dbClient.query(table['name'], columns: fields.map<String>((field) => field['name']).toList());
    //List<Map> objectMaps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<FoodCategory> objectsList = [];
    if (objectMaps.length > 0) {
      for (int i = 0; i < objectMaps.length; i++) {
        objectsList.add(FoodCategory.fromMap(objectMaps[i]));
      }
    }
    return objectsList;
  }

  Future<int> _delete(int id, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus(table);
    return await dbClient.delete(table['name'], where: 'id = ?', whereArgs: [id]);
  }

  Future<int> _update(FoodCategory foodCategory, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus(table);
    return await dbClient.update(table['name'], foodCategory.toMap(), where: 'id = ?', whereArgs: [foodCategory.id]);
  }

  // Private methods:
  void _generateDummyData() async {
    final List<FoodCategory> foodCategories = await _load(_sqliteTable);
    final int currentLength = foodCategories.length;
    if (currentLength < _maxAmountDummyData) {
      for (int i = 0; i < (_maxAmountDummyData - currentLength); i++) {
        String title = faker.food.dish();
        Color color = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
        await addFoodCategory(title, color);
      }
    }
  }

  void _removeWhere(int id) async {
    await _delete(id, _sqliteTable);
    await refresh();
  }

  // Public methods:
  Future refresh() async {
    _foodCategories = await _load(_sqliteTable);
    notifyListeners();
  }

  Future<void> addFoodCategory(String title, Color color) async {
    DateTime now = DateTime.now();
    FoodCategory newFoodCategory = FoodCategory(
      title: title,
      color: color,
      createdAt: now,
      updatedAt: now,
    );
    await _save(newFoodCategory, _sqliteTable);
    refresh();
  }

  Future<void> updateFoodCategory(int id, String title, Color color) async {
    DateTime now = DateTime.now();
    FoodCategory updatingFoodCategory = _foodCategories.firstWhere((foodCategory) => id == foodCategory.id);

    updatingFoodCategory.title = title;
    updatingFoodCategory.color = color;
    updatingFoodCategory.updatedAt = now;

    await _update(updatingFoodCategory, _sqliteTable);
    refresh();
  }

  Future<void> deleteFoodCategoryWithConfirm(int id, BuildContext context) {
    DialogHelper.showDialogPlus(id, context, () => _removeWhere(id)).then((value) {
      (context as Element).reassemble();
      refresh();
    });
  }

  void deleteFoodCategoryWithoutConfirm(int id) {
    _removeWhere(id);
    // refresh();
  }
}
