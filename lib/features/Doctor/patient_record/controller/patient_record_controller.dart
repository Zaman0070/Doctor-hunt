import 'package:doctor_app/features/Doctor/patient_record/data/apis.dart';
import 'package:doctor_app/models/med_record/med_record_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../firebase_messaging/firebase_messaging_class.dart';

final doctorRecordControllerProvider =
    StateNotifierProvider<DoctorRecordPatientController, bool>((ref) {
  return DoctorRecordPatientController(
    recordApis: ref.watch(doctorPatientRecordApis),
  );
});

final watchAllPatientRecordStreamProvider =
    StreamProvider.family<List<MedRecordModel>, String>((ref, String doctorId) {
  final addPostController = ref.watch(doctorRecordControllerProvider.notifier);
  return addPostController.watchAllPatientRecord(doctorId: doctorId);
});

/// insert recrd and autodispose

class DoctorRecordPatientController extends StateNotifier<bool> {
  final DoctorPatientRecordApis _recordApis;

  DoctorRecordPatientController({required DoctorPatientRecordApis recordApis})
      : _recordApis = recordApis,
        super(false);

  Stream<List<MedRecordModel>> watchAllPatientRecord(
      {required String doctorId}) {
    return _recordApis.watchAllPatientRecord(doctorId: doctorId);
  }
}
