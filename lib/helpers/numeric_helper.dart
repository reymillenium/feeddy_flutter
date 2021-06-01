// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';

// Helpers:

// Utilities:

// ***********************************************************************************
// *                     * * *  E X T E N S I O N S  * * *                           *
// ***********************************************************************************

extension ReturnsDoubleFromDoubleExtension on double {
  // Returns a rounded double number from a not rounded double (this) and given the amount of places after the comma:
  double roundDouble({int places = 2}) {
    double mod = pow(10.0, places);
    return ((this * mod).round().toDouble() / mod);
  }
}

extension ReturnsIntFromIntExtension on int {
  // Generates a list, containing the Fibonacci sequence, up until the nth term.
  // Example: fibonacci(6); // [0, 1, 1, 2, 3, 5]
  List<int> get fibonacci {
    int n = this;
    int last = 1;
    int last2 = 0;
    return List<int>.generate(n, (int i) {
      if (i < 2) return i;
      int curr = last + last2;
      last2 = last;
      last = curr;
      return curr;
    });
  }

  // Returns the nth term of the Fibonacci sequence.
  // Example: fibonacciNumber(6); // 8
  int get fibonacciNumber {
    int n = this;
    if (n <= 0) return 0;
    return n < 2 ? n : ((n - 1).fibonacciNumber + (n - 2).fibonacciNumber);
  }

  // Calculates the factorial of an integer.
  // Example: factorial(6); // 720
  int factorial(int n) {
    if (n < 0) throw ('Negative numbers are not allowed.');
    return n <= 1 ? 1 : n * this.factorial(n - 1);
  }

  // Calculates the factorial of an integer.
  // Example: factorial(6); // 720
  int get factorialTempGet {
    int n = this;
    if (n < 0) throw ('Negative numbers are not allowed.');
    return n <= 1 ? 1 : n * (n - 1).factorialTempGet;
  }
}

extension ReturnsListFromIntExtension on int {
  // Converts an integer to a list of digits:
  List<int> get digitize {
    return "$this".split('').map((s) => int.parse(s)).toList();
  }
}

class NumericHelper {
  // ***********************************************************************************
  // *                         * * *  I N T E G E R S  * * *                           *
  // ***********************************************************************************

  // Returns a random integer number, between two given integers (both included):
  static int randomIntegerInRange({int min = 0, int max = 1}) {
    return Random().nextInt(max - min + 1) + min;
  }

  // Converts an integer to a list of digits:
  static List<int> digitize(int n) {
    return "$n".split('').map((s) => int.parse(s)).toList();
  }

  // Returns the biggest int included in a List of int numbers:
  static int biggestIntFromList(List<int> list) {
    return list.reduce(max);
  }

  // Returns the lowest int included in a List of int numbers:
  static int lowestIntFromList(List<int> list) {
    return list.reduce(min);
  }

  // Generates a list, containing the Fibonacci sequence, up until the nth term.
  // Example: fibonacci(6); // [0, 1, 1, 2, 3, 5]
  static List<int> fibonacci(int n) {
    int last = 1;
    int last2 = 0;
    return List<int>.generate(n, (int i) {
      if (i < 2) return i;
      int curr = last + last2;
      last2 = last;
      last = curr;
      return curr;
    });
  }

  // Returns the nth term of the Fibonacci sequence.
  // Example: fibonacciNumber(6); // 8
  static int fibonacciNumber(int n) {
    if (n <= 0) return 0;
    return n < 2 ? n : (fibonacciNumber(n - 1) + fibonacciNumber(n - 2));
  }

  // Calculates the factorial of an integer.
  // Example: factorial(6); // 720
  static int factorial(int n) {
    if (n < 0) throw ('Negative numbers are not allowed.');
    return n <= 1 ? 1 : n * factorial(n - 1);
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

  // Returns the lowest double included in a List of double numbers:
  static double lowestDoubleFromList(List<double> list) {
    return list.reduce(min);
  }

  // ***********************************************************************************
  // *                 * * *  I N T E G E R S  &  D O U B L E S  * * *                 *
  // ***********************************************************************************

  // Returns the sum value of a list of numbers.
  static num sum(List<num> numbersList) {
    return numbersList.reduce((num a, num b) => a + b);
  }

  // Maps a number from one range to another range.
  // Example: mapNumRange(5, 0, 10, 0, 100); // 50
  static num mapNumRange(num n, num inMin, num inMax, num outMin, num outMax) {
    return ((n - inMin) * (outMax - outMin)) / (inMax - inMin) + outMin;
  }
}
