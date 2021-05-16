// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Helpers:
import './numeric_helper.dart';

// Utilities:

class DateHelper {
  // Returns the current DateTime:
  static DateTime now() {
    return DateTime.now();
  }

  // ***********************************************************************************
  // *                            * * *  R A N G E S  * * *                            *
  // ***********************************************************************************

  // Returns a DateTime object a given amount of time ago:
  static DateTime timeAgo({
    int microseconds = 0,
    int milliseconds = 0,
    int seconds = 0,
    int minutes = 0,
    int hours = 0,
    int days = 0,
    int years = 0,
  }) {
    int accumulatedDays = days + (years * 365);
    return DateTime.now().subtract(new Duration(
      microseconds: microseconds,
      milliseconds: milliseconds,
      seconds: seconds,
      minutes: minutes,
      hours: hours,
      days: accumulatedDays,
    ));
  }

  // Returns a DateTime object a given amount of time before a given DateTime:
  static DateTime timeBefore({
    @required DateTime begin,
    int microseconds = 0,
    int milliseconds = 0,
    int seconds = 0,
    int minutes = 0,
    int hours = 0,
    int days = 0,
    int years = 0,
  }) {
    int accumulatedDays = days + (years * 365);
    return begin.subtract(new Duration(
      microseconds: microseconds,
      milliseconds: milliseconds,
      seconds: seconds,
      minutes: minutes,
      hours: hours,
      days: accumulatedDays,
    ));
  }

  // Returns a DateTime object a given amount of time into the future:
  static DateTime timeFromNow({
    int microseconds = 0,
    int milliseconds = 0,
    int seconds = 0,
    int minutes = 0,
    int hours = 0,
    int days = 0,
    int years = 0,
  }) {
    int accumulatedDays = days + (years * 365);
    return DateTime.now().add(new Duration(
      microseconds: microseconds,
      milliseconds: milliseconds,
      seconds: seconds,
      minutes: minutes,
      hours: hours,
      days: accumulatedDays,
    ));
  }

  // Returns a DateTime object a given amount of time after a given DateTime:
  static DateTime timeAfter({
    @required DateTime begin,
    int microseconds = 0,
    int milliseconds = 0,
    int seconds = 0,
    int minutes = 0,
    int hours = 0,
    int days = 0,
    int years = 0,
  }) {
    int accumulatedDays = days + (years * 365);
    return begin.add(new Duration(
      microseconds: microseconds,
      milliseconds: milliseconds,
      seconds: seconds,
      minutes: minutes,
      hours: hours,
      days: accumulatedDays,
    ));
  }

  // ***********************************************************************************
  // *                     * * *  A C Q U I S I T I O N S  * * *                       *
  // ***********************************************************************************

  // Returns the current day of the week::
  static String weekDayNow() {
    // return DateFormat('EEEE').format(DateTime.now());
    return DateFormat.EEEE().format(DateTime.now());
  }

  // Returns the day of the week from a given amount of time ago:
  static String weekDayTimeAgo({
    int microseconds = 0,
    int milliseconds = 0,
    int seconds = 0,
    int minutes = 0,
    int hours = 0,
    int days = 0,
    int years = 0,
  }) {
    // return DateFormat('EEEE').format(timeAgo(
    return DateFormat.EEEE().format(timeAgo(
      microseconds: microseconds,
      milliseconds: milliseconds,
      seconds: seconds,
      minutes: minutes,
      hours: hours,
      days: days,
      years: years,
    ));
  }

  // Returns the day of the week from a given amount of time before a given DateTime:
  static String weekDayTimeBefore({
    @required DateTime begin,
    int microseconds = 0,
    int milliseconds = 0,
    int seconds = 0,
    int minutes = 0,
    int hours = 0,
    int days = 0,
    int years = 0,
  }) {
    // return DateFormat('EEEE').format(timeBefore(
    return DateFormat.EEEE().format(timeBefore(
      begin: begin,
      microseconds: microseconds,
      milliseconds: milliseconds,
      seconds: seconds,
      minutes: minutes,
      hours: hours,
      days: days,
      years: years,
    ));
  }

  // Returns the day of the week from a given amount of time into the future:
  static String weekDayTimeFromNow({
    int microseconds = 0,
    int milliseconds = 0,
    int seconds = 0,
    int minutes = 0,
    int hours = 0,
    int days = 0,
    int years = 0,
  }) {
    // return DateFormat('EEEE').format(timeFromNow(
    return DateFormat.EEEE().format(timeFromNow(
      microseconds: microseconds,
      milliseconds: milliseconds,
      seconds: seconds,
      minutes: minutes,
      hours: hours,
      days: days,
      years: years,
    ));
  }

  // Returns the day of the week from a given amount of time after a given DateTime:
  static String weekDayTimeAfter({
    @required DateTime begin,
    int microseconds = 0,
    int milliseconds = 0,
    int seconds = 0,
    int minutes = 0,
    int hours = 0,
    int days = 0,
    int years = 0,
  }) {
    // return DateFormat('EEEE').format(timeAfter(
    return DateFormat.EEEE().format(timeAfter(
      begin: begin,
      microseconds: microseconds,
      milliseconds: milliseconds,
      seconds: seconds,
      minutes: minutes,
      hours: hours,
      days: days,
      years: years,
    ));
  }

  // ***********************************************************************************
  // *                   * * *  R A N D O M I Z A T I O N  * * *                       *
  // ***********************************************************************************

  // Returns a random DateTime object localized on the last week:
  static DateTime randomDateTimeOnTheLastWeek() {
    final DateTime now = DateTime.now();
    return now.subtract(new Duration(days: NumericHelper.randomIntegerInRange(min: 0, max: 6)));
  }
}
