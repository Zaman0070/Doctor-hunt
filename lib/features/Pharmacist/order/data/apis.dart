import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/core/constants/firebase_constants.dart';
import 'package:doctor_app/models/order/order_model.dart';
import 'package:doctor_app/models/product/products_model.dart';
import 'package:doctor_app/models/review/review_model.dart';
import '../../../../../commons/common_providers/global_providers.dart';

final pharmistOrderApis = Provider<PharmistOrderApis>((ref) {
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return PharmistOrderApis(firestore: firestoreProvider);
});

abstract class IPharmistOrderApis {
  Stream<List<OrderModel>> watchAllOrder({required String productUuid});
  Stream<List<OrderModel>> watchOrderByStatus(
      {required String productUuid, required String status});
  FutureEitherVoid updateOrderStatus(
      {required String orderId, required String status, required int date});
  Stream<ProductModel> watchProductById({required String productId});
  Stream<List<ReviewModel>> watchAllReview({required String productId});
}

class PharmistOrderApis implements IPharmistOrderApis {
  final FirebaseFirestore _firestore;
  PharmistOrderApis({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Stream<List<OrderModel>> watchAllOrder({required String productUuid}) {
    Query collection = _firestore
        .collection(FirebaseConstants.orderCollection)
        .where('productUuid', isEqualTo: productUuid)
        .orderBy('createdAt', descending: true);
    return collection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  @override
  Stream<List<OrderModel>> watchOrderByStatus(
      {required String productUuid, required String status}) {
    Query collection = _firestore
        .collection(FirebaseConstants.orderCollection)
        .where('productUuid', isEqualTo: productUuid)
        .where("orderStatus", isEqualTo: status)
        .orderBy('createdAt', descending: true);
    return collection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  @override
  FutureEitherVoid updateOrderStatus(
      {required String orderId,
      required String status,
      required int date}) async {
    try {
      await _firestore
          .collection(FirebaseConstants.orderCollection)
          .doc(orderId)
          .update({'orderStatus': status, "deliveredDate": date});
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString(), StackTrace.current));
    }
  }

  @override
  Stream<ProductModel> watchProductById({required String productId}) {
    return _firestore
        .collection(FirebaseConstants.productCollection)
        .doc(productId)
        .snapshots()
        .map((doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>));
  }

  // watch all review
  @override
  Stream<List<ReviewModel>> watchAllReview({required String productId}) {
    Query collection = _firestore
        .collection(FirebaseConstants.productCollection)
        .doc(productId)
        .collection(FirebaseConstants.reviewCollection)
        .orderBy('createdAt', descending: true);
    return collection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((doc) => ReviewModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }
}
