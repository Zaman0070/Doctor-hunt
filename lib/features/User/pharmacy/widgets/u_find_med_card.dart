import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/features/User/pharmacy/controller/u_pharmacy_controller.dart';
import 'package:doctor_app/models/product/products_model.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';

class UFindMedCard extends ConsumerStatefulWidget {
  const UFindMedCard({super.key, required this.model});
  final ProductModel model;

  @override
  ConsumerState<UFindMedCard> createState() => _UFindDoctorCardState();
}

class _UFindDoctorCardState extends ConsumerState<UFindMedCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Stack(
        children: [
          Container(
            height: 130.h,
            width: 335.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: MyColors.white,
              boxShadow: [
                BoxShadow(
                  color: MyColors.lightGreyColor.withOpacity(0.4),
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(AppConstants.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CachedRectangularNetworkImageWidget(
                          name: widget.model.productName!,
                          image: widget.model.productImage!,
                          width: 92,
                          height: 87),
                      padding12,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.model.productName!,
                              style: getMediumStyle(
                                  color: MyColors.black,
                                  fontSize: MyFonts.size18)),
                          padding2,
                          Container(
                            constraints: BoxConstraints(maxWidth: 170.w),
                            child: Text(widget.model.productDescription!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: getRegularStyle(
                                    color: MyColors.appColor1,
                                    fontSize: MyFonts.size13)),
                          ),
                          padding2,
                          Text('Rs ${widget.model.productPrice!.toString()}',
                              style: getMediumStyle(
                                  color: MyColors.black,
                                  fontSize: MyFonts.size14)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 25,
            child: CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.userOrderScreen,
                    arguments: {"productModel": widget.model});
              },
              buttonText: 'Buy',
              buttonHeight: 25.h,
              buttonWidth: 112.w,
              backColor: MyColors.appColor1,
              borderRadius: 4.r,
              fontSize: MyFonts.size12,
            ),
          ),
          Positioned(
            right: 20,
            top: 10,
            child: IconButton(
                onPressed: () {
                  ref
                      .watch(userPharmacyControllerProvider.notifier)
                      .likeDislikeProduct(
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          docId: widget.model.productId!);
                },
                icon: Icon(
                  widget.model.likes!
                          .contains(FirebaseAuth.instance.currentUser!.uid)
                      ? CupertinoIcons.heart_fill
                      : CupertinoIcons.heart,
                  color: widget.model.likes!
                          .contains(FirebaseAuth.instance.currentUser!.uid)
                      ? MyColors.red
                      : MyColors.lightContainerColor,
                  size: 24.r,
                )),
          ),
        ],
      ),
    );
  }
}
