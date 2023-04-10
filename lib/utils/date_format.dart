import 'package:intl/intl.dart';

class CustomDateFormat {
  static String dateFormat(String date) {
    return DateFormat("dd MMM").format(DateTime.parse(date));
  }

  static String formatedDate({
    required String formatPattern,
    required String date,
  }) {
    DateTime newDate = DateTime.parse(date);
    return DateFormat(formatPattern).format(newDate);
  }
}
