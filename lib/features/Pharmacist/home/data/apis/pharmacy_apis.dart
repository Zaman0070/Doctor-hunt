import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_providers/global_providers.dart';
import 'package:doctor_app/core/constants/firebase_constants.dart';
import 'package:doctor_app/models/product/products_model.dart';

final pharmacyApisProvider = Provider<PharmacyApis>((ref) {
  final fireStore = ref.watch(firebaseDatabaseProvider);
  return PharmacyApis(firestore: fireStore);
});

abstract class IPharmacyApis {
  FutureEitherVoid insertProduct({required ProductModel model});
  Stream<List<ProductModel>> watchProductById({required String userId});
  FutureEitherVoid updateProduct({required ProductModel model});
  FutureEitherVoid deleteProduct({required String productId});

}

class PharmacyApis implements IPharmacyApis {
  final FirebaseFirestore _firestore;
  PharmacyApis({required FirebaseFirestore firestore}) : _firestore = firestore;
  @override
  FutureEitherVoid insertProduct({required ProductModel model}) async {
    try {
      final response = await _firestore
          .collection(FirebaseConstants.productCollection)
          .add(model.toMap());
      String productId = response.id;
      await response.update({'productId': productId});
      // ignore: void_checks
      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString(), StackTrace.current));
    }
  }

  /// watch all by productid
  @override
  Stream<List<ProductModel>> watchProductById({required String userId}) {
    Query collection = _firestore
        .collection(FirebaseConstants.productCollection)
        .where('uid', isEqualTo: userId)
        .orderBy('createdAt', descending: true);
    return collection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  // update product
  @override
  FutureEitherVoid updateProduct({required ProductModel model}) async {
    try {
      await _firestore
          .collection(FirebaseConstants.productCollection)
          .doc(model.productId)
          .update(model.toMap());
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString(), StackTrace.current));
    }
  }

  /// delete product 
  @override
  FutureEitherVoid deleteProduct({required String productId}) async {
    try {
      await _firestore
          .collection(FirebaseConstants.productCollection)
          .doc(productId)
          .delete();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString(), StackTrace.current));
    }
  }

  // watch order by uid
 
}
