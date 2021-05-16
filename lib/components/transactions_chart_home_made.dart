// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Screens:

// Models:

// Components:
import 'package:feeddy_flutter/components/_components.dart';

// Helpers:
import 'package:feeddy_flutter/helpers/_helpers.dart';

// Utilities:

class TransactionsChartHomeMade extends StatelessWidget {
  // Properties:
  final List<Map> groupedAmountLastWeek;
  final double biggestAmountLastWeek;
  final NativeDeviceOrientation orientation;

  // Constructor:
  TransactionsChartHomeMade({
    this.groupedAmountLastWeek,
    this.biggestAmountLastWeek,
    this.orientation,
  });

  @override
  Widget build(BuildContext context) {
    // AppData appData = Provider.of<AppData>(context, listen: true);
    // bool isLandscape = DeviceHelper.isLandscape(orientation);
    bool isPortrait = DeviceHelper.isPortrait(orientation);

    List<Widget> getColumns() {
      return List.from(groupedAmountLastWeek.reversed).map((groupedAmountOnDay) {
        return TransactionChartBarHomeMade(
          groupedAmountOnDay: groupedAmountOnDay,
          biggestAmountLastWeek: biggestAmountLastWeek,
          orientation: orientation,
        );
      }).toList();
    }

    return AspectRatio(
      aspectRatio: 1.5,
      child: Card(
        elevation: 3,
        color: Colors.white70,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          // side: BorderSide(color: Colors.red, width: 1),
          // borderRadius: BorderRadius.circular(10),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  if (isPortrait) ...[
                    Text(
                      'Last Week Transactions',
                      style: TextStyle(
                        // color: const Color(0xff379982),
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: getColumns(),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 12,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
