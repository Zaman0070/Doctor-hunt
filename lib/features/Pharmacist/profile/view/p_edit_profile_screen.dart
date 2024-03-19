import 'package:country_code_picker/country_code_picker.dart';
import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_functions/validator.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/custom_text_fields.dart';
import 'package:doctor_app/features/Pharmacist/profile/controller/profile_controller.dart';
import 'package:doctor_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:doctor_app/features/Doctor/profile/widgets/edit_profile_image_widget.dart';
import 'package:doctor_app/models/auth/user_model.dart';
import 'package:doctor_app/models/pharmacy_info/pharmacy_info_model.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter/cupertino.dart';

import '../../../auth/controller/auth_controller.dart';

class PharmacyEditProfileScreen extends ConsumerStatefulWidget {
  final UserModel userModel;
  final PharmacyInfoModel pharmacyInfoModel;
  const PharmacyEditProfileScreen({
    Key? key,
    required this.userModel,
    required this.pharmacyInfoModel,
  }) : super(key: key);

  @override
  ConsumerState<PharmacyEditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<PharmacyEditProfileScreen> {
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final pharmacyNameController = TextEditingController();
  final addressController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? newImagePath;
  String? oldImage;
  @override
  void initState() {
    super.initState();
    fullNameController.text = widget.userModel.name;
    emailController.text = widget.userModel.email;
    oldImage = widget.userModel.profileImage;
    pharmacyNameController.text = widget.pharmacyInfoModel.pharmacyName;
    addressController.text = widget.pharmacyInfoModel.pharmacyAddress;
    ref.read(pprofileNotifierCtr).timeStr =
        widget.pharmacyInfoModel.pharmacyOpenTime;
    ref.read(pprofileNotifierCtr).timeEnd =
        widget.pharmacyInfoModel.pharmacyCloseTime;
    splitPhoneNumber();
  }

  splitPhoneNumber() {
    String inputString = widget.pharmacyInfoModel.pharmacyPhone;
    RegExp regex = RegExp(r'^\+(\d+)-(.+)$');
    Match? match = regex.firstMatch(inputString);
    if (match != null) {
      String countryCode = '+${match.group(1)!}';
      String phoneNumber = match.group(2)!;
      phoneNumberController.text = phoneNumber;
      codeController.text = countryCode;
    }
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
    final ctr = ref.watch(pprofileNotifierCtr);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: MasterScafold(
          child: Column(
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
                  'Edit Pharmacy Profile',
                  style: getMediumStyle(
                      color: MyColors.black, fontSize: MyFonts.size18),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingHorizontal),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        padding40,
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
                                hintText: 'Mark Jeson',
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
                              CustomTextField(
                                borderRadius: 12.r,
                                controller: pharmacyNameController,
                                hintText: 'pharmacy name',
                                label: '',
                                validatorFn: emailValidator,
                                tailingIconPath: AppAssets.emailSvgIcon,
                                borderColor: MyColors.lightContainerColor,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 46.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100.r),
                                          color: MyColors.appColor1),
                                      child: CountryCodePicker(
                                        initialSelection: codeController.text,
                                        textStyle: getRegularStyle(
                                            fontSize: MyFonts.size12,
                                            color: MyColors.white),
                                        padding: EdgeInsets.zero,
                                        barrierColor:
                                            Colors.black.withOpacity(0.5),
                                        onChanged: (CountryCode code) {
                                          codeController.text = code.dialCode!;
                                        },
                                        dialogBackgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        showFlag: false,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    flex: 3,
                                    child: CustomTextField(
                                      borderColor: MyColors.lightContainerColor,
                                      onChanged: (value) {
                                        String formattedText =
                                            value.replaceAll(RegExp(r'\D'), '');
                                        if (formattedText.length >= 3 &&
                                            formattedText.length <= 6) {
                                          formattedText =
                                              '${formattedText.substring(0, 3)}-${formattedText.substring(3)}';
                                        } else if (formattedText.length > 6) {
                                          formattedText =
                                              '${formattedText.substring(0, 3)}-${formattedText.substring(3, 6)}-${formattedText.substring(6)}';
                                        }
                                        phoneNumberController.value =
                                            TextEditingValue(
                                          text: formattedText,
                                          selection: TextSelection.collapsed(
                                              offset: formattedText.length),
                                        );
                                      },

                                      controller: phoneNumberController,
                                      hintText: '123-456-7890',
                                      label: 'Number',
                                      //validatorFn: phoneValidator,
                                      tailingIconPath: AppAssets.phoneSvgIcon,
                                    ),
                                  ),
                                ],
                              ),
                              padding6,
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        ref
                                            .watch(pprofileNotifierCtr)
                                            .pickStartTime(context);
                                      },
                                      child: Container(
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          border: Border.all(
                                            color: MyColors.lightContainerColor,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            ctr.timeStr != ''
                                                ? ctr.timeStr
                                                : 'From',
                                            style: getLightStyle(
                                                color:
                                                    MyColors.darkContainerColor,
                                                fontSize: MyFonts.size12),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        ref
                                            .watch(pprofileNotifierCtr)
                                            .pickEndTime(context);
                                      },
                                      child: Container(
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          border: Border.all(
                                            color: MyColors.lightContainerColor,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            ctr.timeEnd != ''
                                                ? ctr.timeEnd
                                                : 'Till',
                                            style: getLightStyle(
                                                color:
                                                    MyColors.darkContainerColor,
                                                fontSize: MyFonts.size12),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              padding6,
                              CustomTextField(
                                borderRadius: 12.r,
                                controller: addressController,
                                hintText: 'Address',
                                label: '',
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
                              buttonHeight: 35.h,
                              isLoading: ref.watch(authControllerProvider),
                              onPressed: () async {
                                final authCtr =
                                    ref.read(authControllerProvider.notifier);
                                final authNotiCtr =
                                    ref.read(authNotifierCtr.notifier);
                                bool hasLast =
                                    hasLastName(fullNameController.text);

                                UserModel userModel = UserModel.fromMap({
                                  ...widget.userModel.toMap(),
                                  'firstName': hasLast
                                      ? fullNameController.text.split(' ')[0]
                                      : fullNameController.text,
                                  'lastName': hasLast
                                      ? fullNameController.text.split(' ')[1]
                                      : '',
                                  'email': emailController.text,
                                  'profileImage': oldImage!,
                                });

                                PharmacyInfoModel pharmacyInfoModel =
                                    PharmacyInfoModel.fromMap({
                                  'pharmacyName': pharmacyNameController.text,
                                  'pharmacyAddress': addressController.text,
                                  'pharmacyPhone':
                                      '${codeController.text}-${phoneNumberController.text}',
                                  'pharmacyOpenTime': ctr.timeStr,
                                  'pharmacyCloseTime': ctr.timeEnd,
                                  'pharmacyId':
                                      FirebaseAuth.instance.currentUser!.uid,
                                });
                                await authCtr.updatePharmacyInfo(
                                    context: context, model: pharmacyInfoModel);
                                await authCtr.updateCurrentUserInfo(
                                    // ignore: use_build_context_synchronously
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
                              buttonWidth: 164.w,
                              fontSize: MyFonts.size14,
                              backColor: MyColors.appColor1,
                              borderRadius: 6.r,
                            );
                          },
                        ),
                        padding100,
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
