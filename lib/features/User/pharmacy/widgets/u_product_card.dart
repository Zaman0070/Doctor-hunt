import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/rating_bar.dart';
import 'package:doctor_app/models/product/products_model.dart';
import 'package:flutter/cupertino.dart';

class UProductCard extends StatelessWidget {
  const UProductCard({super.key, required this.model, required this.onPressed});
  final ProductModel model;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
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
                  onTap: () {},
                  child: const Icon(
                    CupertinoIcons.heart_fill,
                    color: MyColors.appColor1,
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
                      '4.5',
                      style: getSemiBoldStyle(
                          color: MyColors.black, fontSize: MyFonts.size10),
                    ),
                    padding4,
                    const CommonRatingBar(
                        rating: 4, ignoreGestures: true, padding: 2.5),
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
