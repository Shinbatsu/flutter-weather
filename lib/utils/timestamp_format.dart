import 'package:intl/intl.dart';

String fromTimestamp(int timestamp) {
  return DateFormat('HH:mm')
      .format(DateTime.fromMillisecondsSinceEpoch(timestamp));
}
