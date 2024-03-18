import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/features/Pharmacist/home/view/p_home_screen.dart';
import 'package:doctor_app/features/Pharmacist/order/view/p_order_screen.dart';
import 'package:doctor_app/features/Pharmacist/profile/view/p_profile_screen.dart';

import '../../../../commons/common_imports/apis_commons.dart';

final pmainMenuProvider = ChangeNotifierProvider((ref) => MainMenuController());

class MainMenuController extends ChangeNotifier {
  List<Widget> screens = [
    const PHomeScreen(),
    const PharmistOrderScreen(),
    const PProfileScreen(),
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
