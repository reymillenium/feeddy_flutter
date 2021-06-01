// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Helpers:

// Utilities:

class ListHelper {
  // Returns a random object from a given List:
  static dynamic randomFromList(List<dynamic> list) {
    return list[Random().nextInt(list.length)];
  }

  // Returns the difference between two lists.
  // Examples: difference([1, 2, 3], [1, 2, 4]); // [3]
  static List<T> difference<T>(Iterable<T> a, Iterable<T> b) {
    final s = b.toSet();
    return a.where((x) => !s.contains(x)).toList();
  }

  // Returns a list of elements that exist in both lists.
  // Example: intersection([1, 2, 3], [1, 2, 4]); // [1, 2]
  static List<T> intersection<T>(Iterable<T> a, Iterable<T> b) {
    final s = b.toSet();
    return a.toSet().where((x) => s.contains(x)).toList();
  }

  // Returns every element that exists in any of the two lists once.
  // Example: union([1, 2, 3], [4, 3, 2]); // [1, 2, 3, 4]
  static List<T> union<T>(Iterable<T> a, Iterable<T> b) {
    return (a.toList() + b.toList()).toSet().toList();
  }
}
