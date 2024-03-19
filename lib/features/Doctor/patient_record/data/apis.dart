import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/core/constants/firebase_constants.dart';
import 'package:doctor_app/models/med_record/med_record_model.dart';
import '../../../../../commons/common_providers/global_providers.dart';

final doctorPatientRecordApis = Provider<DoctorPatientRecordApis>((ref) {
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return DoctorPatientRecordApis(firestore: firestoreProvider);
});

abstract class IDoctorPatientRecordApis {
  Stream<List<MedRecordModel>> watchAllPatientRecord(
      {required String doctorId});
}

class DoctorPatientRecordApis implements IDoctorPatientRecordApis {
  final FirebaseFirestore _firestore;
  DoctorPatientRecordApis({required FirebaseFirestore firestore})
      : _firestore = firestore;

  // insert medical record

  @override
  Stream<List<MedRecordModel>> watchAllPatientRecord({
    required String doctorId,
  }) {
    Query collection = _firestore
        .collection(FirebaseConstants.recordCollection)
        .where('doctorUid', isEqualTo: doctorId)
        .orderBy('createdAt', descending: true);
    return collection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map(
            (doc) => MedRecordModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }
}
