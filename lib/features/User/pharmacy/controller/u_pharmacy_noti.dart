import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final uPharmacyNotifierCtr =
    ChangeNotifierProvider((ref) => UPharmacyNotiController());

class UPharmacyNotiController extends ChangeNotifier {
  String gender = 'Male';

  List<String> genderList = const [
    'Male',
    'Female',
  ];

  setGender(String value) {
    gender = value;
    notifyListeners();
  }

  bool isNotification = false;
  bool get getIsNotification => isNotification;
  setIsNotification(bool value) {
    isNotification = !isNotification;
    notifyListeners();
  }
}
