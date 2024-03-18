import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/features/Pharmacist/order/data/apis.dart';
import 'package:doctor_app/models/order/order_model.dart';
import 'package:doctor_app/models/product/products_model.dart';
import 'package:doctor_app/models/review/review_model.dart';
// import '../../../firebase_messaging/firebase_messaging_class.dart';

final pharmistOrderControllerProvider =
    StateNotifierProvider<PharmistOrderController, bool>((ref) {
  return PharmistOrderController(
    orderApis: ref.watch(pharmistOrderApis),
  );
});

final watchAllOrderByIdProvider = StreamProvider.autoDispose
    .family<List<OrderModel>, String>((ref, productUuid) {
  return ref
      .watch(pharmistOrderControllerProvider.notifier)
      .watchAllOrder(productUuid: productUuid);
});

final watchOrderByStatus =
    StreamProvider.autoDispose.family<List<OrderModel>, String>((ref, status) {
  return ref
      .watch(pharmistOrderControllerProvider.notifier)
      .watchProcessingOrder(status: status);
});

final watchProductByIdProvider =
    StreamProvider.autoDispose.family<ProductModel, String>((ref, productId) {
  return ref
      .watch(pharmistOrderControllerProvider.notifier)
      .watchProductById(productId: productId);
});

final watchAllReviewProvider = StreamProvider.autoDispose
    .family<List<ReviewModel>, String>((ref, productId) {
  return ref
      .watch(pharmistOrderControllerProvider.notifier)
      .watchAllReview(productId: productId);
});

class PharmistOrderController extends StateNotifier<bool> {
  final PharmistOrderApis _orderApis;
  PharmistOrderController({required PharmistOrderApis orderApis})
      : _orderApis = orderApis,
        super(false);

  // watch all by productUuid
  Stream<List<OrderModel>> watchAllOrder({required String productUuid}) {
    return _orderApis.watchAllOrder(productUuid: productUuid);
  }

  Stream<ProductModel> watchProductById({required String productId}) {
    return _orderApis.watchProductById(productId: productId);
  }

  Stream<List<ReviewModel>> watchAllReview({required String productId}) {
    return _orderApis.watchAllReview(productId: productId);
  }

  Stream<List<OrderModel>> watchProcessingOrder({required String status}) {
    return _orderApis.watchOrderByStatus(
        productUuid: FirebaseAuth.instance.currentUser!.uid, status: status);
  }

  Future<void> updateOrderStatus(
      {required String orderId,
      required String status,
      required int date}) async {
    state = true;
    final result = await _orderApis.updateOrderStatus(
        orderId: orderId, status: status, date: date);
    result.fold((l) {
      state = false;
    }, (r) {
      state = false;
    });
  }
}
