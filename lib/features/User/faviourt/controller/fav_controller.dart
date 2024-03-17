import 'package:doctor_app/features/User/faviourt/data/apis.dart';
import 'package:doctor_app/models/doctor/doctor_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../firebase_messaging/firebase_messaging_class.dart';

final favControllerProvider = StateNotifierProvider<FavController, bool>((ref) {
  return FavController(
    favApis: ref.watch(favApisProvider),
  );
});

final watchAllFavDoctorStreamProvider =
    StreamProvider.family<List<DoctorModel>, String>((ref, String userId) {
  final communityWallController = ref.watch(favControllerProvider.notifier);
  return communityWallController.faveDoctors(userId: userId);
});

class FavController extends StateNotifier<bool> {
  final UserFavApis _favApis;

  FavController({required UserFavApis favApis})
      : _favApis = favApis,
        super(false);

  Stream<List<DoctorModel>> faveDoctors({required String userId}) {
    return _favApis.faveDoctors(userId: userId);
  }
}
