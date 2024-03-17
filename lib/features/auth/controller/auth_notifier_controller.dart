import 'package:doctor_app/models/auth/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authNotifierCtr =
    ChangeNotifierProvider((ref) => AuthNotifierController());

class AuthNotifierController extends ChangeNotifier {
  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  setUserModelData(UserModel model) {
    _userModel = model;
    notifyListeners();
  }

  bool isTermsChecked = false;
  void toggleTerms() {
    isTermsChecked = !isTermsChecked;
    notifyListeners();
  }

  List<String> availableDays = [];
  TimeOfDay from = TimeOfDay.now();
  TimeOfDay to = TimeOfDay.now();

  // add days
  void addDays(String day) {
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
