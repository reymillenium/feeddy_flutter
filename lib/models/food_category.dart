// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Screens:
import 'package:feeddy_flutter/screens/_screens.dart';

// Models:
import 'package:feeddy_flutter/models/_models.dart';

// Components:
import 'package:feeddy_flutter/components/_components.dart';

// Helpers:
import 'package:feeddy_flutter/helpers/_helpers.dart';

// Utilities:

class FoodCategory {
  // Properties:
  int id;
  String title;
  Color color;
  DateTime createdAt;
  DateTime updatedAt;

  // Constructors:
  FoodCategory({
    this.id,
    @required this.title,
    this.color = Colors.orangeAccent,
    @required this.createdAt,
    @required this.updatedAt,
  });

  FoodCategory.fromMap(Map<String, dynamic> foodCategoryMap) {
    id = foodCategoryMap['id'];
    title = foodCategoryMap['title'];
    color = ColorHelper.fromHex(foodCategoryMap['color']);
    createdAt = DateTime.parse(foodCategoryMap['createdAt']);
    updatedAt = DateTime.parse(foodCategoryMap['updatedAt']);
  }

  Map<String, dynamic> toMap() {
    var foodCategoryMap = <String, dynamic>{
      'id': id,
      'title': title,
      'color': color.toHex(leadingHashSign: true),
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
    return foodCategoryMap;
  }

  // Map<String, dynamic> toMap() => {
  //       'id': id,
  //       'title': title,
  //       'color': color.toHex(leadingHashSign: true),
  //       'createdAt': createdAt.toString(),
  //       'updatedAt': updatedAt.toString(),
  //     };
}
