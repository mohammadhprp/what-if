import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format({String f = 'yMMMM'}) {
    final format = DateFormat(f);
    return format.format(this);
  }
}
