// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';

// Models:

// Components:

// Helpers:

// Utilities:

class MonetaryTransaction {
  // Properties:
  int id;
  String title;
  double amount;
  DateTime executionDate;
  DateTime createdAt;
  DateTime updatedAt;

  // Constructors:
  MonetaryTransaction({
    this.id,
    @required this.title,
    @required this.amount,
    @required this.executionDate,
    @required this.createdAt,
    @required this.updatedAt,
  });

  MonetaryTransaction.fromMap(Map<String, dynamic> transactionMap) {
    id = transactionMap['id'];
    title = transactionMap['title'];
    amount = transactionMap['amount'];
    // executionDate = transactionMap['executionDate'];
    // createdAt = transactionMap['createdAt'];
    // updatedAt = transactionMap['updatedAt'];

    executionDate = DateTime.parse(transactionMap['executionDate']);
    createdAt = DateTime.parse(transactionMap['createdAt']);
    updatedAt = DateTime.parse(transactionMap['updatedAt']);
  }

  Map<String, dynamic> toMap() {
    var transactionMap = <String, dynamic>{
      'id': id,
      'title': title,
      'amount': amount,
      'executionDate': executionDate.toString(),
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
    return transactionMap;
  }

  // Map<String, dynamic> toMap() => {
  //       'id': id,
  //       'title': title,
  //       'amount': amount,
  //       'executionDate': executionDate.toString(),
  //       'createdAt': createdAt.toString(),
  //       'updatedAt': updatedAt.toString(),
  //     };
}
