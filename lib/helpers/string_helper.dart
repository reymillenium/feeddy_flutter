// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Helpers:

// Utilities:

// ***********************************************************************************
// *                     * * *  E X T E N S I O N S  * * *                           *
// ***********************************************************************************

extension CapExtension on String {
  // Capitalizes only the first character of a String:
  String get inCaps => this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';

  // Capitalizes all the characters of a String:
  String get allInCaps => this.toUpperCase();

  // Capitalizes the first character of each word inside a String:
  String get capitalizeFirstOfEach => this.replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.inCaps).join(" ");

  // Converts to readable String a camelCase String:
  String get readable {
    RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');
    return this.replaceAllMapped(exp, (Match m) => (' ' + m.group(0))).toLowerCase().inCaps;
  }

  // Converts to snake_case String a camelCase String:
  String get toSnakeCase {
    RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');
    return this.replaceAllMapped(exp, (Match m) => ('_' + m.group(0))).toLowerCase();
  }
}

class StringHelper {
// ***********************************************************************************
// *               * * *  N U M B E R S  E X T R A C T I O N  * * *                  *
// ***********************************************************************************

  // Returns a double from a given String
  // It returns 0 when => FormatException: Invalid double => No number included, only a dot included or empty string
  static double extractDoubleOrZero(String text) {
    double result;
    try {
      result = double.parse(text.replaceAll(new RegExp(r'[^0-9\.]'), ''));
    } catch (e) {
      result = 0;
    }
    return result;
  }

  // Returns an integer from a given String
  // It returns 0 when => FormatException: Invalid double => No number included or empty string
  static double extractIntegerOrZero(String text) {
    double result;
    try {
      result = double.parse(text.replaceAll(new RegExp(r'[^0-9]'), ''));
    } catch (e) {
      result = 0;
    }
    return result;
  }

// ***********************************************************************************
// *                   * * *  R A N D O M I Z A T I O N  * * *                       *
// ***********************************************************************************

  // It generates an string with a provided length (ends with an '=' character in several cases)
  static String getRandomString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

// ***********************************************************************************
// *                           * * *  E N U M S  * * *                               *
// ***********************************************************************************

  // Convert to String a given Enum object:
  static String enumToString(Object enumVariable, {bool camelCase = false}) {
    String result = '';
    String enumString = enumVariable.toString();
    int dotIndex = enumString.indexOf('.');
    result = enumString.substring(dotIndex + 1, enumString.length);
    return (camelCase ? result.readable : result);
  }
}
