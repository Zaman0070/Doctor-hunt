import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/show_toast.dart';
import 'package:doctor_app/features/User/pharmacy/data/apis.dart';
import 'package:doctor_app/models/order/order_model.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../firebase_messaging/firebase_messaging_class.dart';

final userPharmacyControllerProvider =
    StateNotifierProvider<UserPharmacyController, bool>((ref) {
  return UserPharmacyController(
    pharmacyApis: ref.watch(userPharmacyApis),
  );
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
}
