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
import 'package:feeddy_flutter/utilities/constants.dart';

class TransactionChartBarHomeMade extends StatelessWidget {
  // Properties:
  final Map groupedAmountOnDay;
  final double biggestAmountLastWeek;
  final NativeDeviceOrientation orientation;

  // Run time constants:
  // final DateFormat formatter = DateFormat().add_yMMMMd();
  final currencyFormat = new NumberFormat("#,##0.00", "en_US");

  // Constructor:
  TransactionChartBarHomeMade({
    this.groupedAmountOnDay,
    this.biggestAmountLastWeek,
    this.orientation,
  });

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Map currentCurrency = appData.currentCurrency;
    final String amountLabel = '${currentCurrency['symbol']}${currencyFormat.format(groupedAmountOnDay['amount'])}';

    Color primaryColor = Theme.of(context).primaryColor;
    const backgroundColumnHeight = 120.0;
    double activeBarHeight = groupedAmountOnDay['amount'] == 0 ? 0 : NumericHelper.roundDouble((groupedAmountOnDay['amount'] / biggestAmountLastWeek) * (backgroundColumnHeight - 10), 2);
    // bool isLandscape = DeviceHelper.isLandscape(orientation);
    bool isPortrait = DeviceHelper.isPortrait(orientation);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            // SizedBox(
            //   height: 10,
            // ),
            if (isPortrait) ...[
              Container(
                height: constraints.maxHeight * 0.10,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text('${NumericHelper.roundDouble(groupedAmountOnDay['amount'], 2)}'),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
            ],

            // Bars
            Container(
              height: constraints.maxHeight * (isPortrait ? 0.67 : 0.84),
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: <Widget>[
                  Tooltip(
                    // message: '${NumericHelper.roundDouble(groupedAmountOnDay['amount'], 2)}',
                    message: amountLabel,

                    child: Container(
                      // height: backgroundColumnHeight,
                      width: 20,
                      decoration: BoxDecoration(
                        color: TinyColor(primaryColor).lighten(16).color,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        // borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Tooltip(
                    message: amountLabel,
                    child: Container(
                      height: activeBarHeight,
                      width: 20,
                      decoration: BoxDecoration(
                        // color: Theme.of(context).accentColor,
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isPortrait) ...[
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
            ],

            Container(
              height: constraints.maxHeight * (isPortrait ? 0.10 : 0.16),
              child: FittedBox(
                child: Text(
                  groupedAmountOnDay['day'].substring(0, 2),
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
          ],
        );
      },
    );
  }
}
