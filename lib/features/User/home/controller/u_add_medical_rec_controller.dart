import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/show_toast.dart';
import 'package:doctor_app/features/User/home/data/apis.dart';
import 'package:doctor_app/models/med_record/med_record_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../firebase_messaging/firebase_messaging_class.dart';

final uAddMedicalRecControllerProvider =
    StateNotifierProvider<UserAddMedicalTRecordController, bool>((ref) {
  return UserAddMedicalTRecordController(
    homeApis: ref.watch(userHomeApis),
  );
});

/// insert recrd and autodispose

class UserAddMedicalTRecordController extends StateNotifier<bool> {
  final UserHomeApis _homeApis;

  UserAddMedicalTRecordController({required UserHomeApis homeApis})
      : _homeApis = homeApis,
        super(false);

  Future<void> insertMedRecord(
      {required MedRecordModel model,
      required BuildContext context,
      required List<String> images}) async {
    state = true;
    final result = await _homeApis.insertMedRecord(model: model);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      showSnackBar(context, 'Record Added Successfully!');
      Navigator.pop(context);
    });
  }
}
