import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/core/constants/firebase_constants.dart';
import 'package:doctor_app/models/doctor/doctor_model.dart';
import 'package:doctor_app/models/product/products_model.dart';
import '../../../../../commons/common_providers/global_providers.dart';

final userHomeApis = Provider<UserHomeApis>((ref) {
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return UserHomeApis(firestore: firestoreProvider);
});

abstract class IUserHomeApis {
  Stream<List<DoctorModel>> watchAllPopularDoctor();
  FutureEitherVoid likeDislikeDoctor(
      {required String docId, required String userId});
  Stream<List<DoctorModel>> faveDoctors({required String userId});
  Stream<List<DoctorModel>> findAllDoctorStream({String? searchQuery});
  Stream<List<ProductModel>> findAllMedStream({String? searchQuery});
}

class UserHomeApis implements IUserHomeApis {
  final FirebaseFirestore _firestore;
  UserHomeApis({required FirebaseFirestore firestore}) : _firestore = firestore;

  @override
  Stream<List<DoctorModel>> watchAllPopularDoctor() {
    Query collection = _firestore
        .collection(FirebaseConstants.doctorCollection)
        .orderBy('rating', descending: true);
    return collection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((doc) => DoctorModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  @override
  FutureEitherVoid likeDislikeDoctor(
      {required String docId, required String userId}) async {
    try {
      final response = await _firestore
          .collection(FirebaseConstants.doctorCollection)
          .doc(docId)
          .get();
      final data = response.data() as Map<String, dynamic>;
      final likes = data['favorite'] as List;
      if (likes.contains(userId)) {
        likes.remove(userId);
      } else {
        likes.add(userId);
      }
      await _firestore
          .collection(FirebaseConstants.doctorCollection)
          .doc(docId)
          .update({'favorite': likes});
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString(), StackTrace.current));
    }
  }

  @override
  Stream<List<DoctorModel>> faveDoctors({required String userId}) {
    Query collection = _firestore
        .collection(FirebaseConstants.doctorCollection)
        .where('favorite', arrayContains: userId)
        .orderBy('createdAt', descending: true);
    return collection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((doc) => DoctorModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  @override
  Stream<List<DoctorModel>> findAllDoctorStream({String? searchQuery}) {
    Query collection =
        _firestore.collection(FirebaseConstants.doctorCollection);

    if (searchQuery != null && searchQuery.isNotEmpty) {
      collection = collection
          .where('name', isGreaterThanOrEqualTo: searchQuery)
          .where('name', isLessThanOrEqualTo: '$searchQuery\uf7ff');
    }
    return collection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((doc) => DoctorModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  @override
  Stream<List<ProductModel>> findAllMedStream({String? searchQuery}) {
    Query collection =
        _firestore.collection(FirebaseConstants.productCollection);

    if (searchQuery != null && searchQuery.isNotEmpty) {
      collection = collection
          .where('productName', isGreaterThanOrEqualTo: searchQuery)
          .where('productName', isLessThanOrEqualTo: '$searchQuery\uf7ff');
    }
    return collection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Stream<bool> checkExistConverstion({required String doctorId}) {
    return _firestore
        .collection(FirebaseConstants.userCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(doctorId)
        .snapshots()
        .map((querySnapshot) => querySnapshot.exists);
  }
}
