import 'package:intl/intl.dart';

class FormatedDatetime {
  static String getFormatedDateTime(DateTime dateTime) {
    var formatedDatetime = DateFormat('dd-MM-yyyy ').add_jm().format(dateTime);
    return formatedDatetime;
  }
}
