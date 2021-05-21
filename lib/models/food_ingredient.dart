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

// enum Complexity {
//   verySimple,
//   simple,
//   medium,
//   challenging,
//   hard,
//   veryHard,
// }
enum MeasurementUnit {
  gram,
  tea_spoon,
  dessert_spoon,
  table_spoon,
  fluid_once,
  cup,
  pint,
  quart,
  gallon,
  liter,
}

class FoodIngredient {
  // Properties:
  int id;
  String name;
  double amount;
  MeasurementUnit measurementUnit;
  DateTime createdAt;
  DateTime updatedAt;

  // Constructors:
  FoodIngredient({
    this.id,
    @required this.name,
    @required this.amount,
    @required this.measurementUnit,
    @required this.createdAt,
    @required this.updatedAt,
  });

  FoodIngredient.fromMap(Map<String, dynamic> foodIngredientMap) {
    id = foodIngredientMap['id'];
    name = foodIngredientMap['name'];
    amount = foodIngredientMap['amount'];
    measurementUnit = foodIngredientMap['measurementUnit'];

    createdAt = DateTime.parse(foodIngredientMap['createdAt']);
    updatedAt = DateTime.parse(foodIngredientMap['updatedAt']);
  }

  Map<String, dynamic> toMap() {
    var foodIngredientMap = <String, dynamic>{
      'id': id,
      'name': name,
      'amount': amount,
      'measurementUnit': measurementUnit,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
    return foodIngredientMap;
  }
}
