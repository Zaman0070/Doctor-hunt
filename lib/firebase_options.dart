// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAhGeed2g5V0FD2ieRirAesg4A6t6HQirY',
    appId: '1:968402792650:web:75b06872acc67707878433',
    messagingSenderId: '968402792650',
    projectId: 'theascensionapp-3d7ca',
    authDomain: 'theascensionapp-3d7ca.firebaseapp.com',
    storageBucket: 'theascensionapp-3d7ca.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAheHM7AsQVafAkPd_X2FqTCpAzNPdt03s',
    appId: '1:902001643985:android:cffb7da9969b6aa6c8d0f0',
    messagingSenderId: '902001643985',
    projectId: 'doctor-hunt-367f7',
    storageBucket: 'doctor-hunt-367f7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBC57xvRGomPDtunp2-q5Z3G_E1cvx2y_0',
    appId: '1:968402792650:ios:5a75c69934e545e8878433',
    messagingSenderId: '902001643985',
    projectId: 'theascensionapp-3d7ca',
    storageBucket: 'theascensionapp-3d7ca.appspot.com',
    iosBundleId: 'com.bertrand.theAscensionApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBC57xvRGomPDtunp2-q5Z3G_E1cvx2y_0',
    appId: '1:968402792650:ios:4d7f310c53c8f455878433',
    messagingSenderId: '968402792650',
    projectId: 'theascensionapp-3d7ca',
    storageBucket: 'theascensionapp-3d7ca.appspot.com',
    iosBundleId: 'com.bertrand.theAscensionApp.RunnerTests',
  );
}
