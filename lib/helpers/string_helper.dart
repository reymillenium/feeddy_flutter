// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Helpers:

// Utilities:

class StringHelper {
// ***********************************************************************************
// *               * * *  N U M B E R S  E X T R A C T I O N  * * *                  *
// ***********************************************************************************

  // It returns 0 when:
  // FormatException: Invalid double => No number included, only a dot included or empty string
  static double extractDoubleOrZero(String text) {
    double result;
    try {
      result = double.parse(text.replaceAll(new RegExp(r'[^0-9\.]'), ''));
    } catch (e) {
      result = 0;
    }
    return result;
  }

  // It returns 0 when:
  // FormatException: Invalid double => No number included or empty string
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
}
