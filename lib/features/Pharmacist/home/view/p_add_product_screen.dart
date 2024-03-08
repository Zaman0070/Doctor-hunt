import 'dart:io';
import 'package:doctor_app/commons/common_functions/crop_image.dart';
import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/custom_text_fields.dart';
import 'package:doctor_app/features/Pharmacist/home/controller/pharmacy_controller.dart';
import 'package:doctor_app/models/product/products_model.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class PAddProductScreen extends ConsumerStatefulWidget {
  const PAddProductScreen({super.key, required this.type, this.model});
  final String type;
  final ProductModel? model;

  @override
  ConsumerState<PAddProductScreen> createState() => _PAddProductScreenState();
}

class _PAddProductScreenState extends ConsumerState<PAddProductScreen> {
  final fullNameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  File? imageFile;
  String? newImagePath;
  String? oldImage;

  getPhoto() async {
    XFile? imgFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imgFile != null) {
      File? img =
          // ignore: use_build_context_synchronously
          await cropImage(imageFile: File(imgFile.path), context: context);
      if (img != null) {
        setState(() {
          imageFile = img;
          newImagePath = imageFile!.path;
        });
      }
    }
  }

  final key = GlobalKey<FormState>();
  @override
  void initState() {
    fullNameController.text =
        widget.model != null ? widget.model!.productName! : '';
    priceController.text =
        widget.model != null ? widget.model!.productPrice! : '';
    descriptionController.text =
        widget.model != null ? widget.model!.productDescription! : '';
    oldImage = widget.model != null ? widget.model!.productImage : '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Add Product',
          style:
              getBoldStyle(color: MyColors.appColor1, fontSize: MyFonts.size18),
        ),
      ),
      body: MasterScafold(
        child: Padding(
          padding: EdgeInsets.all(AppConstants.padding),
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
                children: [
                  Container(
                    height: 150.h,
                    width: 335.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: MyColors.appColor1, width: 1.5),
                    ),
                    child: InkWell(
                      onTap: getPhoto,
                      child: imageFile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(14.r),
                              child: Image.file(
                                imageFile!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : widget.type == 'edit'
                              ? CachedRectangularNetworkImageWidget(
                                  image: widget.model!.productImage!,
                                  width: 150,
                                  height: 335)
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.imgSvgIcon,
                                      height: 28.h,
                                      width: 28.w,
                                    ),
                                    Text(
                                      'Select Image',
                                      style: getMediumStyle(
                                          color: MyColors.lightContainerColor,
                                          fontSize: MyFonts.size16),
                                    ),
                                  ],
                                ),
                    ),
                  ),
                  padding12,
                  CustomTextField(
                    borderRadius: 12.r,
                    controller: fullNameController,
                    hintText: 'Product Name',
                    label: 'Full Name',
                    borderColor: MyColors.lightContainerColor,
                    validatorFn: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter product name';
                      }
                      return null;
                    },
                  ),
                  padding6,
                  CustomTextField(
                    borderRadius: 12.r,
                    controller: priceController,
                    hintText: 'Rs. Price',
                    label: 'Price',
                    borderColor: MyColors.lightContainerColor,
                    validatorFn: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter price';
                      }
                      return null;
                    },
                  ),
                  padding12,
                  Container(
                    height: 150.h,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: MyColors.lightContainerColor),
                    ),
                    child: TextFormField(
                      style: getLightStyle(
                          color: MyColors.black, fontSize: MyFonts.size13),
                      controller: descriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Write Description',
                        hintStyle: getLightStyle(
                            color: MyColors.black, fontSize: MyFonts.size12),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10.h),
                      ),
                    ),
                  ),
                  padding56,
                  CustomButton(
                    isLoading: ref.watch(pharmacyControllerProvider),
                    onPressed: widget.type == 'edit' ? updateProduct : insert,
                    backColor: MyColors.appColor1,
                    borderColor: MyColors.appColor1,
                    buttonText: 'Save & Continue',
                    borderRadius: 12.r,
                    buttonWidth: 295.w,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  insert() {
    if (key.currentState!.validate()) {
      ref.watch(pharmacyControllerProvider.notifier).insertProduct(
          model: ProductModel(
            productName: fullNameController.text,
            productPrice: priceController.text,
            productDescription: descriptionController.text,
            rating: '0',
            createdAt: DateTime.now(),
            likes: [],
            uid: FirebaseAuth.instance.currentUser!.uid,
          ),
          context: context,
          newImagePath: newImagePath!);
    }
  }

  updateProduct() {
    if (key.currentState!.validate()) {
      ref.watch(pharmacyControllerProvider.notifier).updateProduct(
            model: ProductModel.fromMap({
              ...widget.model!.toMap(),
              'productName': fullNameController.text,
              'productPrice': priceController.text,
              'productDescription': descriptionController.text,
            }),
            context: context,
            newImagePath: newImagePath!,
          );
    }
  }
}
