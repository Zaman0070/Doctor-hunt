import 'dart:async';

import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import '../../../commons/common_imports/common_libs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.introductionScreen, (route) => false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasterScafold(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.appLogo,
            height: 70.h,
            width: 70.w,
            color: MyColors.appColor1,
          ),
          padding16,
          Text('Doctor Hunt',
              style: getBoldStyle(
                  color: MyColors.black, fontSize: MyFonts.size24)),
        ],
      )),
    );
  }
}
