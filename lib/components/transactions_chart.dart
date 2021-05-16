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

class TransactionsChart extends StatelessWidget {
  // Properties:
  final Function touchCallbackHandler;
  final int touchedIndex;
  final List<Map> groupedAmountLastWeek;
  final double biggestAmountLastWeek;
  final NativeDeviceOrientation orientation;

  // bool isPlaying = false;

  // Constructor:
  TransactionsChart({
    this.touchCallbackHandler,
    this.touchedIndex,
    this.groupedAmountLastWeek,
    this.biggestAmountLastWeek,
    this.orientation,
  });

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    // List<Map> availableThemeColors = appData.availableThemeColors;
    // Map currentThemeColors = appData.currentThemeColors;
    // List<Map> availableThemeFonts = appData.availableThemeFonts;
    Map currentThemeFont = appData.currentThemeFont;

    final Color primaryColor = Theme.of(context).primaryColor;
    final Color accentColor = Theme.of(context).accentColor;
    bool isLandscape = DeviceHelper.isLandscape(orientation);
    bool isPortrait = DeviceHelper.isPortrait(orientation);
    final int amountTransactionsLastWeek = groupedAmountLastWeek.length;

    return Card(
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
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                if (isPortrait) ...[
                  Text(
                    'Last Week Transactions ($amountTransactionsLastWeek)',
                    style: TextStyle(
                      // color: const Color(0xff379982),
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                ],
                // Text(
                //   'Last Week Transactions',
                //   style: TextStyle(
                //     // color: const Color(0xff379982),
                //     color: Colors.black,
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // SizedBox(
                //   height: 24,
                // ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: BarChart(
                      mainBarData(primaryColor, currentThemeFont, isLandscape),
                      // mainBarData(context),
                      swapAnimationDuration: animDuration,
                    ),
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
    );
  }

  BarChartGroupData makeGroupData(
    Color primaryColor,
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: biggestAmountLastWeek + 2,
            // colors: [barBackgroundColor],
            colors: [TinyColor(primaryColor).lighten(16).color],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(Color primaryColor) => List.generate(7, (i) {
        return makeGroupData(primaryColor, 6 - i, NumericHelper.roundDouble(groupedAmountLastWeek[6 - i]['amount'], 2), isTouched: (i) == touchedIndex);
      });

  BarChartData mainBarData(Color primaryColor, Map currentThemeFont, bool isLandscape) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            direction: isLandscape ? TooltipDirection.bottom : TooltipDirection.top,
            tooltipPadding: EdgeInsets.symmetric(horizontal: 5, vertical: isLandscape ? 0 : 8),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay = groupedAmountLastWeek[group.x]['day'];

              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
                children: <TextSpan>[
                  TextSpan(
                    // text: (rod.y - 1.0).toString(),
                    text: NumericHelper.roundDouble((rod.y - 1.0), 2).toString(),
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                // textAlign: TextAlign.center,
              );
            }),
        touchCallback: (barTouchResponse) => touchCallbackHandler(barTouchResponse),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => TextStyle(
            // color: Colors.purple,
            // color: Theme.of(context).primaryColor,
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            fontFamily: currentThemeFont['fontFamily'],
          ),
          margin: 16,
          getTitles: (double value) {
            int integerValue = value.toInt();
            return groupedAmountLastWeek[integerValue]['day'].substring(0, 2);
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(primaryColor),
    );
  }
}
