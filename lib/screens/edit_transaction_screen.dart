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

class EditTransactionScreen extends StatefulWidget {
  // Properties:
  final int id;
  final int index;
  final String title;
  final double amount;
  final DateTime executionDate;
  final Function onUpdateTransactionHandler;

  // Constructor:
  EditTransactionScreen({
    this.id,
    this.index,
    this.title,
    this.amount,
    this.executionDate,
    this.onUpdateTransactionHandler,
  });

  @override
  _EditTransactionScreenState createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  // State Properties:
  int _id;
  int _index;
  String _title;
  double _amount;
  DateTime _executionDate;

  // Run time constants:
  DateTime now = DateTime.now();
  final _oneHundredYearsAgo = DateHelper.timeAgo(years: 100);
  final _oneHundredYearsFromNow = DateHelper.timeFromNow(years: 100);
  final NumberFormat _currencyFormat = new NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _id = widget.id;
    _index = widget.index;
    _title = widget.title;
    _amount = widget.amount;
    _executionDate = widget.executionDate;
  }

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Map currentCurrency = appData.currentCurrency;

    TransactionsData transactionsData = Provider.of<TransactionsData>(context, listen: true);
    Function onUpdateTransactionHandler = (id, title, amount, executionDate) => transactionsData.updateTransaction(id, title, amount, executionDate);

    final String initialAmountLabel = '${currentCurrency['code']}(${currentCurrency['symbol']}) ${_currencyFormat.format(_amount)}';
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
                  'Update Transaction',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 30,
                  ),
                ),

                // Title Input
                TextFormField(
                  initialValue: _title,
                  autofocus: true,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        // color: kLightBlueBackground,
                        color: Colors.red,
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
                  onFieldSubmitted: _hasValidData() ? (_) => () => _updateData(context, onUpdateTransactionHandler) : null,
                ),

                // Amount Input
                TextFormField(
                  initialValue: initialAmountLabel,
                  // decoration: InputDecoration(hintText: 'USD(\$) '),
                  decoration: InputDecoration(hintText: '${currentCurrency['code']}(${currentCurrency['symbol']}) '),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      // turnOffGrouping: false,
                      locale: 'en_US',
                      decimalDigits: 2,
                      symbol: '${currentCurrency['code']}(${currentCurrency['symbol']}) ', // or to remove symbol set ''.
                      // symbol: '', // or to remove symbol set ''.
                    )
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: (String amountText) {
                    setState(() {
                      _amount = StringHelper.extractDoubleOrZero(amountText);
                    });
                  },
                  onFieldSubmitted: _hasValidData() ? (_) => () => _updateData(context, onUpdateTransactionHandler) : null,
                ),

                // DateTime picker
                DateTimePicker(
                  // type: DateTimePickerType.dateTimeSeparate,
                  type: DateTimePickerType.date,
                  dateMask: 'd MMM, yyyy',
                  initialValue: _executionDate.toString(),
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
                    return null;
                  },
                  // onSaved: (val) => print(val),
                ),

                // Update button:
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: Material(
                    color: _hasValidData() ? primaryColor : Colors.grey,
                    // borderRadius: BorderRadius.circular(12.0),
                    elevation: 5.0,
                    child: MaterialButton(
                      disabledColor: Colors.grey,
                      onPressed: _hasValidData() ? () => _updateData(context, onUpdateTransactionHandler) : null,
                      // minWidth: 300.0,
                      minWidth: double.infinity,
                      height: 42.0,
                      child: Text(
                        'Update',
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

  void _updateData(BuildContext context, Function onUpdateTransactionHandler) {
    if (_title.isNotEmpty && _amount != 0) {
      onUpdateTransactionHandler(_id, _title, _amount, _executionDate);
    }
    Navigator.pop(context);
  }
}
