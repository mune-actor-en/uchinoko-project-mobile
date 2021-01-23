import 'package:intl/intl.dart';

class DateFormatter {
  static final _formatter = DateFormat('yyyy年MM月dd日');
  static final _fullFormatter = DateFormat('yyyy-MM-dd hh:mm:ss');

  static String generateStr(DateTime date) {
    return _formatter.format(date);
  }

  static String generateFullStr(String dateStr) {
    var date = DateTime.parse(dateStr);
    return _fullFormatter.format(date);
  }
}