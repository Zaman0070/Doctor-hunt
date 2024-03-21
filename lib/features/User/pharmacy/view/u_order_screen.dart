import 'dart:io';

import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_functions/upload_image_to_firebase.dart';
import 'package:doctor_app/commons/common_functions/validator.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/custom_text_fields.dart';
import 'package:doctor_app/commons/common_widgets/show_toast.dart';
import 'package:doctor_app/core/constants/firebase_constants.dart';
import 'package:doctor_app/features/User/home/widgets/u_upload_bottom_sheet.dart';
import 'package:doctor_app/features/User/pharmacy/controller/u_pharmacy_noti.dart';
import 'package:doctor_app/features/User/pharmacy/widgets/u_gender_widget.dart';
import 'package:doctor_app/features/User/pharmacy/widgets/u_image_selection.dart';
import 'package:doctor_app/models/product/products_model.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UserOrderScreen extends ConsumerStatefulWidget {
  const UserOrderScreen({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  ConsumerState<UserOrderScreen> createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends ConsumerState<UserOrderScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  DateTime now = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(1970, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != now) {
      setState(() {
        dateOfBirthController.text = DateFormat('EE-MM-dd').format(picked);
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  List<File> imageFile = [];
  var picker = ImagePicker();
  List<String> imageUrls = [];

  _getImage(ImageSource source) async {
    var pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile.add(File(pickedFile.path));
      });
      List<String> image = await uploadImages(
          imageFile.map((e) => XFile(e.path)).toList(),
          storageFolderName: FirebaseConstants.ownerCollection);
      setState(() {
        imageUrls.addAll(image);
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              'Patient Details',
              style: getMediumStyle(
                  color: MyColors.black, fontSize: MyFonts.size18),
            ),
          ),
          padding12,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 335.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: MyColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.lightGreyColor.withOpacity(0.3),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          )
                        ]),
                    child: Padding(
                      padding: EdgeInsets.all(AppConstants.padding),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UAddOrderImageSection(
                                image: imageFile,
                                onTap: () {
                                  _displayBottomSheet(
                                    context: context,
                                    camera: () {
                                      _getImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                    gallery: () {
                                      _getImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              ),
                              padding12,
                              Text(
                                'Patient’s Name',
                                style: getMediumStyle(
                                    color: MyColors.black,
                                    fontSize: MyFonts.size14),
                              ),
                              CustomTextField(
                                controller: nameController,
                                hintText: 'Enter Patient’s Name',
                                label: '',
                                borderRadius: 12.r,
                                validatorFn: uNameValidator,
                                borderColor:
                                    MyColors.bodyTextColor.withOpacity(0.16),
                              ),
                              padding12,
                              Text(
                                'Age',
                                style: getMediumStyle(
                                    color: MyColors.black,
                                    fontSize: MyFonts.size14),
                              ),
                              CustomTextField(
                                onTap: () {
                                  _selectDate(context);
                                },
                                enabled: false,
                                leadigingIconPath: AppAssets.ageCalSvgIcon,
                                controller: dateOfBirthController,
                                hintText: 'Date of Birth',
                                label: '',
                                borderRadius: 12.r,
                                borderColor:
                                    MyColors.bodyTextColor.withOpacity(0.16),
                                tailingIcon: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: RotatedBox(
                                    quarterTurns: 1,
                                    child: SvgPicture.asset(
                                        AppAssets.farArrowSvgIcon,
                                        height: 12),
                                  ),
                                ),
                              ),
                              padding12,
                              UGenderWidget(
                                onPressed: () {},
                                title: 'Gender',
                              ),
                              padding12,
                              Text(
                                'Mobile Number',
                                style: getMediumStyle(
                                    color: MyColors.black,
                                    fontSize: MyFonts.size14),
                              ),
                              CustomTextField(
                                controller: phoneController,
                                hintText: '+9231000000000',
                                label: '',
                                borderRadius: 12.r,
                                borderColor:
                                    MyColors.bodyTextColor.withOpacity(0.16),
                              ),
                              Text(
                                'Email',
                                style: getMediumStyle(
                                    color: MyColors.black,
                                    fontSize: MyFonts.size14),
                              ),
                              CustomTextField(
                                controller: emailController,
                                hintText: '+itsmemamun1@gmail.com',
                                label: '',
                                validatorFn: emailValidator,
                                borderRadius: 12.r,
                                borderColor:
                                    MyColors.bodyTextColor.withOpacity(0.16),
                              ),
                              padding12,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (imageUrls.isEmpty) {
                    showToast(
                      msg: 'Please add a report image',
                    );
                    return;
                  }
                  Navigator.pushNamed(
                      context, AppRoutes.userEnableLocationScreen,
                      arguments: {
                        'productModel': widget.productModel,
                        'patientName': nameController.text,
                        'patientPhone': phoneController.text,
                        'patientEmail': emailController.text,
                        'patientAge': dateOfBirthController.text,
                        "patientGender": ref.watch(uPharmacyNotifierCtr).gender,
                        "imageUrls": imageUrls
                      });
                }
              },
              buttonText: 'Continue',
              buttonHeight: 54.h,
              buttonWidth: 270.w,
              borderRadius: 6.r,
              backColor: MyColors.appColor1,
              fontSize: MyFonts.size16),
          padding40
        ],
      )),
    );
  }

  Future _displayBottomSheet(
      {required BuildContext context,
      required Function() camera,
      required Function() gallery}) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (_) => UploadBottomSheetSection(
              file: imageFile,
              title: 'Add a record',
              camera: camera,
              gallery: gallery,
            ));
  }
}
