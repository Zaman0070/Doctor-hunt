import 'package:doctor_app/firebase_messaging/service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final uprofileNotifierCtr =
    ChangeNotifierProvider((ref) => UserProdileNotiController());

class UserProdileNotiController extends ChangeNotifier {
  bool isDeleteAccount = false;
  bool get getIsDeleteAccount => isDeleteAccount;
  setIsDeleteAccount(bool value) {
    isDeleteAccount = value;
    notifyListeners();
  }

  TimeOfDay from = TimeOfDay.now();
  TimeOfDay to = TimeOfDay.now();

  Future<void> selectTimeFrom(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != TimeOfDay.now()) {
      await LocalNotificationService()
          .scheduleNotificationStart(hour: picked.hour, minute: picked.minute);
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
      await LocalNotificationService()
          .scheduleNotificationEnd(hour: picked.hour, minute: picked.minute);
      notifyListeners();
    }
  }
}
