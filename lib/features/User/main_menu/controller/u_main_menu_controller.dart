import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/features/User/faviourt/view/u_faviourt_view.dart';
import 'package:doctor_app/features/User/home/view/u_home_screen.dart';
import 'package:doctor_app/features/User/pharmacy/view/u_pharmacy_screen.dart';
import 'package:doctor_app/features/chat/view/chat_screen.dart';
import 'package:flutter/material.dart';

import '../../../../commons/common_imports/apis_commons.dart';

final usermainMenuProvider =
    ChangeNotifierProvider((ref) => UserMainMenuController());

class UserMainMenuController extends ChangeNotifier {
  List<Widget> screens = [
    const UserHomeScreen(),
    const UserFaviourtScreen(),
    const UserPharmacyScreen(),
    const ChatScreen(side: "Patient"),
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
