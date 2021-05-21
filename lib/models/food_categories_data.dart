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
    'table_plural_name': 'food_categories',
    'table_singular_name': 'food_category',
    'fields': [
      {
        'field_name': 'id',
        'field_type': 'INTEGER',
      },
      {
        'field_name': 'title',
        'field_type': 'TEXT',
      },
      {
        'field_name': 'color',
        'field_type': 'TEXT',
      },
      {
        'field_name': 'createdAt',
        'field_type': 'TEXT',
      },
      {
        'field_name': 'updatedAt',
        'field_type': 'TEXT',
      },
    ],
  };
  final int _maxAmountDummyData = 12;
  List<FoodCategory> _foodCategories = [];
  DBHelper dbHelper;

  // Constructor:
  FoodCategoriesData() {
    dbHelper = DBHelper();
    refresh();
    _generateDummyData();
  }

  // Getters:
  get sqliteTable {
    return _sqliteTable;
  }

  get foodCategories {
    return _foodCategories;
  }

  // SQLite DB CRUD:
  Future<FoodCategory> _create(FoodCategory foodCategory, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus(table);
    foodCategory.id = await dbClient.insert(table['table_plural_name'], foodCategory.toMap());
    return foodCategory;
  }

  Future<List<dynamic>> _index(Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus(table);
    List<Map> fields = table['fields'];
    List<Map> objectMaps = await dbClient.query(table['table_plural_name'], columns: fields.map<String>((field) => field['field_name']).toList());
    //List<Map> objectMaps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<FoodCategory> objectsList = [];
    if (objectMaps.length > 0) {
      for (int i = 0; i < objectMaps.length; i++) {
        objectsList.add(FoodCategory.fromMap(objectMaps[i]));
      }
    }
    return objectsList;
  }

  Future<int> _destroy(int id, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus(table);
    return await dbClient.delete(table['table_plural_name'], where: 'id = ?', whereArgs: [id]);
  }

  Future<int> _update(FoodCategory foodCategory, Map<String, dynamic> table) async {
    var dbClient = await dbHelper.dbPlus(table);
    return await dbClient.update(table['table_plural_name'], foodCategory.toMap(), where: 'id = ?', whereArgs: [foodCategory.id]);
  }

  // Private methods:
  void _generateDummyData() async {
    final List<FoodCategory> foodCategories = await _index(_sqliteTable);
    final int currentLength = foodCategories.length;
    if (currentLength < _maxAmountDummyData) {
      for (int i = 0; i < (_maxAmountDummyData - currentLength); i++) {
        String title = faker.food.dish();
        // Color color = ColorHelper.randomColor();
        Color color = ColorHelper.randomMaterialColor();
        await addFoodCategory(title, color);
      }
    }
  }

  void _removeWhere(int id) async {
    await _destroy(id, _sqliteTable);
    await refresh();
  }

  // Public methods:
  Future refresh() async {
    _foodCategories = await _index(_sqliteTable);
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
    await _create(newFoodCategory, _sqliteTable);
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
