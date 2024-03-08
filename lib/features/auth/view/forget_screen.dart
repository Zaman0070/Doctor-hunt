

import 'package:doctor_app/commons/common_functions/validator.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/custom_text_fields.dart';
import 'package:doctor_app/features/auth/controller/auth_controller.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../utils/constants/assets_manager.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  forget() async {
    if (formKey.currentState!.validate()) {
      await ref.read(authControllerProvider.notifier).forgetPassword(
            email: emailController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
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
                        child: Image.asset(AppAssets.backArrowIcon,
                            width: 20.w,
                            height: 20.h,
                            color: context.whiteColor),
                      ),
                      Image.asset(
                        AppAssets.appLogo,
                        height: 150.h,
                        width: 135.w,
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
                    'Forget Password',
                    style: getSemiBoldStyle(
                        color: context.whiteColor, fontSize: MyFonts.size24),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                      'Enter Your Email For The Verification Code \n We Will Send Reset Email',
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                          color: context.whiteColor, fontSize: MyFonts.size14)),
                  SizedBox(
                    height: 20.h,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: emailController,
                          hintText: 'Enter Email',
                          label: 'Email Address',
                          validatorFn: emailValidator,
                          tailingIconPath: AppAssets.profileSvgIcon,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButton(
                      isLoading: ref.watch(authControllerProvider),
                      onPressed: forget,
                      buttonText: 'Continue'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
