
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_providers/global_providers.dart';

final authApisProvider = Provider<AuthApis>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return AuthApis(auth: auth);
});

abstract class IAuthApis {
  FutureEither<User> registerWithEmailAndPass(
      {required String email, required String password});
  FutureEither<User> signInWithEmailAndPass(
      {required String email, required String password});
  FutureEitherVoid changePassword(
      {required String currentPassword, required String newPassword});
  FutureEither<OAuthCredential> signInWithGoogle({required bool isIOS});
  FutureEitherVoid updateCurrentUserInfo({
    required String name,
    required String email,
    required String image,
  });
  FutureEitherVoid logout();
  User? getCurrentUser();
  Stream<User?> getSigninStatusOfUser();
  FutureEitherVoid deleteAccount(String password);
  FutureEitherVoid forgetPassword({required String email});
  
}

class AuthApis implements IAuthApis {
  final FirebaseAuth _auth;
  AuthApis({required FirebaseAuth auth}) : _auth = auth;

  @override
  FutureEitherVoid logout() async {
    try {
      final response = await _auth.signOut();
      return Right(response);
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(String password) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
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

  

  // delete account

  @override
  // FutureEither<OAuthCredential> signInWithGoogle({required bool isIOS}) async {
  // try {
  // final GoogleSignInAccount? googleUser =
  //     isIOS ? await GoogleSignIn(
  //   clientId:
  //   '201535661836-ahfe9gta8t1c2mteg9gpqt04pfb9c1rn.apps.googleusercontent.com',
  //   scopes: ['email', 'profile'],
  //   hostedDomain: '',
  // ).signIn()
  //     : await GoogleSignIn().signIn();

  // final GoogleSignInAuthentication? googleAuth =
  // await googleUser?.authentication;

  // final credential = GoogleAuthProvider.credential(
  //   accessToken: googleAuth?.accessToken,
  //   idToken: googleAuth?.idToken,
  // );
  // return Right(credential);
  // return Text(data);
  // } on FirebaseAuthException catch (e, stackTrace) {
  // return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
  // } catch (e, stackTrace) {
  // return Left(Failure(e.toString(), stackTrace));
  // }
  // }

  @override
  FutureEitherVoid updateCurrentUserInfo({
    required String name,
    required String email,
    required String image,
  }) async {
    try {
      await _auth.currentUser!.updateDisplayName(name);
      await _auth.currentUser!.updateEmail(email);
      return const Right(null);
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  





  @override
  FutureEither<User> signInWithEmailAndPass(
      {required String email, required String password}) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return Right(response.user!);
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<User> registerWithEmailAndPass(
      {required String email, required String password}) async {
    try {
      final response = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Right(response.user!);
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  

  @override
  Stream<User?> getSigninStatusOfUser() {
    return _auth.authStateChanges();
  }

  @override
  FutureEitherVoid changePassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      var user = _auth.currentUser!;
      var credentials = EmailAuthProvider.credential(
          email: _auth.currentUser!.email!, password: currentPassword);
      await user.reauthenticateWithCredential(credentials);
      await _auth.currentUser!.updatePassword(newPassword);
      return const Right(null);
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }
   @override
  FutureEitherVoid forgetPassword(
      {required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<OAuthCredential> signInWithGoogle({required bool isIOS}) {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
