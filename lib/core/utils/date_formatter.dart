import 'package:intl/intl.dart';

class DateFormatter {
  static String yMMMd(DateTime d) => DateFormat.yMMMd().format(d);
  static String hm(DateTime d) => DateFormat.Hm().format(d);
}

