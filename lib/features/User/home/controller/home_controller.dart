import 'package:doctor_app/commons/common_functions/upload_image_to_firebase.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/show_toast.dart';
import 'package:doctor_app/core/constants/firebase_constants.dart';
import 'package:doctor_app/features/User/home/data/apis.dart';
import 'package:doctor_app/models/doctor/doctor_model.dart';
import 'package:doctor_app/models/med_record/med_record_model.dart';
import 'package:doctor_app/models/product/products_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

// import '../../../firebase_messaging/firebase_messaging_class.dart';

final homeControllerProvider =
    StateNotifierProvider<HomeController, bool>((ref) {
  return HomeController(
    homeApis: ref.watch(userHomeApis),
  );
});

final watchAllPopularDoctorStream =
    StreamProvider.autoDispose<List<DoctorModel>>((ref) {
  final homeController = ref.watch(homeControllerProvider.notifier);
  return homeController.watchAllPopularDoctorStream();
});

final watchAllFavDoctorStreamProvider =
    StreamProvider.family<List<DoctorModel>, String>((ref, String userId) {
  final communityWallController = ref.watch(homeControllerProvider.notifier);
  return communityWallController.faveDoctors(userId: userId);
});

final findAllDoctorStreamProvider =
    StreamProvider.family<List<DoctorModel>, String?>(
        (ref, String? searchQuery) {
  final addPostController = ref.watch(homeControllerProvider.notifier);
  return addPostController.findAllDoctorStream(searchQuery: searchQuery);
});

final findAllMedStreamProvider =
    StreamProvider.family<List<ProductModel>, String?>(
        (ref, String? searchQuery) {
  final addPostController = ref.watch(homeControllerProvider.notifier);
  return addPostController.findAllMedStream(searchQuery: searchQuery);
});

final watchAllMedRecordStreamProvider =
    StreamProvider.family<List<MedRecordModel>, String>((ref, String uid) {
  final addPostController = ref.watch(homeControllerProvider.notifier);
  return addPostController.watchAllMedRecord(uid: uid);
});

/// insert recrd and autodispose


class HomeController extends StateNotifier<bool> {
  final UserHomeApis _homeApis;

  HomeController({required UserHomeApis homeApis})
      : _homeApis = homeApis,
        super(false);

  Stream<List<DoctorModel>> watchAllPopularDoctorStream() {
    return _homeApis.watchAllPopularDoctor();
  }

  Future<void> likeDislikeDoctor(
      {required String docId, required String userId}) {
    return _homeApis.likeDislikeDoctor(docId: docId, userId: userId);
  }

  Stream<List<DoctorModel>> faveDoctors({required String userId}) {
    return _homeApis.faveDoctors(userId: userId);
  }

  Stream<List<MedRecordModel>> watchAllMedRecord({required String uid}) {
    return _homeApis.watchAllMedRecord(uid: uid);
  }

  Stream<List<DoctorModel>> findAllDoctorStream({String? searchQuery}) {
    return _homeApis.findAllDoctorStream(searchQuery: searchQuery);
  }

  Stream<List<ProductModel>> findAllMedStream({String? searchQuery}) {
    return _homeApis.findAllMedStream(searchQuery: searchQuery);
  }

  Stream<bool> checkExistConverstion({required String doctorId}) {
    return _homeApis.checkExistConverstion(doctorId: doctorId);
  }

  Future<void> insertMedRecord(
      {required MedRecordModel model,
      required BuildContext context,
      required List<String> images}) async {
    state = true;
    List<XFile> xFiles = images.map((path) => XFile(path)).toList();
    List<String> image = await uploadImages(xFiles,
        storageFolderName: FirebaseConstants.ownerCollection);
    MedRecordModel medRecordModel = model.copyWith(recImageUrl: image);
    final result = await _homeApis.insertMedRecord(model: medRecordModel);
    result.fold((l) {
      showSnackBar(context, l.message);
    }, (r) {
      showSnackBar(context, 'Record Added Successfully!');
      Navigator.pop(context);
    });
  }
}
