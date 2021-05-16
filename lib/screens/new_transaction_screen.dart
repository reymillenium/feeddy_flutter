// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Screens:

// Models:
import 'package:feeddy_flutter/models/_models.dart';

// Components:

// Helpers:
import 'package:feeddy_flutter/helpers/_helpers.dart';
import 'package:flutter/cupertino.dart';

// Utilities:

class NewTransactionScreen extends StatefulWidget {
  @override
  _NewTransactionScreenState createState() => _NewTransactionScreenState();
}

class _NewTransactionScreenState extends State<NewTransactionScreen> {
  // Local State Properties:
  String _title = '';
  double _amount = 0;
  DateTime _executionDate = DateTime.now();

  // Run time constants:
  final _oneHundredYearsAgo = DateHelper.timeAgo(years: 100);
  final _oneHundredYearsFromNow = DateHelper.timeFromNow(years: 100);

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Map currentCurrency = appData.currentCurrency;

    TransactionsData transactionsData = Provider.of<TransactionsData>(context, listen: true);
    Function onAddTransactionHandler = (title, amount, executionDate) => transactionsData.addTransaction(title, amount, executionDate);

    Color primaryColor = Theme.of(context).primaryColor;
    Color accentColor = Theme.of(context).accentColor;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Container(
          // padding: const EdgeInsets.only(left: 20, top: 0, right: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: [
                Text(
                  'Add Transaction',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 30,
                  ),
                ),

                // Title Input
                TextField(
                  autofocus: true,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          // color: kLightBlueBackground,
                          // width: 30,
                          ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                        width: 4.0,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: accentColor,
                        // color: Colors.red,
                        width: 6.0,
                      ),
                    ),
                  ),
                  style: TextStyle(),
                  onChanged: (String newText) {
                    setState(() {
                      _title = newText;
                    });
                  },
                  onSubmitted: !_hasValidData() ? null : (_) => () => _submitData(context, onAddTransactionHandler),
                ),

                // Amount Input
                TextField(
                  decoration: InputDecoration(hintText: '${currentCurrency['code']}(${currentCurrency['symbol']}) '),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      // turnOffGrouping: false,
                      locale: 'en_US',
                      decimalDigits: 2,
                      symbol: '${currentCurrency['code']}(${currentCurrency['symbol']}) ', // or to remove symbol set ''.
                    )
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: (String newAmountText) {
                    setState(() {
                      _amount = StringHelper.extractDoubleOrZero(newAmountText);
                    });
                  },
                  onSubmitted: !_hasValidData() ? null : (_) => () => _submitData(context, onAddTransactionHandler),
                ),

                // DateTime picker
                DateTimePicker(
                  // type: DateTimePickerType.dateTimeSeparate,
                  type: DateTimePickerType.date,
                  dateMask: 'd MMM, yyyy',
                  initialValue: DateTime.now().toString(),
                  firstDate: _oneHundredYearsAgo,
                  lastDate: _oneHundredYearsFromNow,
                  icon: Icon(Icons.event),
                  dateLabelText: 'Date',
                  timeLabelText: "Hour",
                  selectableDayPredicate: (date) {
                    // Disable weekend days to select from the calendar
                    // if (date.weekday == 6 || date.weekday == 7) {
                    //   return false;
                    // }

                    return true;
                  },
                  onChanged: (val) {
                    setState(() {
                      _executionDate = DateTime.parse(val);
                    });
                  },
                  validator: (val) {
                    // print(val);
                    return null;
                  },
                  // onSaved: (val) => print(val),
                ),

                // Add button:
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: DeviceHelper.deviceIsIOS(context)
                      ? Container(
                          color: Colors.transparent,
                          height: 48.0,
                          width: double.infinity,
                          child: CupertinoButton(
                            color: primaryColor,
                            disabledColor: Colors.grey,
                            onPressed: !_hasValidData() ? null : () => _submitData(context, onAddTransactionHandler),
                            child: Text(
                              'Add',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Material(
                          color: _hasValidData() ? primaryColor : Colors.grey,
                          // borderRadius: BorderRadius.circular(12.0),
                          elevation: 5,
                          child: MaterialButton(
                            disabledColor: Colors.grey,
                            onPressed: !_hasValidData() ? null : () => _submitData(context, onAddTransactionHandler),
                            // minWidth: 300.0,
                            minWidth: double.infinity,
                            height: 42.0,
                            child: Text(
                              'Add',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _hasValidData() {
    bool result = false;
    if (_title.isNotEmpty && _amount != 0) {
      result = true;
    }
    return result;
  }

  void _submitData(BuildContext context, Function onAddTransactionHandler) {
    if (_title.isNotEmpty && _amount != 0) {
      onAddTransactionHandler(_title, _amount, _executionDate);
    }
    Navigator.pop(context);
  }
}
