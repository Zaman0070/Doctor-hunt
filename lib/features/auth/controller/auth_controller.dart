import 'dart:math';

import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/show_toast.dart';
import 'package:doctor_app/features/auth/data/auth_apis/auth_apis.dart';
import 'package:doctor_app/features/auth/data/auth_apis/database_apis.dart';
import 'package:doctor_app/firebase_messaging/firebase_messaging_class.dart';
import 'package:doctor_app/models/auth/user_model.dart';
import 'package:doctor_app/models/pharmacy_info/pharmacy_info_model.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../commons/common_functions/upload_image_to_firebase.dart';
import '../../../core/constants/firebase_constants.dart';
// import '../../../firebase_messaging/firebase_messaging_class.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authApis: ref.watch(authApisProvider),
    databaseApis: ref.watch(databaseApisProvider),
  );
});

final userStateStreamProvider = StreamProvider((ref) {
  final authProvider = ref.watch(authControllerProvider.notifier);
  return authProvider.getSigninStatusOfUser();
});

// final getAllUsersStreamProvider = StreamProvider((ref) {
//   final authProvider = ref.watch(authControllerProvider.notifier);
//   return authProvider.getAllUsers();
// });

final currentUserAuthProvider = FutureProvider((ref) {
  final authCtr = ref.watch(authControllerProvider.notifier);
  return authCtr.currentUser();
});
final currentUserModelData = FutureProvider((ref) {
  final authCtr = ref.watch(authControllerProvider.notifier);
  return authCtr.getCurrentUserInfo();
});

final fetchUserByIdProvider = StreamProvider.family((ref, String uid) {
  final profileController = ref.watch(authControllerProvider.notifier);
  return profileController.getUserInfoByUid(uid);
});

final currentAuthUserinfoStreamProvider =
    StreamProvider.family((ref, String uid) {
  final profileController = ref.watch(authControllerProvider.notifier);
  return profileController.getCurrentUserInfoStream(uid: uid);
});

final currentPharmacyInfoStreamProvider = StreamProvider((ref) {
  final profileController = ref.watch(authControllerProvider.notifier);
  return profileController.getCurrentPharmacyInfo();
});

class AuthController extends StateNotifier<bool> {
  final AuthApis _authApis;
  final DatabaseApis _databaseApis;

  AuthController(
      {required AuthApis authApis, required DatabaseApis databaseApis})
      : _authApis = authApis,
        _databaseApis = databaseApis,
        super(false);

  Future<User?> currentUser() async {
    return _authApis.getCurrentUser();
  }

