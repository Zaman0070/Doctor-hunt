import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/rating_bar.dart';
import 'package:doctor_app/features/User/pharmacy/controller/u_pharmacy_controller.dart';
import 'package:doctor_app/models/product/products_model.dart';
import 'package:flutter/cupertino.dart';

class UProductCard extends ConsumerWidget {
  const UProductCard({super.key, required this.model, required this.onPressed});
  final ProductModel model;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: MyColors.lightContainerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedRectangularNetworkImageWidget(
                image: model.productImage!,
                width: 175,
                height: 100,
              ),
              Positioned(
                right: 10,
                top: 10,
                child: InkWell(
                  onTap: () {
                    ref
                        .read(userPharmacyControllerProvider.notifier)
                        .likeDislikeProduct(
                            docId: model.productId!,
                            userId: FirebaseAuth.instance.currentUser!.uid);
                  },
                  child: Icon(
                    model.likes!
                            .contains(FirebaseAuth.instance.currentUser!.uid)
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                    color: model.likes!
                            .contains(FirebaseAuth.instance.currentUser!.uid)
                        ? MyColors.red
                        : MyColors.lightGreyColor,
                  ),
                ),
              ),
            ],
          ),
          padding8,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.productName!,
                  style: getRegularStyle(
                      color: MyColors.black, fontSize: MyFonts.size12),
                ),
                padding4,
                Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  model.productDescription!,
                  style: getLightStyle(
                      color: MyColors.bodyTextColor, fontSize: MyFonts.size12),
                ),
                padding4,
                Text(
                  'Rs. ${model.productPrice!}',
                  style: getSemiBoldStyle(
                      color: MyColors.black, fontSize: MyFonts.size14),
                ),
                padding4,
                Row(
                  children: [
                    Text(
                      model.rating!.toString(),
                      style: getSemiBoldStyle(
                          color: MyColors.black, fontSize: MyFonts.size10),
                    ),
                    padding4,
                    CommonRatingBar(
                        rating: model.rating!,
                        ignoreGestures: true,
                        padding: 2.5),
                  ],
                ),
                CustomButton(
                  onPressed: onPressed,
                  buttonText: 'Buy',
                  buttonHeight: 30.h,
                  borderRadius: 6.r,
                  backColor: MyColors.appColor1,
                  fontSize: MyFonts.size13,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
