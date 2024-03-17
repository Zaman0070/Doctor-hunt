import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/core/constants/firebase_constants.dart';
import 'package:doctor_app/models/doctor/doctor_model.dart';
import '../../../../../commons/common_providers/global_providers.dart';

final favApisProvider = Provider<UserFavApis>((ref) {
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return UserFavApis(firestore: firestoreProvider);
});

abstract class IUserFavApis {
  Stream<List<DoctorModel>> faveDoctors({required String userId});
}

class UserFavApis implements IUserFavApis {
  final FirebaseFirestore _firestore;
  UserFavApis({required FirebaseFirestore firestore}) : _firestore = firestore;

 


  @override
  Stream<List<DoctorModel>> faveDoctors({required String userId}) {
    Query collection = _firestore
        .collection(FirebaseConstants.doctorCollection)
        .where('favorite', arrayContains: userId)
        .orderBy('createdAt', descending: true);
    return collection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((doc) =>
            DoctorModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }
}
