import 'package:intl/intl.dart';

class Utils {
  static String formatDate(DateTime date) {
    return DateFormat("yyyy/MM/dd").format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat("hh:mm").format(date);
  }

  static int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
