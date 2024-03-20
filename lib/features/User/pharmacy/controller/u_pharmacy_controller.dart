import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/show_toast.dart';
import 'package:doctor_app/features/User/pharmacy/data/apis.dart';
import 'package:doctor_app/models/order/order_model.dart';
import 'package:doctor_app/models/product/products_model.dart';
import 'package:doctor_app/models/review/review_model.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../firebase_messaging/firebase_messaging_class.dart';

final userPharmacyControllerProvider =
    StateNotifierProvider<UserPharmacyController, bool>((ref) {
  return UserPharmacyController(
    pharmacyApis: ref.watch(userPharmacyApis),
  );
});

final yourOrderStreamProvider =
    StreamProvider.autoDispose<List<OrderModel>>((ref) {
  return ref.watch(userPharmacyControllerProvider.notifier).watchOrderByUid();
});

final watchAllProducts =  StreamProvider.autoDispose<List<ProductModel>>((ref) {
  return ref.watch(userPharmacyControllerProvider.notifier).watchAllProducts();
});


class UserPharmacyController extends StateNotifier<bool> {
  final UserPharmacyApis _pharmacyApis;

  UserPharmacyController({required UserPharmacyApis pharmacyApis})
      : _pharmacyApis = pharmacyApis,
        super(false);

  Future<void> likeDislikeProduct(
      {required String docId, required String userId}) {
    return _pharmacyApis.likeDislikeProduct(productId: docId, userId: userId);
  }

  Future<void> insertOrder({
    required OrderModel model,
    required BuildContext context,
  }) async {
    state = true;

    final result = await _pharmacyApis.insertOrder(model: model);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      showSnackBar(context, 'Order Placed Successfully!');
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.mainMenuScreen, (route) => false);
    });
  }

  Stream<List<OrderModel>> watchOrderByUid() {
    return _pharmacyApis.watchOrderByUid();
  }

  Future<void> addReview(
      {required ReviewModel model,
      required String productId,
      required BuildContext context,required double rating}) async {
    final result =
        await _pharmacyApis.addReview(model: model, productId: productId,rating: rating);
    result.fold((l) {
      showSnackBar(context, l.message);
    }, (r) {
      showSnackBar(context, 'Review Added Successfully!');
      Navigator.pop(context);
    });
  }

  Future<double> findRating({required String productId}) async {
    final result = await _pharmacyApis.findRating(productId: productId);
    return result;
  }

  Stream<List<ProductModel>> watchAllProducts() {
    return _pharmacyApis.watchAllProducts();
  }
}
