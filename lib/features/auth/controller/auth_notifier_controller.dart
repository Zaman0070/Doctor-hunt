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

  // add days
  void addDays(String day) {
    if (availableDays.contains(day)) {
      availableDays.remove(day);
    } else {
      availableDays.add(day);
    }
    notifyListeners();
  }
}
