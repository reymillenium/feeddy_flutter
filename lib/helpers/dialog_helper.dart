// Packages:

import 'dart:ffi';

import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Models:
import 'package:feeddy_flutter/models/_models.dart';

// Helpers:

// Utilities:

class DialogHelper {
  static Future<void> showDialogPlus(int id, BuildContext context, Function onAcceptPressed) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // The user must tap the buttons!
      // barrierColor: Colors.transparent, // The background color
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here

          content: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(12),
              // height: 100,
              child: Column(
                children: <Widget>[
                  Text(
                    'This action is irreversible.',
                    style: TextStyle(
                      color: Theme.of(context).errorColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text('Would you like to confirm this message?'),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Row(
                  children: [
                    Text('Confirm'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.delete),
                  ],
                ),
                onPressed: () {
                  onAcceptPressed();
                  Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Row(
                  children: [
                    Text('Cancel'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.cancel),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  static Alert createAlert({int id, BuildContext context, String message = '', Function onAcceptPressed}) {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: "Are you sure?",
      // desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            onAcceptPressed();
            Navigator.of(context).pop();
          },
          width: 120,
        ),
        DialogButton(
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
      ],
    );
  }
}
