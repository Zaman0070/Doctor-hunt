import 'package:doctor_app/features/User/home/data/apis.dart';
import 'package:doctor_app/models/doctor/doctor_model.dart';
import 'package:doctor_app/models/product/products_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  Stream<List<DoctorModel>> findAllDoctorStream({String? searchQuery}) {
    return _homeApis.findAllDoctorStream(searchQuery: searchQuery);
  }

   Stream<List<ProductModel>> findAllMedStream({String? searchQuery}) {
    return _homeApis.findAllMedStream(searchQuery: searchQuery);
  }



  Stream<bool> checkExistConverstion({required String doctorId}) {
    return _homeApis.checkExistConverstion(doctorId: doctorId);
  }
}
