import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';

final userHomeNotifier = ChangeNotifierProvider<UserHomeNotifier>((ref) {
  return UserHomeNotifier();
});

class UserHomeNotifier extends ChangeNotifier {
  TextEditingController textController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  String tags = 'Choose Doctor';

  String doctorUid = '';

  // add tag to list
  void addTag(String tag, String uid) {
    tags = tag;
    doctorUid = uid;
    notifyListeners();
  }

  void updateTextField(String newText) {
    textController.text = newText;
    notifyListeners();
  }

  void updateTagField(String newText) {
    tagController.text = newText;
    notifyListeners();
  }

  bool isTextFieldEmpty() {
    return textController.text.isEmpty;
  }

  bool isTagFieldEmpty() {
    return tagController.text.isEmpty;
  }

  void clear() {
    tagController.clear();
    tags = 'Choose Doctor';
    doctorUid = '';
    notifyListeners();
  }

  FocusNode commentFocusNode = FocusNode();
}
