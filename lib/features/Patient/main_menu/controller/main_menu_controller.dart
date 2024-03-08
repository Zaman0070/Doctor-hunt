import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/features/Doctor/doc/view/doc_view.dart';
import 'package:doctor_app/features/Doctor/profile/view/d_profile_screen.dart';
import 'package:doctor_app/features/Patient/home/view/patient_home_screen.dart';

import '../../../../commons/common_imports/apis_commons.dart';

final mainMenuProvider = ChangeNotifierProvider((ref) => MainMenuController());

class MainMenuController extends ChangeNotifier {
  List<Widget> screens = [
    const PatientHomeScreen(),
    const DocumentScreen(),
    const DProfileScreen(),
    const DProfileScreen(),
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
