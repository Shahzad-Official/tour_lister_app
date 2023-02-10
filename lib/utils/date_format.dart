import 'package:intl/intl.dart';

class CustomDateFormat {
  static String dateFormat(String date) {
    return DateFormat("dd MMM").format(DateTime.parse(date));
  }
}
