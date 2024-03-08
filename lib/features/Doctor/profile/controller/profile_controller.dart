import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileNotifierCtr =
    ChangeNotifierProvider((ref) => ProdileNotiController());



class ProdileNotiController extends ChangeNotifier {
 bool isDeleteAccount = false;
  bool get getIsDeleteAccount => isDeleteAccount;
  setIsDeleteAccount(bool value) {
    isDeleteAccount = value;
    notifyListeners();
  }
}
