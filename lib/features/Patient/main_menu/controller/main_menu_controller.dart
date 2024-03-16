import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/features/Patient/home/view/patient_home_screen.dart';
import 'package:flutter/material.dart';

import '../../../../commons/common_imports/apis_commons.dart';

final mainMenuProvider = ChangeNotifierProvider((ref) => MainMenuController());

class MainMenuController extends ChangeNotifier {
  List<Widget> screens = [
    const PatientHomeScreen(),
    Container(),
    Container(),
    Container(),
  ];

  int _index = 0;
  int get index => _index;
  late PageController pageController = PageController();
  setIndex(int id) {
    _index = id;
    pageController.jumpToPage(id);
    notifyListeners();
  }
}
