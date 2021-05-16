// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';

// Helpers:

// Utilities:

class NumericHelper {
  // ***********************************************************************************
  // *                         * * *  I N T E G E R S  * * *                           *
  // ***********************************************************************************

  // Returns a random integer number, between two given integers (both included):
  static int randomIntegerInRange({int min = 0, int max = 1}) {
    return Random().nextInt(max - min + 1) + min;
  }

  // ***********************************************************************************
  // *                           * * *  D O U B L E S  * * *                           *
  // ***********************************************************************************

  // Returns a random double number, between two given doubles (both included):
  static double randomDoubleInRange({double min = 0.0, double max = 1.0}) {
    return (Random().nextDouble() * (max - min)) + min;
  }

  // Returns a rounded double number, given a not rounded double and the amount of places after the comma:
  static double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  // Returns a list of rounded double numbers, given a not rounded list of doubles and the amount of places after the comma:
  static List<double> roundDoubles(List<double> doublesList, int places) {
    return doublesList.map((doubleElement) {
      return roundDouble(doubleElement, places);
    }).toList();
  }

  // Returns a random & rounded double number, between two given doubles (both included), , given a not rounded double and the amount of places after the comma:
  static double roundRandomDoubleInRange({double min = 0, double max = 1, int places = 0}) {
    return roundDouble(randomDoubleInRange(min: min, max: max), places);
  }

  // Returns the biggest double included in a List of double numbers:
  static double biggestDoubleFromList(List<double> list) {
    return list.reduce(max);
  }
}
