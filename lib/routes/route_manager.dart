import 'package:doctor_app/features/Pharmacist/home/view/p_add_product_screen.dart';
import 'package:doctor_app/features/Pharmacist/main_menu/views/pharmacist_main_menu_screen.dart';
import 'package:doctor_app/features/Pharmacist/profile/view/p_edit_profile_screen.dart';
import 'package:doctor_app/features/account_type/view/account_type_screen.dart';
import 'package:doctor_app/features/auth/view/availabilty_screen.dart';
import 'package:doctor_app/features/auth/view/forget_screen.dart';
import 'package:doctor_app/features/auth/view/reset_pass_screen.dart';
import 'package:doctor_app/features/auth/view/signin_screen.dart';
import 'package:doctor_app/features/auth/view/signup_screen.dart';
import 'package:doctor_app/features/auth/view/speciality.dart';
import 'package:doctor_app/features/Doctor/main_menu/views/doctor_main_menu_screen.dart';
import 'package:doctor_app/features/Doctor/profile/view/change_password_profile_screen.dart';
import 'package:doctor_app/features/Doctor/profile/view/edit_profile_screen.dart';
import 'package:doctor_app/features/splash/views/introduction_screen.dart';
import 'package:doctor_app/features/splash/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'navigation.dart';

class AppRoutes {
  static const String splashScreen = '/splashScreen';
  static const String introductionScreen = '/introductionScreen';
  static const String signInScreen = '/signInScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String forgetPasswordScreen = '/forgetPasswordScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String phoneVerificationScreen = '/phoneVerificationScreen';
  static const String mainMenuScreen = '/mainMenuScreen';
  static const String accountTypeScreen = '/accountTypeScreen';
  static const String availabiltyScreen = '/availabiltyScreen';
  static const String specialityScreen = '/specialityScreen';
  static const String doctoMainMenuScreen = '/doctoMainMenuScreen';

  // User profile Section
  static const String editProfileScreen = '/editProfileScreen';
  static const String peditProfileScreen = '/peditProfileScreen';
  static const String changePasswordProfileScreen =
      '/changePasswordProfileScreen';

  // User Notification Section
  static const String userNotificationScreen = '/userNotificationScreen';

  // pharmacy Section
  static const String pharmacyMainMenuScreen = '/pharmacyMainMenuScreen';
  static const String pharmacyAddProductScreen = '/pharmacyAddProductScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return _buildRoute(const SplashScreen());
      case introductionScreen:
        return _buildRoute(const IntroductionScreen());
      case accountTypeScreen:
        return _buildRoute(const AccountTypeScreen());
      case signInScreen:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(SignInScreen(
          accountType: arguments['accountType'],
        ));
      case signUpScreen:
        return _buildRoute(const SignUpScreen());
      case forgetPasswordScreen:
        return _buildRoute(const ForgotPasswordScreen());
      case resetPasswordScreen:
        return _buildRoute(const ResetPasswordScreen());
      case availabiltyScreen:
        return _buildRoute(const AvailabiltyScreen());
      case doctoMainMenuScreen:
        return _buildRoute(const DoctorMainMenuScreen());
      case changePasswordProfileScreen:
        return _buildRoute(const ChangePasswordProfileScreen());
      case specialityScreen:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(SpecialityScreen(
          availableDays: arguments['availableDays'],
        ));
      case editProfileScreen:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(EditProfileScreen(
          userModel: arguments['userModel'],
        ));
      case peditProfileScreen:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(PEditProfileScreen(
          userModel: arguments['userModel'],
          pharmacyInfoModel: arguments['pharmacyInfoModel'],
        ));
      case pharmacyMainMenuScreen:
        return _buildRoute(const PharmacistMainMenuScreen());
      case pharmacyAddProductScreen:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(PAddProductScreen(
          model: arguments['model'],
          type: arguments['type'],
        ));
      default:
        return unDefinedRoute();
    }
  }

  static unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        backgroundColor: Colors.black,
      ),
    );
  }

  static _buildRoute(Widget widget, {int? duration = 400}) {
    return forwardRoute(widget, duration);
  }
}
