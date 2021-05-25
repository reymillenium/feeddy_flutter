// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Helpers:
import './numeric_helper.dart';

// Utilities:

extension ColorHelper on Color {
  // static const List<MaterialColor> primaries = <MaterialColor>[
  //   Colors.red,
  //   Colors.pink,
  //   Colors.purple,
  //   Colors.deepPurple,
  //   Colors.indigo,
  //   Colors.blue,
  //   Colors.lightBlue,
  //   Colors.cyan,
  //   Colors.teal,
  //   Colors.green,
  //   Colors.lightGreen,
  //   Colors.lime,
  //   Colors.yellow,
  //   Colors.amber,
  //   Colors.orange,
  //   Colors.deepOrange,
  //   Colors.brown,
  //   // The grey swatch is intentionally omitted because when picking a color
  //   // randomly from this list to colorize an application, picking grey suddenly
  //   // makes the app look disabled.
  //   Colors.blueGrey,
  // ];

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  // Returns a random color:
  static Color randomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  // Returns a contrasting color compared with a given one:
  static Color contrastingColor(Color color) {
    return color.computeLuminance() > 0.2 ? Colors.black : Colors.white;
  }

  // Returns a random material color:
  static Color randomMaterialColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }
}
