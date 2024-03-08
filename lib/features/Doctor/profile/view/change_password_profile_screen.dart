import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_functions/validator.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/custom_text_fields.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../commons/common_widgets/show_toast.dart';
import '../../../auth/controller/auth_controller.dart';

class ChangePasswordProfileScreen extends StatefulWidget {
  const ChangePasswordProfileScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordProfileScreen> createState() =>
      _ChangePasswordProfileScreenState();
}

class _ChangePasswordProfileScreenState
    extends State<ChangePasswordProfileScreen> {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              AppAssets.backArrowIcon,
              width: 30.w,
              height: 30.h,
            ),
          ),
          title: Text(
            'Change Password',
            style: getMediumStyle(
                color: MyColors.appColor1, fontSize: MyFonts.size18),
          ),
        ),
        body: MasterScafold(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  padding20,
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          borderRadius: 12.r,
                          borderColor: MyColors.lightContainerColor,
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
                        ),
                        CustomTextField(
                          borderRadius: 12.r,
                          borderColor: MyColors.lightContainerColor,
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
                                    color: context.bodyTextColor,
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
                                    color: context.bodyTextColor,
                                    size: 20.h,
                                  )),
                        ),
                        CustomTextField(
                          borderRadius: 12.r,
                          borderColor: MyColors.lightContainerColor,
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
                                    color: context.bodyTextColor,
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
                                    color: context.bodyTextColor,
                                    size: 20.h,
                                  )),
                        ),
                      ],
                    ),
                  ),
                  padding40,
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return CustomButton(
                        backColor: MyColors.appColor1,
                        isLoading: ref.watch(authControllerProvider),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (newPasswordController.text ==
                                confirmNewPasswordController.text) {
                              await ref
                                  .read(authControllerProvider.notifier)
                                  .changeUserPassword(
                                      currentPass: passwordController.text,
                                      newPass: newPasswordController.text,
                                      context: context);
                            } else {
                              showToast(msg: 'Pssword dont match!');
                            }
                          } else {
                            showToast(msg: 'All Fields are required!');
                          }
                        },
                        buttonText: 'Update Profile',
                        buttonWidth: 130.w,
                        fontSize: MyFonts.size12,
                      );
                    },
                  ),
                  padding100,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
