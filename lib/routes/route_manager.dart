import 'package:doctor_app/commons/common_widgets/message_screen.dart';
import 'package:doctor_app/features/Pharmacist/order/view/p_order_detail_screen.dart';
import 'package:doctor_app/features/Pharmacist/order/view/p_product_detail_screen.dart';
import 'package:doctor_app/features/User/home/view/u_add_record_screen.dart';
import 'package:doctor_app/features/User/home/view/u_doctor_detail_screen.dart';
import 'package:doctor_app/features/User/home/view/u_find_doctor_screen.dart';
import 'package:doctor_app/features/User/home/view/u_medical_record_screen.dart';
import 'package:doctor_app/features/User/home/view/u_select_time_doctor_screen.dart';
import 'package:doctor_app/features/User/home/view/u_tag_doctor_screen.dart';
import 'package:doctor_app/features/User/main_menu/views/u_main_menu_screen.dart';
import 'package:doctor_app/features/Pharmacist/home/view/p_add_product_screen.dart';
import 'package:doctor_app/features/Pharmacist/main_menu/views/pharmacist_main_menu_screen.dart';
import 'package:doctor_app/features/User/pharmacy/view/u_enable_location_screen.dart';
import 'package:doctor_app/features/User/pharmacy/view/u_find_medicien_screen.dart';
import 'package:doctor_app/features/User/pharmacy/view/u_order_screen.dart';
import 'package:doctor_app/features/User/profile/view/u_add_review_screen.dart';
import 'package:doctor_app/features/User/profile/view/u_change_password_profile_screen.dart';
import 'package:doctor_app/features/User/profile/view/u_edit_profile_screen.dart';
import 'package:doctor_app/features/User/profile/view/u_profile_screen.dart';
import 'package:doctor_app/features/User/profile/view/u_your_orders_screen.dart';
import 'package:doctor_app/features/account_type/view/account_type_screen.dart';
import 'package:doctor_app/features/auth/view/availabilty_screen.dart';
import 'package:doctor_app/features/auth/view/forget_screen.dart';
import 'package:doctor_app/features/auth/view/reset_pass_screen.dart';
import 'package:doctor_app/features/auth/view/signin_screen.dart';
import 'package:doctor_app/features/auth/view/signup_screen.dart';
import 'package:doctor_app/features/auth/view/speciality.dart';
import 'package:doctor_app/features/Doctor/main_menu/views/doctor_main_menu_screen.dart';
import 'package:doctor_app/features/Doctor/profile/view/d_change_password_profile_screen.dart';
import 'package:doctor_app/features/Doctor/profile/view/d_edit_profile_screen.dart';
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
  static const String messageScreen = '/messageScreen';
  static const String userDoctorDetailScreen = '/userDoctorDetailScreen';
  static const String doctorEditProfileScreen = '/doctorEditProfileScreen';
  static const String doctorProfileScreen = '/doctorProfileScreen';
  static const String doctorChangePasswordProfileScreen =
      '/doctorchangePasswordProfileScreen';

  // User profile Section
  static const String userEditProfileScreen = '/userEditProfileScreen';
  static const String userYourOrderScreen = '/userYourOrderScreen';
  static const String userAddReviewScreen = '/userAddReviewScreen';
  static const String userProfileScreen = '/userProfileScreen';
  static const String userOrderScreen = '/userOrderScreen';
  static const String userAddRecordScreen = '/userAddRecordScreen';
  static const String userTageScreen = '/userTagScreen';
  static const String userSelectTimeDoctorScreen =
      '/userSelectTimeDoctorScreen';
  static const String userEnableLocationScreen = '/userEnableLocationScreen';
  static const String userChangePasswordProfileScreen =
      '/userchangePasswordProfileScreen';

  // User Notification Section
  static const String userNotificationScreen = '/userNotificationScreen';
  static const String userFindDoctorScreen = '/userFindDoctorScreen';
  static const String userRecordScreen = '/userRecordScreen';

  // pharmacy Section
  static const String pharmacyMainMenuScreen = '/pharmacyMainMenuScreen';
  static const String pharmacyAddProductScreen = '/pharmacyAddProductScreen';
  static const String pharmacyFindMedScreen = '/pharmacyFindMedScreen';
  static const String pharmacyOrderDetailScreen = '/pharmacyOrderDetailScreen';
  static const String pharmacyProductDetailScreen =
      '/pharmacyProductDetailScreen';

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
      case userEditProfileScreen:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(UserEditProfileScreen(
          userModel: arguments['userModel'],
        ));
      case userRecordScreen:
        return _buildRoute(const UserMedicalRecordScreen());
      case userYourOrderScreen:
        return _buildRoute(const YourOrderScreen());
      case userAddReviewScreen:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(UserAddReviewScreen(
          productId: arguments['productId'],
        ));
      case signUpScreen:
        return _buildRoute(const SignUpScreen());
      case forgetPasswordScreen:
        return _buildRoute(const ForgotPasswordScreen());
      case resetPasswordScreen:
        return _buildRoute(const ResetPasswordScreen());
      case availabiltyScreen:
        return _buildRoute(const AvailabiltyScreen());
      case mainMenuScreen:
        return _buildRoute(const UserMainMenuScreen());
      case doctoMainMenuScreen:
        return _buildRoute(const DoctorMainMenuScreen());
      case userChangePasswordProfileScreen:
        return _buildRoute(const UserChangePasswordProfileScreen());
      case specialityScreen:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(SpecialityScreen(
          from: arguments['from'],
          to: arguments['to'],
          availableDays: arguments['availableDays'],
        ));
      case userTageScreen:
        return _buildRoute(const TagDoctorPage());
      case doctorEditProfileScreen:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(DoctorEditProfileScreen(
          userModel: arguments['userModel'],
          doctorModel: arguments['doctorModel'],
        ));
      case doctorChangePasswordProfileScreen:
        return _buildRoute(const DoctorChangePasswordProfileScreen());
      case userProfileScreen:
        return _buildRoute(const UserProfileScreen());
      case userOrderScreen:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(UserOrderScreen(
          productModel: arguments['productModel'],
        ));
      case userAddRecordScreen:
        return _buildRoute(const UserAddRecordScreen());
      case userDoctorDetailScreen:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(UserDoctorDetailScreen(
          model: arguments['model'],
        ));
      case userSelectTimeDoctorScreen:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(UserSelectTimeDoctorScreen(
          model: arguments['model'],
        ));
      case userEnableLocationScreen:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(UserEnableLocationScreen(
          productModel: arguments['productModel'],
          patientName: arguments['patientName'],
          patientPhone: arguments['patientPhone'],
          patientEmail: arguments['patientEmail'],
          patientAge: arguments['patientAge'],
          patientGender: arguments['patientGender'],
        ));
      case pharmacyMainMenuScreen:
        return _buildRoute(const PharmacistMainMenuScreen());
      case pharmacyFindMedScreen:
        return _buildRoute(const PharmistFindMedScreen());
      case pharmacyAddProductScreen:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(PAddProductScreen(
          model: arguments['model'],
          type: arguments['type'],
        ));
      case pharmacyOrderDetailScreen:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(PharmaistOrderDetailScreen(
          orderModel: arguments['orderModel'],
        ));
      case pharmacyProductDetailScreen:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(PharmaistProductDetailScreen(
          productId: arguments['productId'],
        ));
      case messageScreen:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(MobileChatScreen(
          isGroupChat: arguments['isGroupChat'],
          name: arguments['name'],
          uid: arguments['uid'],
        ));
      case userFindDoctorScreen:
        return _buildRoute(const UserFindDoctorScreen());

      /// doctor

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
