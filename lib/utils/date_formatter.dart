
import 'package:intl/intl.dart';

class DateFormatter {

  static int getNumberOfDaysSinceTimeStampString(String timestampString) {
    DateTime time = DateTime.parse(timestampString);
    DateTime now = DateTime.now();

    Duration difference = time.difference(now);
    print(difference.inDays.abs());
    return difference.inDays.abs();
  }

  static String getDateFromString(String timestampString) {
    DateTime time = DateTime.parse(timestampString);
    return DateFormat.yMMMd('en_US').format(time).toString();
  }

  static String getTimeFromString(String timestampString) {
    DateTime time = DateTime.parse(timestampString);
    return DateFormat.jms('en_US').format(time).toString();
  }
}
