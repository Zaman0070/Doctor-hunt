import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dprofileNotifierCtr =
    ChangeNotifierProvider((ref) => DoctorProdileNotiController());

class DoctorProdileNotiController extends ChangeNotifier {
  bool isDeleteAccount = false;
  bool get getIsDeleteAccount => isDeleteAccount;
  setIsDeleteAccount(bool value) {
    isDeleteAccount = value;
    notifyListeners();
  }

  List<dynamic> availableDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  TimeOfDay from = TimeOfDay.now();
  TimeOfDay to = TimeOfDay.now();

  addDays(String day, List<dynamic> availableDays) {
    if (availableDays.contains(day)) {
      availableDays.remove(day);
    } else {
      availableDays.add(day);
    }
    notifyListeners();
  }

  Future<void> selectTimeFrom(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != TimeOfDay.now()) {
      from = picked;
      notifyListeners();
    }
  }

  Future<void> selectTimeTo(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != TimeOfDay.now()) {
      to = picked;
      notifyListeners();
    }
  }
}
