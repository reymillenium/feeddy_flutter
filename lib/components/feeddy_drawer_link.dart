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

class FeeddyDrawerLink extends StatelessWidget {
  // Properties:
  final IconData icon;
  final String title;
  final String screenId;

  const FeeddyDrawerLink({
    Key key,
    this.icon,
    this.title,
    this.screenId,
  }) : super(key: key);

  void onTapLink(String screenId, BuildContext context) {
    // Navigator.of(context).pushNamed(screenId);
    Navigator.of(context).pushReplacementNamed(screenId);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTapLink(screenId, context),
      leading: Icon(
        icon,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
