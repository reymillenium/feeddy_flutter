// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Screens:

// Models:
import 'package:feeddy_flutter/models/_models.dart';

// Components:
import 'package:feeddy_flutter/components/_components.dart';

// Helpers:

// Utilities:

class TransactionsList extends StatelessWidget {
  // Properties:
  final _listViewScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    TransactionsData transactionsData = Provider.of<TransactionsData>(context, listen: true);
    List<MonetaryTransaction> transactions = transactionsData.transactions;

    return Container(
      child: transactions.isEmpty
          ? FeeddyEmptyWidget(
              packageImage: 1,
              title: 'We are sorry',
              subTitle: 'There is no transactions',
            )

          // Not preserving the local state after an item removal:
          // : ListView.builder(
          //     padding: const EdgeInsets.only(left: 0, top: 0, right: 0),
          //     controller: _listViewScrollController,
          //     itemBuilder: (context, index) {
          //       return TransactionTile(
          //         key: ValueKey(transactions[index].id),
          //         id: transactions[index].id,
          //         index: index,
          //         transaction: transactions[index],
          //       );
          //     },
          //     itemCount: transactions.length,
          //   ),

          // Preserving the local state:
          : ListView.custom(
              padding: const EdgeInsets.only(left: 0, top: 0, right: 0),
              controller: _listViewScrollController,
              childrenDelegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return TransactionTile(
                    key: ValueKey(transactions[index].id),
                    id: transactions[index].id,
                    index: index,
                    transaction: transactions[index],
                  );
                },
                childCount: transactions.length,

                // This callback method is what allows to preserve the state:
                findChildIndexCallback: (Key key) => findChildIndexCallback(key, transactions),
              ),
            ),
    );
  }

  // This callback method is what allows to preserve the state:
  int findChildIndexCallback(Key key, List<MonetaryTransaction> transactions) {
    final ValueKey valueKey = key as ValueKey;
    final int id = valueKey.value;
    MonetaryTransaction monetaryTransaction;
    try {
      monetaryTransaction = transactions.firstWhere((transaction) => id == transaction.id);
    } catch (e) {
      return null;
    }
    return transactions.indexOf(monetaryTransaction);
  }
}
