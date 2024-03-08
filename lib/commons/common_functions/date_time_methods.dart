import 'package:intl/intl.dart';

import '../common_imports/common_libs.dart';

TimeOfDay dateTimeToTimeOfDay(DateTime dateTime){
  DateTime currentDateTime = dateTime;
  // Convert DateTime to TimeOfDay
  TimeOfDay currentTime = TimeOfDay.fromDateTime(currentDateTime);
  return currentTime;
}

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  final formattedTime = DateFormat('hh:mm a').format(dateTime);
  return formattedTime;
}

DateTime timeOfDayToDateTime(TimeOfDay timeOfDay){
  final now = DateTime.now();
  final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  return dateTime;
}

String formatDateTime(DateTime dateTime) {
  return DateFormat('hh:mm a').format(dateTime);
}
