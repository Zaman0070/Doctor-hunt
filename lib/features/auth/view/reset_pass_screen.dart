
import 'package:doctor_app/commons/common_functions/validator.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/custom_text_fields.dart';
import 'package:doctor_app/features/auth/widgets/reset_succsess_dialog.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../utils/constants/assets_manager.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var passObscure = true;
  var newPassObscure = true;
  var confirmNewPassObscure = true;

  @override
  void dispose() {
    passwordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  reset() async {
    // if (formKey.currentState!.validate()) {}
    resetDone();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(AppConstants.padding),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          AppAssets.backArrowIcon,
                          width: 20.w,
                          height: 20.h,
                            color: context.whiteColor
                        ),
                      ),
                      SvgPicture.asset(
                        AppAssets.appLogo,
                        height: 95.h,
                        width: 93.w,
                      ),
                      SizedBox(
                        width: 20.w,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Reset Password',
                    style: getSemiBoldStyle(
                        color: context.whiteColor,
                        fontSize: MyFonts.size24),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                      'Set The New Password For Your Account \n So You Can Login ',
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                          color: context.whiteColor,
                          fontSize: MyFonts.size14)),
                  SizedBox(
                    height: 20.h,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: passwordController,
                          hintText: 'Enter Current Password',
                          label: 'Current Password',
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
                                    color:
                                        context.bodyTextColor,
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
                                    color:
                                        context.bodyTextColor,
                                    size: 20.h,
                                  )),
                        ),
                        CustomTextField(
                          controller: newPasswordController,
                          hintText: 'Enter New Password',
                          label: 'New Password',
                          validatorFn: passValidator,
                          obscure: newPassObscure,
                          tailingIcon: newPassObscure == false
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      newPassObscure = !newPassObscure;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.eye,
                                    color:
                                        context.bodyTextColor,
                                    size: 20.h,
                                  ))
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      newPassObscure = !newPassObscure;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.eye_slash,
                                    color:
                                        context.bodyTextColor,
                                    size: 20.h,
                                  )),
                        ),
                        CustomTextField(
                          controller: confirmNewPasswordController,
                          hintText: 'Enter Confirm Password',
                          label: 'Confirm Password',
                          validatorFn: passValidator,
                          obscure: confirmNewPassObscure,
                          tailingIcon: confirmNewPassObscure == false
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      confirmNewPassObscure =
                                          !confirmNewPassObscure;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.eye,
                                    color:
                                        context.bodyTextColor,
                                    size: 20.h,
                                  ))
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      confirmNewPassObscure =
                                          !confirmNewPassObscure;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.eye_slash,
                                    color:
                                        context.bodyTextColor,
                                    size: 20.h,
                                  )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButton(
                    onPressed: reset,
                    buttonText: 'Reset Password',
                    buttonHeight: 45.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> resetDone() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const ResetSuccessDialog();
      },
    );
  }
}


