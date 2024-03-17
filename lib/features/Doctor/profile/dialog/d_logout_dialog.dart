import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/features/auth/controller/auth_controller.dart';
import 'package:doctor_app/features/Doctor/profile/controller/profile_controller.dart';
import 'package:doctor_app/services/shar_pref_servies.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DLogoutDialog extends ConsumerWidget {
  const DLogoutDialog({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: ref.read(dprofileNotifierCtr).isDeleteAccount ? 385.h : 300.h,
      width: 300.w,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      ref.read(dprofileNotifierCtr).setIsDeleteAccount(false);
                    },
                    child: Image.asset(
                      AppAssets.dialogClose,
                      height: 25.h,
                      width: 25.h,
                    ),
                  ),
                ],
              ),
              padding8,
              Image.asset(
                AppAssets.infoRound,
                height: 70.h,
                width: 70.w,
              ),
              padding12,
              Text(
                'Are You Sure Want To Logout Your Account?',
                textAlign: TextAlign.center,
                style: getRegularStyle(
                    color: MyColors.bodyTextColor, fontSize: MyFonts.size15),
              ),
              padding24,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                      borderColor: MyColors.appColor1,
                      backColor: Colors.white,
                      buttonHeight: 38.h,
                      buttonWidth: 130.w,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      textColor: MyColors.appColor1,
                      buttonText: 'Cancel'),
                  CustomButton(
                      isLoading: ref.watch(authControllerProvider),
                      backColor: context.errorColor,
                      buttonHeight: 38.h,
                      buttonWidth: 130.w,
                      onPressed: () async {
                        ref
                            .watch(authControllerProvider.notifier)
                            .logout(context: context);
                        SharePref().removeType('login');
                      },
                      textColor: MyColors.white,
                      buttonText: 'Logout'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