  Future<void> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String phone,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _authApis.registerWithEmailAndPass(
        email: email, password: password);

    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      UserModel userModel = UserModel(
        uid: r.uid,
        name: name,
        email: email,
        profileImage: '',
        createdAt: DateTime.now(),
        fcmToken: '',
        isOnline: false,
        isType: 'patient',
        availableDays: [],
        speciality: '',
        id: Random().nextInt(100000).toString(),
      );
      final result2 = await _databaseApis.saveUserInfo(userModel: userModel);
      result2.fold((l) {
        state = false;
        debugPrintStack(stackTrace: l.stackTrace);
        debugPrint(l.message);
        showToast(msg: l.message);
      }, (r) async {
        state = false;
        Navigator.pushNamed(context, AppRoutes.signInScreen,
            arguments: {'accountType': 'Patient'});
        showToast(msg: 'Account Created Successfully!');
      });
    });
  }

  bool hasLastName(String fullName) {
    int num = fullName.split(' ').length;
    return num > 1 ? true : false;
  }

  // Update User Information
  Future<void> updateCurrentUserInfo({
    required BuildContext context,
    required UserModel userModel,
    String? newImagePath,
    required String oldImage,
  }) async {
    state = true;
    String image = newImagePath != null
        ? await uploadXImage(XFile(newImagePath),
            storageFolderName: FirebaseConstants.ownerCollection)
        : oldImage;

    UserModel model = userModel.copyWith(profileImage: image);

    final result = await _authApis.updateCurrentUserInfo(
        name: userModel.name, email: userModel.email, image: image);

    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      final result2 =
          await _databaseApis.updateFirestoreCurrentUserInfo(userModel: model);
      result2.fold((l) {
        state = false;
        showSnackBar(context, l.message);
      }, (r) {
        state = false;
        showSnackBar(context, 'Profile Updated Successfully');
        // Navigator.pushNamedAndRemoveUntil(context, AppRoutes.userMainMenuScreen, (route) => false);
      });
    });
  }

  Future<void> updateDoctorInfo({
    required BuildContext context,
    required List<String> availabiltyDays,
    required String speciality,
  }) async {
    state = true;
    UserModel userModel = await getCurrentUserInfo();
    UserModel model = userModel.copyWith(
      availableDays: availabiltyDays,
      speciality: speciality,
    );
    final result = await _databaseApis.updateFirestoreCurrentUserInfo(
      userModel: model,
    );
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      showSnackBar(context, 'Profile Updated Successfully');
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.doctoMainMenuScreen, (route) => false);
    });
  }

  Future<void> updatePharmacyInfo({
    required BuildContext context,
    required PharmacyInfoModel model,
  }) async {
    state = true;
    final result =
        await _databaseApis.updatePharmacyInfo(pharmacyInfoModel: model);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
    });
  }

  // get current pharmacy info
  Stream<PharmacyInfoModel> getCurrentPharmacyInfo() {
    final userId = _authApis.getCurrentUser();
    return _databaseApis
        .getCurrentPharmacyInfoStream(uid: userId!.uid)
        .map((items) {
      PharmacyInfoModel pharmacyInfoModel =
          PharmacyInfoModel.fromMap(items.data()!);
      return pharmacyInfoModel;
    });
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
    required String accountType,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _authApis.signInWithEmailAndPass(
        email: email, password: password);

    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      state = false;
      UserModel userModel = await getCurrentUserInfo();
      await fcmTokenUpload(userModel: userModel);
      if (mounted) {
        accountType == 'Doctor'
            ? Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.availabiltyScreen, (route) => false)
            : Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.mainMenuScreen, (route) => false);
      }
    });
  }

  // Change Password
  Future<void> changeUserPassword({
    required String currentPass,
    required String newPass,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _authApis.changePassword(
        currentPassword: currentPass, newPassword: newPass);
    state = false;
    result.fold((l) {
      showToast(msg: l.message);
    }, (r) {
      Navigator.pop(context);
      showToast(msg: 'Password changed successfully!');
    });
  }

  Stream<UserModel> getCurrentUserInfoStream({required String uid}) {
    return _databaseApis.getCurrentUserStream(uid: uid).map((items) {
      UserModel userModel = UserModel.fromMap(items.data()!);
      return userModel;
    });
  }

  Stream<UserModel> getCurrentUserInfoStreamData() {
    final userId = _authApis.getCurrentUser();
    return _databaseApis.getCurrentUserStream(uid: userId!.uid).map((items) {
      UserModel userModel = UserModel.fromMap(items.data()!);
      return userModel;
    });
  }

  Future<UserModel> getCurrentUserInfo() async {
    final userId = _authApis.getCurrentUser();
    final result = await _databaseApis.getCurrentUserInfo(uid: userId!.uid);
    UserModel userModel =
        UserModel.fromMap(result.data() as Map<String, dynamic>);
    return userModel;
  }

  Future<UserModel> getUserInfoByUidFuture(String uid) async {
    final result = await _databaseApis.getCurrentUserInfo(uid: uid);
    UserModel userModel =
        UserModel.fromMap(result.data() as Map<String, dynamic>);
    return userModel;
  }

  Stream<UserModel> getUserInfoByUid(String userId) {
    return _databaseApis.getUserInfoByUid(userId);
  }

  // LogOut User
  Future<void> logout({
    required BuildContext context,
  }) async {
    state = true;
    //await GoogleSignIn().signOut();
    final result = await _authApis.logout();
    result.fold((l) {
      state = false;
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.signInScreen, (route) => false);
    });
  }

  Future<void> deleteAccount({
    required BuildContext context,
    required String password,
  }) async {
    state = true;
    final user = _authApis.getCurrentUser();
    if (user == null) {
      state = false;
      return;
    }
    final uid = user.uid;
    final result2 =
        await _databaseApis.deleteAccount(uid: uid, password: password);
    result2.fold((l) {
      state = false;
      showSnackBar(context, l.message);
      return;
    }, (r) {
      state = false;
      showSnackBar(context, 'Account Deleted Successfully!');
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.signInScreen, (route) => false);
    });
  }

  // Future<void> deleteAccount({
  //   required BuildContext context,
  // }) async {
  //   state = true;
  //   final result = await _authApis.deleteAccount();
  //   result.fold((l) {
  //     state = false;
  //     debugPrintStack(stackTrace: l.stackTrace);
  //     debugPrint(l.message);
  //     showSnackBar(context, l.message);
  //   }, (r) {
  //     state = false;
  //     Navigator.pushNamedAndRemoveUntil(
  //         context, AppRoutes.signInScreen, (route) => false);
  //   });
  // }

  Future<void> fcmTokenUpload({required UserModel userModel}) async {
    MessagingFirebase messagingFirebase = MessagingFirebase();
    String token = await messagingFirebase.getFcmToken();

    if (userModel.fcmToken == token) {
      return; // if will return if device token and token on firebase are same
    }

    userModel = userModel.copyWith(fcmToken: token);

    final result = await _databaseApis.updateFirestoreCurrentUserInfo(
        userModel: userModel);

    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message.toString());
    }, (r) async {
      debugPrint("Fcm Updated");
    });
  }

  // getSigninStatusOfUser
  Stream<User?> getSigninStatusOfUser() {
    return _authApis.getSigninStatusOfUser();
  }

  Future<void> forgetPassword({required String email}) async {
    state = true;
    final result = await _authApis.forgetPassword(email: email);
    result.fold((l) {
      state = false;
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
      showToast(msg: l.message);
    }, (r) {
      state = false;
      showToast(msg: 'Password reset link sent to your email!');
    });
  }
}
