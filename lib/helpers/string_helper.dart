// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Helpers:

// Utilities:

// ***********************************************************************************
// *                     * * *  E X T E N S I O N S  * * *                           *
// ***********************************************************************************

extension StringFromStringExtension on String {
  // Capitalizes only the first character of a String:
  String get inCaps => this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';

  // Capitalizes the first letter of a string. Omit the optional parameter, lowerRest, to keep the rest of the string intact, or set it to true to convert to lowercase.
  String inCapsPlus({bool lowerRest = false}) {
    return this[0].toUpperCase() + (lowerRest ? this.substring(1).toLowerCase() : this.substring(1));
  }

  // Capitalizes all the characters of a String:
  String get allInCaps => this.toUpperCase();

  // Capitalizes the first character of each word inside a String:
  String get capitalizeFirstOfEach => this.replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.inCaps).join(" ");

  // Decapitalizes the first letter of a string. Omit the optional parameter, upperRest, to keep the rest of the string intact, or set it to true to convert to uppercase.
  String deCapitalize({bool upperRest = false}) {
    return this[0].toLowerCase() + (upperRest ? this.substring(1).toUpperCase() : this.substring(1));
  }

  // Converts a String from camelCase to readable:
  String get readable {
    RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');
    return this.replaceAllMapped(exp, (Match m) => (' ' + m.group(0))).toLowerCase().inCaps;
  }

  // Converts a String from camelCase to snake_case:
  String get toSnakeCase {
    RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');
    return this.replaceAllMapped(exp, (Match m) => ('_' + m.group(0))).toLowerCase();
  }

  // Converts a String from every possible way to snake_case:
  String get toSnakeCasePlus {
    return this.replaceAllMapped(RegExp(r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'), (Match m) => "${m[0].toLowerCase()}").replaceAll(RegExp(r'(-|\s)+'), '_');
  }

  // Converts a String from snake_case and and other variants into camelCase:
  String get toCamelCase {
    String str = this.replaceAllMapped(RegExp(r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'), (Match m) => "${m[0][0].toUpperCase()}${m[0].substring(1).toLowerCase()}").replaceAll(RegExp(r'(_|-|\s)+'), '');
    return str[0].toLowerCase() + str.substring(1);
  }

  // Converts a String from snake_case and and other variants into kebab-case:
  String get toKebabCase {
    return this.replaceAllMapped(RegExp(r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'), (Match m) => "${m[0].toLowerCase()}").replaceAll(RegExp(r'(_|\s)+'), '-');
  }

  // Converts a String from snake_case and and other variants into Title Case:
  String get toTitleCase {
    return this.replaceAllMapped(RegExp(r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'), (Match m) => "${m[0][0].toUpperCase()}${m[0].substring(1).toLowerCase()}").replaceAll(RegExp(r'(_|-)+'), ' ');
  }

  // Normalizes a text (ordered alphabetically):
  String get normalize {
    return (this.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]', caseSensitive: false), '').split('')..sort()).join('');
  }

  // Creates a string with the results of calling the provided function on every character of the applied string:
  String mapString(String Function(String c) fn) {
    return this.split('').map(fn).join('');
  }

  // Removes non-printable ASCII characters.
  String get removeNonASCII {
    return this.replaceAll(RegExp(r'[^\x20-\x7E]'), '');
  }

  // Replaces all but the last num runes of a string with the specified mask.
  String mask({int num = 4, String mask = '*'}) {
    return this.substring(this.length - num).padLeft(this.length, mask);
  }

  // Returns a string with whitespaces compacted (replace all occurrences of 2 or more whitespace characters with a single space)
  String get compactWhitespace {
    return this.replaceAll(RegExp(r'\s{2,}'), ' ');
  }

  // Reverses a string:
  String get reverse {
    return this.split('').reversed.join('');
  }

  // Truncates a string up to a specified length. Returns the string truncated to the desired length, with '...' appended to the end or the original string.
  String truncate({int num = 3}) {
    return this.length > num ? this.substring(0, num > 3 ? num - 3 : num) + '...' : this;
  }
}

extension ListFromStringExtension on String {
  // Converts a given string into a list of words.
  List<String> get intoListOfWords {
    return this.split(RegExp('[^a-zA-Z-]+')).where((s) => s.isNotEmpty).toList();
  }

  // Splits a multiline string into a list of lines.
  List<String> get splitLines {
    return this.split(RegExp(r'\r?\n'));
  }
}

extension BoolFromStringExtension on String {
  // Determines if a string is an anagram from another string:
  bool isAnagram(String str1, String str2) {
    String normalize(String str) => (str.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]', caseSensitive: false), '').split('')..sort()).join('');
    return normalize(str1) == normalize(str2);
  }

  // Returns true if a string is a palindrome, false otherwise.
  bool get isPalindrome {
    String s = this.toLowerCase().replaceAll(RegExp(r'[\W_]'), '');
    return s == s.split('').reversed.join('');
  }

  // Determines if a String contains a white space:
  bool get containsWhiteSpace {
    return this.indexOf(' ') >= 0;
  }

  // Checks if a string is lower case.
  bool get isLowerCase {
    return this == this.toLowerCase();
  }

  // Checks if a string is upper case.
  bool get isUpperCase {
    return this == this.toUpperCase();
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

  static bool isAnagram(String str1, String str2) {
    String normalize(String str) => (str.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]', caseSensitive: false), '').split('')..sort()).join('');
    return normalize(str1) == normalize(str2);
  }

  // Creates a string with the results of calling the provided function on every character in the given string
  static String mapString(String str, String Function(String c) fn) {
    return str.split('').map(fn).join('');
  }

  // Converts a given string into a list of words.
  static List<String> intoListOfWords(String str, {String pattern = '[^a-zA-Z-]+'}) {
    return str.split(RegExp(pattern)).where((s) => s.isNotEmpty).toList();
  }

  // Removes non-printable ASCII characters.
  static String removeNonASCII(String str) {
    return str.replaceAll(RegExp(r'[^\x20-\x7E]'), '');
  }

  // Replaces all but the last num runes of a string with the specified mask.
  static String mask(String str, {int num = 4, String mask = '*'}) {
    return str.substring(str.length - num).padLeft(str.length, mask);
  }

  // Splits a multiline string into a list of lines.
  static List<String> splitLines(String str) {
    return str.split(RegExp(r'\r?\n'));
  }

  // Returns a string with whitespaces compacted (replace all occurrences of 2 or more whitespace characters with a single space)
  static String compactWhitespace(String str) {
    return str.replaceAll(RegExp(r'\s{2,}'), ' ');
  }

  // Reverses a string:
  static String reverse(String str) {
    return str.split('').reversed.join('');
  }

// Capitalizes the first letter of a string. Omit the optional parameter, lowerRest, to keep the rest of the string intact, or set it to true to convert to lowercase.
  static String inCapsPlus(String str, {bool lowerRest = false}) {
    return str[0].toUpperCase() + (lowerRest ? str.substring(1).toLowerCase() : str.substring(1));
  }

  // DeCapitalizes the first letter of a string. Omit the optional parameter, upperRest, to keep the rest of the string intact, or set it to true to convert to uppercase.
  static String deCapitalize(String str, {bool upperRest = false}) {
    return str[0].toLowerCase() + (upperRest ? str.substring(1).toUpperCase() : str.substring(1));
  }

  // Truncates a string up to a specified length. Returns the string truncated to the desired length, with '...' appended to the end or the original string.
  static String truncate(String str, {int num = 3}) {
    return str.length > num ? str.substring(0, num > 3 ? num - 3 : num) + '...' : str;
  }

  // Checks if a string is lower case.
  static bool isLowerCase(String str) {
    return str == str.toLowerCase();
  }

  // Checks if a string is upper case.
  static bool isUpperCase(String str) {
    return str == str.toUpperCase();
  }
}
