import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_functions/validator.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/custom_text_fields.dart';
import 'package:doctor_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:doctor_app/features/Doctor/profile/widgets/edit_profile_image_widget.dart';
import 'package:doctor_app/models/auth/user_model.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';

import '../../../auth/controller/auth_controller.dart';

class UserEditProfileScreen extends ConsumerStatefulWidget {
  final UserModel userModel;
  const UserEditProfileScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  ConsumerState<UserEditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<UserEditProfileScreen> {
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? newImagePath;
  String? oldImage;
  @override
  void initState() {
    super.initState();
    fullNameController.text = widget.userModel.name;
    emailController.text = widget.userModel.email;
    oldImage = widget.userModel.profileImage;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: MasterScafold(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
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
                    'Edit Profile',
                    style: getMediumStyle(
                        color: MyColors.black, fontSize: MyFonts.size18),
                  ),
                ),
                padding40,
                Padding(
                  padding: EdgeInsets.all(AppConstants.padding),
                  child: Column(
                    children: [
                      EditProfileImageWidget(
                        userImage: widget.userModel.profileImage,
                        imgPath: (imgPath) {
                          setState(() {
                            newImagePath = imgPath;
                          });
                        },
                      ),
                      padding30,
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              borderRadius: 12.r,
                              controller: fullNameController,
                              hintText: 'Enter Full Name',
                              label: 'Full Name',
                              validatorFn: uNameValidator,
                              borderColor: MyColors.lightContainerColor,
                            ),
                            CustomTextField(
                              borderRadius: 12.r,
                              controller: emailController,
                              hintText: 'info@example.com',
                              label: 'Email Address',
                              validatorFn: emailValidator,
                              tailingIconPath: AppAssets.emailSvgIcon,
                              borderColor: MyColors.lightContainerColor,
                            ),
                          ],
                        ),
                      ),
                      padding40,
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref,
                            Widget? child) {
                          return CustomButton(
                            isLoading: ref.watch(authControllerProvider),
                            onPressed: () async {
                              final authCtr =
                                  ref.read(authControllerProvider.notifier);
                              final authNotiCtr =
                                  ref.read(authNotifierCtr.notifier);

                              UserModel userModel = UserModel.fromMap({
                                ...widget.userModel.toMap(),
                                'name': fullNameController.text,
                                'email': emailController.text,
                                'profileImage': oldImage!,
                              });
                              await authCtr.updateCurrentUserInfo(
                                  context: context,
                                  userModel: userModel,
                                  oldImage: oldImage!,
                                  newImagePath: newImagePath);
                              authCtr
                                  .getCurrentUserInfoStreamData()
                                  .listen((event) {
                                authNotiCtr.setUserModelData(event);
                              });
                            },
                            buttonText: 'Update Profile',
                            buttonWidth: 130.w,
                            fontSize: MyFonts.size14,
                            backColor: MyColors.appColor1,
                          );
                        },
                      ),
                      padding100,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool hasLastName(String fullName) {
    int num = fullName.split(' ').length;
    return num > 1 ? true : false;
  }
}
