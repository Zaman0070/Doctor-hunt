import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/models/product/products_model.dart';

class PProductCard extends StatelessWidget {
  const PProductCard({super.key, required this.model, required this.onPressed, required this.delete});
  final ProductModel model;
  final VoidCallback onPressed;
  final VoidCallback delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: MyColors.lightContainerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedRectangularNetworkImageWidget(
              image: model.productImage!,
              width: 150,
              height: 100,
            ),
            padding8,
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
            padding6,
            Text(
              'Rs. ${model.productPrice!}',
              style: getSemiBoldStyle(
                  color: MyColors.black, fontSize: MyFonts.size16),
            ),
            padding4,
            CustomButton(
              onPressed: onPressed,
              buttonText: 'Edit',
              buttonHeight: 25.h,
              borderRadius: 6.r,
              backColor: MyColors.appColor1,
              fontSize: MyFonts.size11,
            ),
            CustomButton(
              onPressed: delete,
              buttonText: 'Delete',
              buttonHeight: 25.h,
              borderRadius: 6.r,
              backColor: MyColors.red,
              fontSize: MyFonts.size11,
            )
          ],
        ),
      ),
    );
  }
}
