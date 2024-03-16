import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_providers/global_providers.dart';
import 'package:doctor_app/core/constants/firebase_constants.dart';
import 'package:doctor_app/models/auth/user_model.dart';
import 'package:doctor_app/models/pharmacy_info/pharmacy_info_model.dart';

final databaseApisProvider = Provider<DatabaseApis>((ref) {
  final fireStore = ref.watch(firebaseDatabaseProvider);
  return DatabaseApis(firestore: fireStore);
});

abstract class IDatabaseApis {
  // User Functions
  FutureEitherVoid saveUserInfo({required UserModel userModel});
  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserStream(
      {required String uid});
  Future<DocumentSnapshot> getCurrentUserInfo({required String uid});
  FutureEitherVoid updateFirestoreCurrentUserInfo(
      {required UserModel userModel});
  FutureEitherVoid updateDoctor({
    required List<String> availabiltyDays,
    required String speciality,
  });
  FutureEitherVoid updateCurrentUserInfo({
    required UserModel userModel,
  });
  FutureEitherVoid setUserState({required bool isOnline, required String uid});
  FutureEitherVoid deleteAccount(
      {required String password, required String uid});
  FutureEitherVoid updatePharmacyInfo({
    required PharmacyInfoModel pharmacyInfoModel,
  });
}

class DatabaseApis extends IDatabaseApis {
  final FirebaseFirestore _firestore;
  DatabaseApis({required FirebaseFirestore firestore}) : _firestore = firestore;

  @override
  FutureEitherVoid saveUserInfo({required UserModel userModel}) async {
    try {
      await _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userModel.uid)
          .set(userModel.toMap());
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserStream(
      {required String uid}) {
    return _firestore
        .collection(FirebaseConstants.userCollection)
        .doc(uid)
        .snapshots();
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData = await _firestore
        .collection(FirebaseConstants.userCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  @override
  FutureEitherVoid updateFirestoreCurrentUserInfo(
      {required UserModel userModel}) async {
    try {
      await _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userModel.uid)
          .update(userModel.toMap());
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid updatePharmacyInfo({
    required PharmacyInfoModel pharmacyInfoModel,
  }) async {
    try {
      /// if document is not exist then it will create new document otherwise it will update the existing document
      await _firestore
          .collection(FirebaseConstants.pharmacyCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(pharmacyInfoModel.toMap());
      return const Right(null);
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid updateDoctor(
      {required List<String> availabiltyDays,
      required String speciality}) async {
    try {
      await _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'availableDays': availabiltyDays,
        'speciality': speciality,
      });
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  Future<Either<Failure, void>> deleteAccount(
      {required String password, required String uid}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
        await _firestore
            .collection(FirebaseConstants.userCollection)
            .doc(uid)
            .delete();
        user.delete();
        await user.delete();
        return Right(null);
      } else {
        return Left(Failure('No user signed in.', StackTrace.current));
      }
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Future<DocumentSnapshot> getCurrentUserInfo({required String uid}) async {
    final DocumentSnapshot document = await _firestore
        .collection(FirebaseConstants.userCollection)
        .doc(uid)
        .get();
    return document;
  }

  getUserInfoByUid(String userId) {
    return _firestore
        .collection(FirebaseConstants.userCollection)
        .doc(userId)
        .snapshots()
        .map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  // @override
  // Future<DocumentSnapshot> getsStaffInfo() async {
  //   final DocumentSnapshot document = await _firestore
  //       .collection(FirebaseConstants.ownerCollection)
  //       .doc(FirebaseConstants.staffDocument)
  //       .get();
  //   return document;
  // }

  @override
  FutureEitherVoid setUserState(
      {required bool isOnline, required String uid}) async {
    try {
      await _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(uid)
          .update({
        'isOnline': isOnline,
      });
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid updateCurrentUserInfo({
    required UserModel userModel,
  }) async {
    try {
      await _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userModel.uid)
          .update(userModel.toMap());
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  // FutureEitherVoid saveStaffInfo({required StaffModel staffModel}) async {
  //   try {
  //     await _firestore
  //         .collection(FirebaseConstants.staffCollection)
  //         .doc(staffModel.uid)
  //         .set(staffModel.toMap());
  //     return const Right(null);
  //   } on FirebaseException catch (e, stackTrace) {
  //     return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
  //   } catch (e, stackTrace) {
  //     return Left(Failure(e.toString(), stackTrace));
  //   }
  // }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentPharmacyInfoStream(
      {required String uid}) {
    return _firestore
        .collection(FirebaseConstants.pharmacyCollection)
        .doc(uid)
        .snapshots();
  }

  userData(String userId) {
    return _firestore
        .collection(FirebaseConstants.userCollection)
        .doc(userId)
        .snapshots()
        .map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }
}
