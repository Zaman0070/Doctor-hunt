import 'package:doctor_app/commons/common_functions/upload_image_to_firebase.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/show_toast.dart';
import 'package:doctor_app/core/constants/firebase_constants.dart';
import 'package:doctor_app/features/Pharmacist/home/data/apis/pharmacy_apis.dart';
import 'package:doctor_app/models/product/products_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
// import '../../../firebase_messaging/firebase_messaging_class.dart';

final pharmacyControllerProvider =
    StateNotifierProvider<PharmacyController, bool>((ref) {
  return PharmacyController(
    pharmacyApis: ref.watch(pharmacyApisProvider),
  );
});

final watchProductByIdProvider = StreamProvider.autoDispose
    .family<List<ProductModel>, String>((ref, userId) {
  return ref.watch(pharmacyApisProvider).watchProductById(userId: userId);
});

class PharmacyController extends StateNotifier<bool> {
  final PharmacyApis _pharmacyApis;
  PharmacyController({required PharmacyApis pharmacyApis})
      : _pharmacyApis = pharmacyApis,
        super(false);

  Future<void> insertProduct({
    required ProductModel model,
    required BuildContext context,
    required String newImagePath,
  }) async {
    state = true;
    String image = await uploadXImage(XFile(newImagePath),
        storageFolderName: FirebaseConstants.ownerCollection);
    ProductModel productModel = model.copyWith(productImage: image);
    final result = await _pharmacyApis.insertProduct(model: productModel);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      showSnackBar(context, 'Product Creat Successfully!');
      Navigator.pop(context);
    });
  }

  // watch all by productid
  Stream<List<ProductModel>> watchProductById({required String userId}) {
    return _pharmacyApis.watchProductById(userId: userId);
  }

  // update
  Future<void> updateProduct({
    required ProductModel model,
    required BuildContext context,
    required String newImagePath,
  }) async {
    state = true;
    String image = await uploadXImage(XFile(newImagePath),
        storageFolderName: FirebaseConstants.ownerCollection);
    ProductModel productModel = model.copyWith(productImage: image);
    final result = await _pharmacyApis.updateProduct(model: productModel);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      showSnackBar(context, 'Product Update Successfully!');
      Navigator.pop(context);
    });
  }
}
