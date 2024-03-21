import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/features/Doctor/home/view/d_home_screen.dart';
import 'package:doctor_app/features/Doctor/patient_record/view/d_patient_record_scree.dart';
import 'package:doctor_app/features/Doctor/profile/view/d_profile_screen.dart';
import 'package:doctor_app/features/chat/view/chat_screen.dart';

import '../../../../commons/common_imports/apis_commons.dart';

final dmainMenuProvider =
    ChangeNotifierProvider((ref) => DoctorMainMenuController());

class DoctorMainMenuController extends ChangeNotifier {
  List<Widget> screens = [
    const DoctorHomeScreen(),
    const ChatScreen(side: "Doctor"),
    const DoctorPatientRecordScreen(),
    const DoctorProfileScreen(),
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
