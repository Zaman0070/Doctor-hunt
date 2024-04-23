import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_shimmers/loading_screen_shimmer.dart';
import 'package:doctor_app/features/User/main_menu/views/u_main_menu_screen.dart';
import 'package:doctor_app/features/Pharmacist/main_menu/views/pharmacist_main_menu_screen.dart';
import 'package:doctor_app/features/auth/controller/auth_controller.dart';
import 'package:doctor_app/features/Doctor/main_menu/views/doctor_main_menu_screen.dart';
import 'package:doctor_app/features/splash/views/splash_screen.dart';
import 'package:doctor_app/firebase_messaging/firebase_messaging_class.dart';
import 'package:doctor_app/firebase_messaging/service/notification_service.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/services/shar_pref_servies.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:permission_handler/permission_handler.dart';
import 'firebase_options.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    
  );
  SharePref sharePref = SharePref();
  String? type = await sharePref.getType('login');
  //await Fcm.fireBaseNotifications();

  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  LocalNotificationService.requestPermission(Permission.notification);
  LocalNotificationService.initialize();
  tz.initializeTimeZones();
  // await LocalNotificationService().scheduleNotificationDailyCheckList();
  // await LocalNotificationService().scheduleNotificationJernal();
  runApp(ProviderScope(child: MyApp(type: type!)));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key, required this.type});
  final String type;

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    initiateFirebaseMessaging();
  }

  // TODO notification: Step 4 initiate Firebase messaging on the start of project
  initiateFirebaseMessaging() async {
    MessagingFirebase messagingFirebase = MessagingFirebase();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.display(event);
    });
    messagingFirebase.uploadFcmToken();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    //screenUtil package to make design responsive
    return ScreenUtilInit(
      designSize:
          const Size(AppConstants.screenWidget, AppConstants.screenHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.green,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          builder: (BuildContext context, Widget? child) {
            final MediaQueryData data = MediaQuery.of(context);
            return MediaQuery(
              data: data.copyWith(
                  // ignore: deprecated_member_use
                  textScaleFactor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? 0.9
                          : 1),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          title: 'Dia Predict',
          onGenerateRoute: AppRoutes.onGenerateRoute,
          home: ref.watch(userStateStreamProvider).when(
              data: (user) {
                if (user != null) {
                  return widget.type == "user"
                      ? const UserMainMenuScreen()
                      : widget.type == 'doctor'
                          ? const DoctorMainMenuScreen()
                          : const PharmacistMainMenuScreen();
                } else {
                  return const SplashScreen();
                }
              },
              error: (error, st) => const SplashScreen(),
              loading: () => const LoadingScreenShimmer()),
        );
      },
    );
  }
}
