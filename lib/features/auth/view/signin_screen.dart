import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_functions/validator.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/custom_text_fields.dart';
import 'package:doctor_app/commons/common_widgets/show_toast.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/services/shar_pref_servies.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../commons/common_widgets/common_password_textfield.dart';
import '../controller/auth_controller.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key, required this.accountType});
  final String accountType;

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final emailController = TextEditingController();
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  SharePref sharePref = SharePref();
  var passObscure = true;
  @override
  void dispose() {
    emailController.dispose();
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isDoctorEmail(String email) {
    String lowercaseEmail = email.toLowerCase();
    return lowercaseEmail.endsWith('@doctor.com');
  }

  bool isPharmistEmail(String email) {
    String lowercaseEmail = email.toLowerCase();
    return lowercaseEmail.endsWith('@pharmacist.com');
  }

  login() async {
    // Navigator.pushNamedAndRemoveUntil(
    //     context, AppRoutes.mainMenuScreen, (route) => false);
    if (formKey.currentState!.validate()) {
      if (widget.accountType == 'Doctor') {
        if (!isDoctorEmail(emailController.text)) {
          return showSnackBar(context, 'Invalid Doctor Email');
        }
      } else if (widget.accountType == 'Pharmacist') {
        if (!isPharmistEmail(emailController.text)) {
          return showSnackBar(context, 'Invalid Pharmacist Email');
        }
      }
      await ref.read(authControllerProvider.notifier).loginWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
            context: context,
            accountType: widget.accountType,
          );
      widget.accountType == "Patient"
          ? await sharePref.saveType('user', 'login')
          : widget.accountType == "Doctor"
              ? await sharePref.saveType('doctor', 'login')
              : await sharePref.saveType('pharmacist', 'login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        body: MasterScafold(
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(AppConstants.padding),
                child: Column(
                  children: [
                    SizedBox(height: 222.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.phoneVerificationScreen);
                      },
                      child: Text(
                        'Login to your account',
                        style: getSemiBoldStyle(
                            color: MyColors.black, fontSize: MyFonts.size24),
                      ),
                    ),
                    padding12,
                    Text('Welcome! The Dia Predict App',
                        style: getRegularStyle(
                            color: MyColors.bodyTextColor,
                            fontSize: MyFonts.size14)),
                    SizedBox(
                      height: 20.h,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          widget.accountType == 'Patient'
                              ? Container()
                              : CustomTextField(
                                  borderColor: MyColors.lightContainerColor,
                                  controller: idController,
                                  hintText: widget.accountType == 'Doctor'
                                      ? 'Enter Doctor ID'
                                      : 'Enter Pharmacist ID',
                                  label: '',
                                  // validatorFn: emailValidator,
                                  borderRadius: 12.r,
                                  validatorFn: (val) {
                                    if (val!.isEmpty) {
                                      return 'Enter your ID';
                                    }
                                    return null;
                                  },
                                ),
                          CustomTextField(
                            borderColor: MyColors.lightContainerColor,
                            controller: emailController,
                            hintText: 'Enter Email',
                            label: 'Email Address',
                            validatorFn: emailValidator,
                            borderRadius: 12.r,
                          ),
                          CustomPasswordTextField(
                            borderColor: MyColors.lightContainerColor,
                            controller: passwordController,
                            hintText: 'Enter Password',
                            label: 'Password',
                            validatorFn: passValidator,
                            borderRadius: 12.r,
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
                        ],
                      ),
                    ),
                    padding8,
                    CustomButton(
                        backColor: MyColors.appColor1,
                        borderRadius: 12.r,
                        isLoading: ref.watch(authControllerProvider),
                        onPressed: login,
                        buttonText: 'login'),
                    padding18,
                    widget.accountType == "Doctor" ||
                            widget.accountType == 'Pharmacist'
                        ? Container()
                        : Align(
                            alignment: Alignment.center,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.forgetPasswordScreen);
                                },
                                child: Text(
                                  'Forget Password',
                                  style: getSemiBoldUnderlineStyle(
                                      color: MyColors.blue,
                                      fontSize: MyFonts.size13),
                                )),
                          ),
                    padding100,
                    widget.accountType == "Doctor" ||
                            widget.accountType == 'Pharmacist'
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't Have Account  ",
                                style: getRegularStyle(
                                    color: MyColors.appColor1,
                                    fontSize: MyFonts.size13),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.signUpScreen);
                                },
                                child: Text(
                                  'Signup Now',
                                  style: getSemiBoldUnderlineStyle(
                                      color: MyColors.blue,
                                      fontSize: MyFonts.size10),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
