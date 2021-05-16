// Packages:

import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Screens:

// Models:
import 'package:feeddy_flutter/models/_models.dart';

// Components:

// Helpers:
import 'package:feeddy_flutter/helpers/_helpers.dart';

// Utilities:

class TransactionsData with ChangeNotifier {
  // Properties:
  final int _maxAmountDummyData = 32;
  List<MonetaryTransaction> _transactions = [];
  DBHelper dbHelper;

  // Constructor:
  TransactionsData() {
    dbHelper = DBHelper();
    refreshTransactionList();
    // _generateDummyData();
  }

  // Getters:
  get transactions {
    return _transactions;
  }

  get lastWeekTransactions {
    final DateTime now = DateTime.now();
    return _transactions.where((transaction) {
      int daysAgo = now.difference(transaction.executionDate).inDays;
      return (daysAgo <= 6 && daysAgo >= 0);
    }).toList();
  }

  // Private methods:
  void _generateDummyData() async {
    final List<MonetaryTransaction> monetaryTransactions = await dbHelper.getMonetaryTransactions();
    final int currentLength = monetaryTransactions.length;
    if (currentLength < _maxAmountDummyData) {
      for (int i = 0; i < (_maxAmountDummyData - currentLength); i++) {
        String title = faker.food.dish();
        double amount = NumericHelper.roundRandomDoubleInRange(min: 0.99, max: 10.00, places: 2);
        DateTime executionDate = DateHelper.randomDateTimeOnTheLastWeek();
        await addTransaction(title, amount, executionDate);
      }
    }
  }

  void _removeTransactionWhere(int id) async {
    // _transactions.removeWhere((element) => element.id == id);

    await dbHelper.deleteTransaction(id);
    await refreshTransactionList();
  }

  Future refreshTransactionList() async {
    _transactions = await dbHelper.getMonetaryTransactions();
    // dbHelper.getMonetaryTransactions().then((result) {
    //   _transactions = result;
    // });
    notifyListeners();
  }

  Future<void> _showDialogPlus(int id, BuildContext context) async {
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
                  deleteTransactionWithoutConfirm(id);
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

  Alert createAlert({int id, BuildContext context, String message = ''}) {
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
            _removeTransactionWhere(id);
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

  // Public methods:
  Future<void> addTransaction(String title, double amount, DateTime executionDate) async {
    DateTime now = DateTime.now();
    // var uuid = Uuid();
    MonetaryTransaction newTransaction = MonetaryTransaction(
      // id: uuid.v1(),
      title: title,
      amount: amount,
      executionDate: executionDate,
      createdAt: now,
      updatedAt: now,
    );
    // _transactions.add(newTransaction);

    await dbHelper.saveTransaction(newTransaction);
    refreshTransactionList();
    // notifyListeners();
  }

  Future<void> updateTransaction(int id, String title, double amount, DateTime executionDate) async {
    DateTime now = DateTime.now();
    // MonetaryTransaction updatingTransaction = _transactions[index];
    MonetaryTransaction updatingTransaction = _transactions.firstWhere((transaction) => id == transaction.id);

    updatingTransaction.title = title;
    updatingTransaction.amount = amount;
    updatingTransaction.executionDate = executionDate;
    updatingTransaction.updatedAt = now;

    await dbHelper.updateTransaction(updatingTransaction);
    refreshTransactionList();
    // notifyListeners();
  }

  Future<void> deleteTransactionWithConfirm(int id, BuildContext context) {
    // createAlert(id: id, context: context).show().then((value) {
    //   (context as Element).reassemble();
    // });

    _showDialogPlus(id, context).then((value) {
      (context as Element).reassemble();
      refreshTransactionList();
      // notifyListeners();
    });
  }

  void deleteTransactionWithoutConfirm(int id) {
    _removeTransactionWhere(id);
    refreshTransactionList();
    // notifyListeners();
  }

  List<Map> groupedAmountLastWeek() {
    List<double> lastWeekAmounts = this.lastWeekAmounts();

    return List.generate(7, (index) {
      return {
        'day': DateHelper.weekDayTimeAgo(days: index),
        'amount': lastWeekAmounts[index],
      };
    });
  }

  double biggestAmountLastWeek() {
    return NumericHelper.biggestDoubleFromList(lastWeekAmounts());
  }

  List<double> lastWeekAmounts() {
    final DateTime now = DateTime.now();
    List<double> result = [0, 0, 0, 0, 0, 0, 0];

    lastWeekTransactions.forEach((transaction) {
      int daysAgo = now.difference(transaction.executionDate).inDays;
      result[daysAgo] += transaction.amount;
    });

    return NumericHelper.roundDoubles(result, 2);
  }
}
