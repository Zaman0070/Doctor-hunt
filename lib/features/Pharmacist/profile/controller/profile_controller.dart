import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pprofileNotifierCtr =
    ChangeNotifierProvider((ref) => ProdileNotiController());

class ProdileNotiController extends ChangeNotifier {
  bool isDeleteAccount = false;
  bool get getIsDeleteAccount => isDeleteAccount;
  setIsDeleteAccount(bool value) {
    isDeleteAccount = value;
    notifyListeners();
  }

  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  String timeStr = '';
  String timeEnd = '';

  Future<void> pickStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      startTime = DateTime(
        startTime.year,
        startTime.month,
        startTime.day,
        picked.hour,
        picked.minute,
      );
      int hour = startTime.hour;
      String ampm = hour >= 12 ? 'PM' : 'AM';
      String hourStr = hour > 12 ? (hour - 12).toString() : hour.toString();
      timeStr = '$hourStr:${picked.minute} $ampm';
      notifyListeners();
    }
  }

  Future<void> pickEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      endTime = DateTime(
        endTime.year,
        endTime.month,
        endTime.day,
        picked.hour,
        picked.minute,
      );
      int hour = endTime.hour;
      String ampm = hour >= 12 ? 'PM' : 'AM';
      String hourStr = hour > 12 ? (hour - 12).toString() : hour.toString();
      timeEnd = '$hourStr:${picked.minute} $ampm';
      notifyListeners();
    }
  }
}
