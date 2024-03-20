import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/core/constants/firebase_constants.dart';
import 'package:doctor_app/models/order/order_model.dart';
import 'package:doctor_app/models/product/products_model.dart';
import 'package:doctor_app/models/review/review_model.dart';
import '../../../../../commons/common_providers/global_providers.dart';

final userPharmacyApis = Provider<UserPharmacyApis>((ref) {
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return UserPharmacyApis(firestore: firestoreProvider);
});

abstract class IUserPharmacyApis {
  FutureEitherVoid likeDislikeProduct(
      {required String productId, required String userId});
  FutureEitherVoid insertOrder({required OrderModel model});
  Stream<List<OrderModel>> watchOrderByUid();
  Future<Either<Failure, void>> addReview(
      {required ReviewModel model,
      required String productId,
      required double rating});
  Future<double> findRating({required String productId});
  Stream<List<ProductModel>> watchAllProducts();
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

  @override
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

  @override
  Stream<List<OrderModel>> watchOrderByUid() {
    Query collection = _firestore
        .collection(FirebaseConstants.orderCollection)
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('createdAt', descending: true);
    return collection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  @override
  Future<Either<Failure, void>> addReview({
    required ReviewModel model,
    required String productId,
    required double rating,
  }) async {
    try {
      final response = await _firestore
          .collection(FirebaseConstants.productCollection)
          .doc(productId)
          .collection(FirebaseConstants.reviewCollection)
          .add(model.toMap());
      await _firestore
          .collection(FirebaseConstants.productCollection)
          .doc(productId)
          .update({'rating': rating});
      final reviewId = response.id;
      await response.update({'id': reviewId});
      return const Right(null);
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  /// find rating
  @override
  Future<double> findRating({required String productId}) async {
    try {
      final response = await _firestore
          .collection(FirebaseConstants.productCollection)
          .doc(productId)
          .get();
      final data = response.data() as Map<String, dynamic>;
      if (data.isEmpty) {
        return 0.0;
      }
      final rating = data['rating'];
      print(rating.toString() + 'djkfhkjd');
      return rating;
    } catch (e) {
      print(e.toString() + 'fkjffjbfjfb');
      return 0.0;
    }
  }

  @override
  Stream<List<ProductModel>> watchAllProducts() {
    Query collection = _firestore
        .collection(FirebaseConstants.productCollection)
        .orderBy('createdAt', descending: true);
    return collection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }
}
