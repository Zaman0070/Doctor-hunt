import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_functions/validator.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/custom_text_fields.dart';
import 'package:doctor_app/commons/common_widgets/show_toast.dart';
import 'package:doctor_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/services/shar_pref_servies.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import '../../../commons/common_imports/common_libs.dart';
import '../../../utils/constants/assets_manager.dart';
import '../controller/auth_controller.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final nameController = TextEditingController();
  final codeController = TextEditingController(text: '+1');
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var passObscure = true;
  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    codeController.dispose();
    super.dispose();
  }

  SharePref sharePref = SharePref();

  signUp() async {
    if (formKey.currentState!.validate()) {
      String phoneNo = "${codeController.text}-${phoneNumberController.text}";
      if (phoneNumberController.text.trim() == "") {
        phoneNo = '';
      }
      await ref
          .read(authControllerProvider.notifier)
          .registerWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
            phone: phoneNo,
            name: nameController.text,
            context: context,
          );
    }
    await sharePref.saveType('user', 'login');
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
                    padding12,
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
                            width: 30.w,
                            height: 30.h,
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        )
                      ],
                    ),
                    padding100,
                    Text(
                      'Join us to start signing up',
                      style: getSemiBoldStyle(
                          color: MyColors.black, fontSize: MyFonts.size24),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text('Welcome! The Dia Predict App',
                        textAlign: TextAlign.center,
                        style: getRegularStyle(
                            color: MyColors.bodyTextColor,
                            fontSize: MyFonts.size16)),
                    padding24,
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: nameController,
                            hintText: 'Enter Name',
                            label: 'First Name',
                            validatorFn: uNameValidator,
                            borderColor: MyColors.lightContainerColor,
                            borderRadius: 12.r,
                          ),
                          CustomTextField(
                            controller: emailController,
                            hintText: 'Enter Email',
                            label: 'Email Address',
                            validatorFn: emailValidator,
                            borderColor: MyColors.lightContainerColor,
                            borderRadius: 12.r,
                          ),
                          CustomTextField(
                            borderColor: MyColors.lightContainerColor,
                            controller: passwordController,
                            borderRadius: 12.r,
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
                          ),
                        ],
                      ),
                    ),
                    padding12,
                    InkWell(
                      onTap: () {
                        ref.read(authNotifierCtr).toggleTerms();
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                ref.watch(authNotifierCtr).isTermsChecked
                                    ? MyColors.appColor1
                                    : MyColors.lightContainerColor,
                            radius: 10.r,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            'I agree with the ',
                            style: getRegularStyle(
                                color: MyColors.bodyTextColor,
                                fontSize: MyFonts.size12),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.termConditionScreen);
                            },
                            child: Text(
                              'terms of service & privacy policy',
                              style: getSemiBoldUnderlineStyle(
                                  color: MyColors.bodyTextColor,
                                  fontSize: MyFonts.size12),
                            ),
                          )
                        ],
                      ),
                    ),
                    padding24,
                    CustomButton(
                      isLoading: ref.watch(authControllerProvider),
                      onPressed: ref.watch(authNotifierCtr).isTermsChecked
                          ? signUp
                          : () {
                              showToast(
                                msg:
                                    'Please agree with the terms of service & privacy policy',
                              );
                            },
                      buttonText: 'Sign Up',
                      buttonHeight: 45.h,
                      backColor: MyColors.appColor1,
                      borderRadius: 12.r,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Center(
                      child: Text(
                        'or',
                        style: getSemiBoldStyle(
                            color: MyColors.bodyTextColor,
                            fontSize: MyFonts.size13),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already Have an Account  ',
                          style: getRegularStyle(
                              color: MyColors.bodyTextColor,
                              fontSize: MyFonts.size13),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.signInScreen);
                          },
                          child: Text(
                            'Login Now',
                            style: getSemiBoldUnderlineStyle(
                                color: MyColors.blue, fontSize: MyFonts.size13),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
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
