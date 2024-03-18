import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/core/constants/firebase_constants.dart';
import 'package:doctor_app/models/order/order_model.dart';
import '../../../../../commons/common_providers/global_providers.dart';

final userPharmacyApis = Provider<UserPharmacyApis>((ref) {
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return UserPharmacyApis(firestore: firestoreProvider);
});

abstract class IUserPharmacyApis {
  FutureEitherVoid likeDislikeProduct(
      {required String productId, required String userId});
}

class UserPharmacyApis implements IUserPharmacyApis {
  final FirebaseFirestore _firestore;
  UserPharmacyApis({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  FutureEitherVoid likeDislikeProduct(
      {required String productId, required String userId}) async {
    try {
      final response = await _firestore
          .collection(FirebaseConstants.productCollection)
          .doc(productId)
          .get();
      final data = response.data() as Map<String, dynamic>;
      final likes = data['likes'] as List;
      if (likes.contains(userId)) {
        likes.remove(userId);
      } else {
        likes.add(userId);
      }
      await _firestore
          .collection(FirebaseConstants.productCollection)
          .doc(productId)
          .update({'likes': likes});
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString(), StackTrace.current));
    }
  }

  FutureEitherVoid insertOrder({required OrderModel model}) async {
    try {
      final response = await _firestore
          .collection(FirebaseConstants.orderCollection)
          .add(model.toMap());
      String productId = response.id;
      await response.update({'orderId': productId});
      // ignore: void_checks
      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString(), StackTrace.current));
    }
  }
}
