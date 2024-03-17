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
}
