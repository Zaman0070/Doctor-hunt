import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_functions/validator.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/custom_text_fields.dart';
import 'package:doctor_app/features/auth/controller/auth_controller.dart';
import 'package:doctor_app/features/Doctor/profile/controller/profile_controller.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DDeleteAccountDialog extends ConsumerStatefulWidget {
  const DDeleteAccountDialog({super.key});

  @override
  ConsumerState<DDeleteAccountDialog> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<DDeleteAccountDialog> {
  final TextEditingController passwordController = TextEditingController();
  bool passObscure = true;

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(authControllerProvider.notifier);

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
                      AppAssets.dialogCloseIcon,
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
                'Are You Sure Want To Delete The Account Permanently?',
                textAlign: TextAlign.center,
                style: getRegularStyle(
                    color: MyColors.bodyTextColor, fontSize: MyFonts.size15),
              ),
              padding4,
              Text(
                'All your data will be lost.',
                textAlign: TextAlign.center,
                style: getMediumStyle(
                    color: context.errorColor, fontSize: MyFonts.size14),
              ),
              ref.watch(dprofileNotifierCtr).isDeleteAccount
                  ? CustomTextField(
                      controller: passwordController,
                      hintText: 'Enter Password',
                      label: 'Password',
                      validatorFn: passValidator,
                      obscure: passObscure,
                      tailingIcon: passObscure == false
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  passObscure = !passObscure;
                                });
                              },
                              child: Icon(
                                CupertinoIcons.eye,
                                color: context.bodyTextColor,
                                size: 20.h,
                              ))
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  passObscure = !passObscure;
                                });
                              },
                              child: Icon(
                                CupertinoIcons.eye_slash,
                                color: context.bodyTextColor,
                                size: 20.h,
                              )),
                    )
                  : Container(),
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
                        ref.read(dprofileNotifierCtr).setIsDeleteAccount(false);
                      },
                      textColor: MyColors.appColor1,
                      buttonText: 'Cancel'),
                  CustomButton(
                      isLoading: ref.watch(authControllerProvider),
                      backColor: context.errorColor,
                      buttonHeight: 38.h,
                      buttonWidth: 130.w,
                      onPressed: () async {
                        ref.read(dprofileNotifierCtr).isDeleteAccount
                            ? await controller.deleteAccount(
                                context: context,
                                password: passwordController.text)
                            : ref
                                .read(dprofileNotifierCtr)
                                .setIsDeleteAccount(true);
                      },
                      textColor: MyColors.white,
                      buttonText: 'Delete'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
